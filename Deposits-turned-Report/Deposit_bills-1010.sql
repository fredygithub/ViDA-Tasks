--create table testTable(id int identity, name varchar(50))
use TRACk
go

declare @tmp_DepositBills table (created_time datetime, bill_date datetime, client_id bigint, hours float, package_name varchar(25), client_name varchar(50), match_maker varchar(50))
insert into @tmp_DepositBills
select bills.created_time, bills.bill_date, bills.client_id , bills.hours, packages.package_name, clients.name, match_maker
from bills
    INNER join clients on clients.client_id = bills.client_id
    left join packages on packages.monthly_hours = bills.hours    
    outer apply(select ltrim(rtrim(isnull(users.[First Name],'') + ' '+ isnull(users.[Last Name],''))) match_maker
			 from vida.dbo.accounts acct 
			 inner join vida.dbo.users on users.[User Id]=acct.[Clients Owner Id]
			 where acct.[clients name]= clients.name) t
    where
	   packages.package_name like '%deposit%' and
	   bill_date > '08/01/2018'
    order by client_id, bill_date

    select * from vida.dbo.accounts where [clients name] like '%kar%' --'James Graybill'
    select * from clients where name like '%bir%' --'James Graybill'

    select accounts.[clients name] [Vida client name], accounts.[created time], clients.name [Track client name]/*accounts.[clients name] [Vida client name], clients.name [Track client name]*/ from vida.dbo.accounts full outer JOIN track.dbo.clients on clients.name= accounts.[clients name] 
    where accounts.[clients name] is null or clients.name is null
    order by accounts.[clients name], clients.name 


    select *
    from
    (
    select accounts.[clients name] [Vida client name] from vida.dbo.accounts left join track.dbo.clients on clients.name= accounts.[clients name] 
	   where clients.name is null 
	   order by accounts.[clients name], clients.name 
	   ) crm
    LEFT JOIN
    (
    select clients.name [Track client name] from vida.dbo.accounts right JOIN track.dbo.clients on clients.name= accounts.[clients name] 
    where accounts.[clients name] is null order by accounts.[clients name], clients.name 
    ) track on 

    select count(*)/*accounts.[clients name]*/ [Vida client name] from vida.dbo.accounts --3137
    select count(*)/*clients.name [Track client name]*/  from track.dbo.clients --3073
    full outer JOIN clients on clients.name= accounts.[clients name] order by accounts.[clients name], clients.name 



    --select * from vida.dbo.users where [Last Name] like '%rosa%'

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

select * from @tmp_DepositBillsWithNoPaymentsAfter

/*
--declare @tmp_AllBills table (created_time datetime, bill_date datetime, client_id bigint, hours float, package_name varchar(25), client_name varchar(50))
--insert into @tmp_AllBills
select CONVERT(CHAR(7),notdeposit.bill_date,120) month_period, convert(varchar(10),notdeposit.bill_date,101) bill_date, notdeposit.package_name, notdeposit.client_name
from (
    select bills.created_time, bills.bill_date, bills.client_id , bills.hours, packages.package_name, clients.name [client_name]
    ,ROW_NUMBER() OVER(PARTITION BY bills.client_id ORDER BY bills.bill_date ASC) AS RowNumber
    from bills
	   INNER join clients on clients.client_id = bills.client_id
	   left join packages on packages.monthly_hours = bills.hours  
	   left join @tmp_DepositBillsWithNoPaymentsAfter deposit on deposit.client_id = bills.client_id
	   where
		  packages.package_name not like '%profile%' and
		  bills.bill_date > '08/01/2018'
	   --order by bills.client_id, bills.bill_date
    ) notdeposit where RowNumber=1
union
select CONVERT(CHAR(7),bill_date,120) month_period, convert(varchar(10),bill_date,101) bill_date, package_name, client_name from @tmp_DepositBillsWithNoPaymentsAfter

SELECT month_period, sum(case when package_name like '%deposit%' then 1 else 0 end) [total_deposit]
    , sum(case when package_name not like '%deposit%' then 1 else 0 end) [total_others] 
    ,count(*) total_clients
FROM (
select CONVERT(CHAR(7),notdeposit.bill_date,120) month_period, convert(varchar(10),notdeposit.bill_date,101) bill_date, notdeposit.package_name, notdeposit.client_name
from (
    select bills.created_time, bills.bill_date, bills.client_id , bills.hours, packages.package_name, clients.name [client_name]
    ,ROW_NUMBER() OVER(PARTITION BY bills.client_id ORDER BY bills.bill_date ASC) AS RowNumber
    from bills
	   INNER join clients on clients.client_id = bills.client_id
	   left join packages on packages.monthly_hours = bills.hours  
	   left join @tmp_DepositBillsWithNoPaymentsAfter deposit on deposit.client_id = bills.client_id
	   where
		  packages.package_name not like '%profile%' and
		  bills.bill_date > '08/01/2018'
	   --order by bills.client_id, bills.bill_date
    ) notdeposit where RowNumber=1
union
select CONVERT(CHAR(7),bill_date,120) month_period, convert(varchar(10),bill_date,101) bill_date, package_name, client_name 
from @tmp_DepositBillsWithNoPaymentsAfter

) totals
    group by month_period

    select top 100 * from vida.dbo.accounts where [clients name]= 'Arvind Sarin'*/