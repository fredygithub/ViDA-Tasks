use TRACK
go

DECLARE @LastTreeMonth DATETIME = DATEADD(DAY, -90, GETDATE());
SELECT @LastTreeMonth
--SELECT        'All' AS name, GETDATE() AS [firstPayrollPeriod]
--UNION ALL
select name, bill_date [firstPayrollPeriod], maxBillDate
    from (
  select clients.name, bills.bill_date, clients.active, 
  ROW_NUMBER() OVER(PARTITION BY bills.client_id ORDER BY bill_date ASC) 
    AS RowNumber, maxBillDate
    from TRACK.dbo.clients
  left join bills  on clients.client_id = bills.client_id
 -- WHERE ACTIVE =1
  ) t 
  where RowNumber=1   
    AND bill_date >= @LastTreeMonth
  order by name

   select clients.name, bills.bill_date, clients.active, 
  ROW_NUMBER() OVER(PARTITION BY bills.client_id ORDER BY bill_date ASC) 
    AS RowNumber
    from TRACK.dbo.clients
  left join bills  on clients.client_id = bills.client_id
  WHERE name = 'Ada Cooper'


DECLARE
  @LastTreeMonth DATETIME = DATEADD( DAY, -90, GETDATE( ))

--SELECT        'All' AS name, GETDATE() AS [firstPayrollPeriod]
--UNION ALL
select name, client, active, [firstPayrollPeriod]
    from (
  select clients.name, payroll_client.client, clients.active, case when [Month] is not null then cast([Month]+'-01' as date) else '01/01/1800' end [firstPayrollPeriod],
  ROW_NUMBER() OVER(PARTITION BY payroll_client.client ORDER BY case when [Month] is not null then cast([Month]+'-01' as date) else null end ASC) 
    AS RowNumber, [Month] 
    from clients
  left join payroll_client  on clients.name = payroll_client.client
  ) t 
  where --(RowNumber=1 AND [firstPayrollPeriod]>=@LastTreeMonth) OR
 [Month] is null AND ACTIVE =1
  order by name

  SELECT *  FROM payroll_client where client = 'AJ Goldstein'