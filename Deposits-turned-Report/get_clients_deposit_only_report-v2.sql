USE track;
GO
alter PROCEDURE dbo.get_clients_deposit_only_report
AS


DECLARE @FirstDateThreeMonths  DATETIME=CAST( DATEADD( DAY, -DAY( GETDATE( ) )+1, CAST( DATEADD( m, -2, GETDATE( ) ) AS DATE ) ) AS DATETIME )

DECLARE @tmp_DepositBills TABLE
(created_time DATETIME,
 bill_date    DATETIME,
 bill_amount  FLOAT,
 client_id    BIGINT,
 hours        FLOAT,
 package_name VARCHAR(25),
 client_name  VARCHAR(50),
 match_maker  VARCHAR(50)
);
INSERT INTO @tmp_DepositBills
       SELECT bills.created_time,
              bills.bill_date,
		    bills.amount,
              bills.client_id,
              bills.hours,
              packages.package_name,
              clients.name,
              match_maker
       FROM TRACK.dbo.bills
            INNER JOIN TRACK.dbo.clients ON clients.client_id = bills.client_id
            LEFT JOIN TRACK.dbo.packages ON packages.monthly_hours = bills.hours
            OUTER APPLY
       (
           SELECT u.name match_maker
           FROM TRACK.dbo.clients_users cu
                INNER JOIN TRACK.dbo.users u ON cu.user_id = u.user_id
           WHERE cu.client_id = clients.client_id
                 AND cu.[end] = '9999-12-31 00:00:00.000'
       ) t
       WHERE packages.package_name LIKE '%deposit%'
             AND bill_date > @FirstDateThreeMonths
       ORDER BY client_id,
                bill_date;


DECLARE @tmp_DepositBillsWithNoPaymentsAfter TABLE
(created_time DATETIME,
 bill_date    DATETIME,
 bill_amount  FLOAT,
 client_id    BIGINT,
 hours        FLOAT,
 package_name VARCHAR(25),
 client_name  VARCHAR(50),
 match_maker  VARCHAR(50)
);
INSERT INTO @tmp_DepositBillsWithNoPaymentsAfter
       SELECT created_time,
              bill_date,
		    bill_amount,
              t.client_id,
              hours,
              package_name,
              client_name,
              match_maker
       FROM
       (
           SELECT DepositBills.*
           FROM @tmp_DepositBills DepositBills
                LEFT JOIN TRACK.dbo.bills ON DepositBills.client_id = bills.client_id
                                   AND DepositBills.bill_date < bills.bill_date
                LEFT JOIN TRACK.dbo.packages ON packages.monthly_hours = bills.hours
       ) t
       ORDER BY client_id,
                bill_date;
SELECT match_maker Matchmaker,
       client_name ClientName,
       package_name PackageDepositonly,
       CONVERT( VARCHAR(10), bill_date, 101) DatePaid,
	  bill_amount AmountPaid,
       RIGHT(CONVERT(   VARCHAR(10), bill_date, 103), 7) MonthPaid
FROM @tmp_DepositBillsWithNoPaymentsAfter
ORDER BY match_maker,
         bill_date,
         client_name;

