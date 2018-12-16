--create table testTable(id int identity, name varchar(50))
use TRACk
go

declare @tmp_DepositBills table (created_time datetime, bill_date datetime, client_id bigint, hours float, package_name varchar(25), client_name varchar(50))
insert into @tmp_DepositBills
select bills.created_time, bills.bill_date, bills.client_id , bills.hours, packages.package_name, clients.name
from bills
    INNER join clients on clients.client_id = bills.client_id
    left join packages on packages.monthly_hours = bills.hours    
    where
	   packages.package_name like '%deposit%' and
	   bill_date > '08/01/2018'
    order by client_id, bill_date

select count(*) from @tmp_DepositBills

select convert(varchar(10),[Deposit BillDate],101) [Deposit BillDate], client_name ,convert(varchar(10),t.bill_date,101) other_bill_date, t.client_id, t.hours, t.package_name
from (
    select bills.created_time, bills.bill_date, bills.client_id, bills.hours, packages.package_name, DepositBills.client_name, DepositBills.bill_date [Deposit BillDate]
	   ,ROW_NUMBER() OVER(PARTITION BY bills.client_id ORDER BY bills.bill_date ASC) AS RowNumber
	   from @tmp_DepositBills DepositBills 
		  left JOIN bills ON DepositBills.client_id = bills.client_id and DepositBills.bill_date< bills.bill_date
		  left join packages on packages.monthly_hours = bills.hours
	   ) t 
	   order by t.client_id, t.bill_date

select client_name ,convert(varchar(10),t.bill_date,101) bill_date, t.client_id, t.hours, t.package_name
--select  t.bill_date, t.client_id, t.hours, t.package_name, client_name, [Deposit BillDate]
from (
    select bills.created_time, bills.bill_date, bills.client_id, bills.hours, packages.package_name, DepositBills.client_name, DepositBills.bill_date [Deposit BillDate]
	   ,ROW_NUMBER() OVER(PARTITION BY bills.client_id ORDER BY bills.bill_date ASC) AS RowNumber
	   from @tmp_DepositBills DepositBills 
		  left JOIN bills ON DepositBills.client_id = bills.client_id --and DepositBills.bill_date< bills.bill_date
		  left join packages on packages.monthly_hours = bills.hours
	   ) t 
	   order by t.client_id, t.bill_date



select tmpDeposit_bills.*, t.* 
from @tmpDeposit_bills tmpDeposit_bills
    left join  
    (
	select *
	from (
	   select bills.created_time, bills.bill_date, bills.client_id, bills.hours, packages.package_name, clients.name--bills.* , clients.name, packages.*
	   ,ROW_NUMBER() OVER(PARTITION BY bills.client_id ORDER BY bill_date ASC) AS RowNumber
	   from bills
		  INNER join clients on clients.client_id = bills.client_id
		  left join packages on packages.monthly_hours = bills.hours    
		  ) t
		  order by client_id, bill_date
		  where RowNumber=2
    ) t
	   on tmpDeposit_bills.client_id = t.client_id 

--select * from packages where packages.package_name like '%deposit%'




