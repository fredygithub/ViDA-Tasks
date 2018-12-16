use TRACK
go


CREATE PROCEDURE dbo.get_clients_deposit_only_report
AS

declare @FirstDateThreeMonths DATETIME = CAST(DATEADD(DAY,-DAY(GETDATE())+1, CAST(DATEADD(m, -3,GETDATE()) AS DATE)) AS DATETIME),
	   @FirstDateCurrentMonth DATETIME = CAST(DATEADD(DAY,-DAY(GETDATE())+1, CAST(GETDATE() AS DATE)) AS DATETIME);


declare @tmp_DepositBills table (created_time datetime, bill_date datetime, client_id bigint, hours float, package_name varchar(25), client_name varchar(50), match_maker varchar(50))
insert into @tmp_DepositBills
select bills.created_time, bills.bill_date, bills.client_id , bills.hours, packages.package_name, clients.name, match_maker
from bills
    INNER join clients on clients.client_id = bills.client_id
    left join packages on packages.monthly_hours = bills.hours   
    outer apply(
		  SELECT u.name match_maker
		  FROM [TRACK].[dbo].[clients_users] cu
		  inner join [TRACK].[dbo].[users] u on cu.[user_id] = u.[user_id] 
		  where cu.client_id = clients.client_id and cu.[end] =  '9999-12-31 00:00:00.000'
	   ) t
    where
	   packages.package_name like '%deposit%' and
	   bill_date > @FirstDateThreeMonths and
	   bill_date < @FirstDateCurrentMonth
    order by client_id, bill_date


declare @tmp_DepositBillsWithNoPaymentsAfter table (created_time datetime, bill_date datetime, client_id bigint, hours float, package_name varchar(25), client_name varchar(50), match_maker varchar(50))
insert into @tmp_DepositBillsWithNoPaymentsAfter
select created_time, bill_date, t.client_id, hours, package_name, client_name, match_maker
from (
    select DepositBills.*
	   from @tmp_DepositBills DepositBills 
		  left JOIN bills ON DepositBills.client_id = bills.client_id and DepositBills.bill_date< bills.bill_date
		  left join packages on packages.monthly_hours = bills.hours
	   ) t 
	   order by client_id, bill_date

select match_maker [Matchmaker], client_name [Client Name], package_name [Package (Deposit only)], convert(varchar(10),bill_date,101) [Date Paid] 
from @tmp_DepositBillsWithNoPaymentsAfter
order by match_maker, client_name, bill_date


