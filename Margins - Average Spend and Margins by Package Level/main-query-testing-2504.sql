use track
go

SELECT        Month, Client, [Client Active Now], [Total Hs Paid], [Total Amount Paid to Team Members], [Total Amount Paid by Client], Balance, [Last Package Name], [Last Package Color], [Last Package Hours]
FROM            payroll_client AS a
WHERE        ([Last Package Name] NOT IN ('Deposit', 'Other', 'Profile', 'Copper')) AND (Client = 'Alex Rodriguez')

    SELECT [Month],
		 Client,
		 [Client Active Now],
		 [Total Hs Paid],
		 [Total Amount Paid to Team Members],
		 [Total Amount Paid by Client],
		 Balance,
		 [Last Package Name],
		 [Last Package Color],
		 [Last Package Hours]
    FROM payroll_client AS a
    WHERE([Last Package Name] NOT IN('Deposit', 'Other', 'Profile', 'Copper'))
    AND (Client = 'Alex Rodriguez')
    AND ([Month]= @DatePeriod OR @DatePeriod= 'All');


SELECT
a.[Client],
--max(a.[Month]) [Last Package Period],
--a.[Month],
--count(a.[Month]) Periods,
--a.[Client Active Now],
--sum(a.[Total Hs Paid]) [Total Hs Paid],
--sum(a.[Total Amount Paid to Team Members]) [Total Amount Paid to Team Members], -- total spend
--sum(a.[Total Amount Paid by Client]) [Total Amount Paid by Client], -- gross profit
--sum(a.[Balance]) [Balance],
a.[Total Hs Paid],
a.[Total Amount Paid to Team Members],
a.[Total Amount Paid by Client],
a.[Balance],
a.[Last Package Name] [Package Name],
a.[Last Package Color] [Package Color],
a.[Last Package Hours] [Package Hours]
FROM [TRACK].[dbo].[payroll_client] a
where a.[Last Package Name] not in ('Deposit', 'Other', 'Profile', 'Copper')
--and a.[Last Package Name] = 'Bronze'
    and a.client = 'Jorgen Lien'--'Alex Rodriguez'
    group by 
	   a.[Client], a.[Last Package Name], a.[Last Package Color], a.[Last Package Hours]

SELECT *
FROM [TRACK].[dbo].[payroll_client] a
where a.[Last Package Name] not in ('Deposit', 'Other', 'Profile', 'Copper')
--and a.[Last Package Name] = 'Bronze'
     and a.client = 'Jorgen Lien'--'Alon Honig'--'Alex Rodriguez'

SELECT
					c.name,
					d.name as mm,
					format(a.bill_date, 'MM/yyyy') as [month],
					case when format(a.bill_date, 'MM/yyyy') <= 
						(SELECT max([month])
						FROM [TRACK].[dbo].[payroll]
						where len([month]) = 7 and deleted = 0) then format(a.bill_date, 'MM/yyyy') +'>='+ cast(dateadd(mm, -6, getdate()) as varchar)
						else 'filter' end [last6months],
					case when format(a.bill_date, 'MM/yyyy') <= 
						(SELECT max([month])
						FROM [TRACK].[dbo].[payroll]
						where len([month]) = 7 and deleted = 0) then format(a.bill_date, 'MM/yyyy')+'<='+(SELECT max([month])
						FROM [TRACK].[dbo].[payroll]
						where len([month]) = 7 and deleted = 0)
						else 'filter' end [maxMonthPrior],
					sum(a.[hours]) as package_hours,
					sum(a.[amount]+a.[amount_upsell]) as amount
					FROM [TRACK].[dbo].[bills] a
					inner join [TRACK].[dbo].[clients] c on a.client_id = c.client_id 
					inner join [TRACK].[dbo].[users] d on c.[user_id] = d.[user_id]
					where a.bill_date >= '2017-01-01' 
					--and a.bill_date >= dateadd(mm, -6, getdate())
					and c.name <> 'None'
					and c.name = 'Jorgen Lien'--'Alex Rodriguez'
					and bill_date_end is not null
					and format(a.bill_date, 'MM/yyyy') <= 
						(SELECT max(cast(left([month],2)+'/01/'+substring([month],4,4) as datetime))
						FROM [TRACK].[dbo].[payroll]
						where len([month]) = 7 and deleted = 0
						)
					group by
					c.name,
					d.name,
					format(a.bill_date, 'MM/yyyy')

	  


SELECT *
FROM [TRACK].[dbo].[bills] a
					inner join [TRACK].[dbo].[clients] c on a.client_id = c.client_id
					inner join track.dbo.packages p on p.monthly_hours = a.[hours]
					WHERE C.name = 'Jorgen Lien'-- 'Alon Honig'--'Alex Rodriguez'
					and a.bill_date >= '2017-01-01' 
SELECT *
FROM [TRACK].[dbo].[bills] a
					inner join [TRACK].[dbo].[clients] c on a.client_id = c.client_id
 where a.bill_date >= '2017-01-01' 
					and a.bill_date >= dateadd(mm, -6, getdate())
					and c.name <> 'None'
					and bill_date_end is not null
					and format(a.bill_date, 'MM/yyyy') <= 
						(SELECT max([month])
						FROM [TRACK].[dbo].[payroll] 
						where len([month]) = 7 and deleted = 0)


SELECT
count(a.[Month]) Periods,
--a.[Client Active Now],
sum(a.[Total Hs Paid]) [Total Hs Paid],
sum(a.[Total Amount Paid to Team Members]) [Total Amount Paid to Team Members], -- total spend
sum(a.[Total Amount Paid by Client]) [Total Amount Paid by Client], -- gross profit
sum(a.[Balance]) [Balance],
a.[Last Package Name] [Package Name],
a.[Last Package Color] [Package Color],
a.[Last Package Hours] [Package Hours]
FROM [TRACK].[dbo].[payroll_client] a
where a.[Last Package Name] not in ('Deposit', 'Other', 'Profile', 'Copper')
    and a.client = 'Alex Rodriguez'
    group by 
	   a.[Last Package Name], a.[Last Package Color], a.[Last Package Hours]


   select client, [last package name], count(*) cnt  
   FROM [TRACK].[dbo].[payroll_client] 
   where 
	    [Last Package Name] not in ('Deposit', 'Other', 'Profile', 'Copper')
   group by client, [last package name]
   order by client, [last package name], count(*)