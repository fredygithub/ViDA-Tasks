USE track;
GO
alter PROCEDURE dbo.get_clients_deposit_only_report_conversionrates
AS

DECLARE
  @FirstDateThreeMonths DATETIME=CAST( DATEADD( DAY, -DAY( GETDATE( ) )+1, CAST( DATEADD( m, -2, GETDATE( ) ) AS DATE ) ) AS DATETIME );

DECLARE
  @tmp_DepositBills TABLE
(
  created_time DATETIME,
  bill_date    DATETIME,
  client_id    BIGINT,
  hours        DECIMAL(5,2),
  package_name VARCHAR(25),
  client_name  VARCHAR(50),
  match_maker  VARCHAR(50));

INSERT INTO @tmp_DepositBills
       SELECT bills.created_time,
              bills.bill_date,
              bills.client_id,
              bills.hours,
              packages.package_name,
              clients.name,
              match_maker
       FROM TRACK.dbo.bills
       INNER JOIN
       TRACK.dbo.clients
       ON clients.client_id=bills.client_id
           LEFT JOIN
           TRACK.dbo.packages
           ON packages.monthly_hours=bills.hours
               OUTER APPLY
       (
         SELECT u.name match_maker
         FROM TRACK.dbo.clients_users cu
         INNER JOIN
         TRACK.dbo.users u
         ON cu.user_id=u.user_id
         WHERE cu.client_id=clients.client_id
               AND cu.[end]='9999-12-31 00:00:00.000'
       ) t
       WHERE packages.package_name LIKE '%deposit%'
             AND bill_date>@FirstDateThreeMonths
       ORDER BY client_id,
                bill_date;

DECLARE
  @tmp_DepositBillsWithNoPaymentsAfter TABLE
(
  created_time DATETIME,
  bill_date    DATETIME,
  client_id    BIGINT,
  hours        DECIMAL(5,2),
  package_name VARCHAR(25),
  client_name  VARCHAR(50),
  match_maker  VARCHAR(50));

INSERT INTO @tmp_DepositBillsWithNoPaymentsAfter
       SELECT created_time,
              bill_date,
              t.client_id,
              hours,
              package_name,
              client_name,
              match_maker
       FROM
       (
         SELECT DepositBills.*
         FROM @tmp_DepositBills DepositBills
         LEFT JOIN
         TRACK.dbo.bills
         ON DepositBills.client_id=bills.client_id
            AND DepositBills.bill_date<bills.bill_date
             LEFT JOIN
             TRACK.dbo.packages
             ON packages.monthly_hours=bills.hours
       ) t
       ORDER BY client_id,
                bill_date;

DECLARE
  @tmp_NotDepositBills TABLE
(
  created_time DATETIME,
  bill_date    DATETIME,
  client_id    BIGINT,
  hours        DECIMAL(5,2),
  package_name VARCHAR(25),
  client_name  VARCHAR(50),
  match_maker  VARCHAR(50));

INSERT INTO @tmp_NotDepositBills
       SELECT created_time,
              bill_date,
              client_id,
              hours,
              package_name,
              name,
              match_maker
       FROM
       (
         SELECT bills.created_time,
                bills.bill_date,
                bills.client_id,
                bills.hours,
                packages.package_name,
                clients.name,
                t.match_maker,
                ROW_NUMBER( ) OVER( PARTITION BY bills.client_id ORDER BY bills.bill_date ASC )
         AS RowNumber
         FROM TRACK.dbo.bills
         INNER JOIN
         TRACK.dbo.clients
         ON clients.client_id=bills.client_id
             LEFT JOIN
             @tmp_DepositBillsWithNoPaymentsAfter DepositBills
             ON DepositBills.client_id=clients.client_id
                 LEFT JOIN
                 TRACK.dbo.packages
                 ON packages.monthly_hours=bills.hours
                     OUTER APPLY
         (
           SELECT u.name match_maker
           FROM TRACK.dbo.clients_users cu
           INNER JOIN
           TRACK.dbo.users u
           ON cu.user_id=u.user_id
           WHERE cu.client_id=clients.client_id
                 AND cu.[end]='9999-12-31 00:00:00.000'
         ) t
         WHERE DepositBills.client_id IS NULL
       ) BillsTurnedIntoPackage
       WHERE BillsTurnedIntoPackage.RowNumber=1
             AND bill_date>@FirstDateThreeMonths
             AND hours>15
       ORDER BY client_id,
                bill_date;

SELECT ISNULL( NotDepositBills.MonthPeriod, Deposit.MonthPeriod )                                                                                                                       MonthPeriod,
       CAST( CAST( NotDepositBills.countPeriod AS DECIMAL(5,2) )/CAST( ISNULL( Deposit.countPeriod, 0 )+ISNULL( NotDepositBills.countPeriod, 0 ) AS DECIMAL(5,2) ) AS DECIMAL(5,2) ) convRate
FROM
(
  SELECT RIGHT( CONVERT( VARCHAR(10), bill_date, 103 ), 7 ) MonthPeriod,
         COUNT( * )                                         countPeriod
  FROM @tmp_NotDepositBills
  GROUP BY RIGHT( CONVERT( VARCHAR(10), bill_date, 103 ), 7 )
) NotDepositBills
FULL OUTER JOIN
(
  SELECT RIGHT( CONVERT( VARCHAR(10), bill_date, 103 ), 7 ) MonthPeriod,
         COUNT( * )                                         countPeriod
  FROM @tmp_DepositBillsWithNoPaymentsAfter
  GROUP BY RIGHT( CONVERT( VARCHAR(10), bill_date, 103 ), 7 )
) Deposit
ON NotDepositBills.MonthPeriod=Deposit.MonthPeriod
UNION
SELECT 'Total'                                                                    MonthPeriod,
       CAST( CAST(
                 (
                   SELECT COUNT( * )
                   FROM @tmp_NotDepositBills
                 ) AS DECIMAL(5,2) )/CAST(
                                          (
                                            SELECT COUNT( * )
                                            FROM @tmp_DepositBillsWithNoPaymentsAfter
                                          )+
                                          (
                                            SELECT COUNT( * )
                                            FROM @tmp_NotDepositBills
                                          ) AS DECIMAL(5,2) ) AS DECIMAL(5,2) ) convRate;