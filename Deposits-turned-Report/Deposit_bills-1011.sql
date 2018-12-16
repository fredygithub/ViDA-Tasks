--create table testTable(id int identity, name varchar(50))
use TRACk
go

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
    --outer apply(select ltrim(rtrim(isnull(users.[First Name],'') + ' '+ isnull(users.[Last Name],''))) match_maker
			 --from vida.dbo.accounts acct 
			 --inner join vida.dbo.users on users.[User Id]=acct.[Clients Owner Id]
			 --where acct.[clients name]= clients.name) t
    where
	   packages.package_name like '%deposit%' and
	   bill_date > '08/01/2018' and
	   bill_date < '10/01/2018'
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


    select *
    from
    (
    select accounts.[clients name] [Vida client name] from vida.dbo.accounts left join track.dbo.clients on clients.name= accounts.[clients name] 
	   where clients.name is null 
	   ) crm
    FULL OUTER JOIN
    (
    select clients.name [Track client name] from vida.dbo.accounts right JOIN track.dbo.clients on clients.name= accounts.[clients name] 
    where accounts.[clients name] is null 
    ) track on LEFT(REPLACE([Vida client name],' ' ,''), 6) LIKE LEFT(REPLACE([Track client name],' ' ,''),6)
    order by [Vida client name], [Track client name]
