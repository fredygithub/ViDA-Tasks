USE TRACK
GO

/*
alter table track.dbo.payroll_client
add constraint uc_payroll_client_month UNIQUE ([client], [month])
*/

	TRUNCATE TABLE track.dbo.payroll_client
	INSERT INTO track.dbo.payroll_client

		SELECT

		right(totals.[month], 4) + '-' + left(totals.[month], 2) as [Month],

		totals.[name] as Client,

		case when totals.active = 1 then 'Yes' else 'No' end as [Client Active Now],

		(totals.[AM / VA Team Lead Hs]
		+[TL - AM / VA Team Lead Hs]
		+totals.[Closer Hours Hs]
		+totals.[AM / VA Other Hs]
		+totals.[AM Sales Hs]
		+totals.[Mobile App Hours Hs]
		+totals.[SMS/Texting Hs]
		+totals.[Writing Team Lead Hs]
		+totals.[New Writer Training Hs]
		+totals.[Blogging Hs]
		+totals.[Gold+ Profiles Hs]
		+totals.[Writing Other Hs]
		+totals.[Day Off Online Dating Closing Hs]
		+totals.[Day Off Mobile App Hs]
		+totals.[Profile Editing Hs]
		+totals.[SOP Updates Hs]) as [Total Hs Paid],

		(totals.[AM / VA Team Lead Amount]
		+[TL - AM / VA Team Lead Amount]
		+totals.[Closer Hours Amount]
		+totals.[AM / VA Other Amount]
		+totals.[AM Sales Amount]
		+totals.[Mobile App Hours Amount]
		+totals.[SMS/Texting Amount]
		+totals.[Writing Team Lead Amount]
		+totals.[New Writer Training Amount]
		+totals.[Blogging Amount]
		+totals.[Gold+ Profiles Amount]
		+totals.[Writing Other Amount]
		+totals.[Day Off Online Dating Closing Amount]
		+totals.[Day Off Mobile App Amount]
		+totals.[Profile Editing Amount]
		+totals.[SOP Updates Amount]
		+totals.[Asked For Date & Got Phone Number Amount]
		+totals.[Date Completely Scheduled Online Amount]
		+totals.[Got Phone Number Amount]
		+totals.[Commission]
		+totals.POSITIVES
		-totals.NEGATIVES)  as [Total Amount Paid to Team Members],

		(client_bills.amount) as [Total Amount Paid by Client],

		(client_bills.amount) -
		(totals.[AM / VA Team Lead Amount]
		+[TL - AM / VA Team Lead Amount]
		+totals.[Closer Hours Amount]
		+totals.[AM / VA Other Amount]
		+totals.[AM Sales Amount]
		+totals.[Mobile App Hours Amount]
		+totals.[SMS/Texting Amount]
		+totals.[Writing Team Lead Amount]
		+totals.[New Writer Training Amount]
		+totals.[Blogging Amount]
		+totals.[Gold+ Profiles Amount]
		+totals.[Writing Other Amount]
		+totals.[Day Off Online Dating Closing Amount]
		+totals.[Day Off Mobile App Amount]
		+totals.[Profile Editing Amount]
		+totals.[SOP Updates Amount]
		+totals.[Asked For Date & Got Phone Number Amount]
		+totals.[Date Completely Scheduled Online Amount]
		+totals.[Got Phone Number Amount]
		+totals.[Commission]
		+totals.POSITIVES
		-totals.NEGATIVES)  as Balance,

		

		(totals.[AM / VA Team Lead Hs]+[TL - AM / VA Team Lead Hs]) as [AM / VA Team Lead Hs],
		(totals.[Closer Hours Hs]) as [Closer Hours Hs],
		(totals.[AM / VA Other Hs]) as [AM / VA Other Hs],
		(totals.[AM Sales Hs]) as [AM Sales Hs],
		(totals.[Mobile App Hours Hs]) as [Mobile App Hours Hs],
		(totals.[SMS/Texting Hs]) as [SMS/Texting Hs],
		(totals.[Writing Team Lead Hs]) as [Writing Team Lead Hs],
		(totals.[New Writer Training Hs]) as [New Writer Training Hs],
		(totals.[Blogging Hs]) as [Blogging Hs],
		(totals.[Gold+ Profiles Hs]) as [Gold+ Profiles Hs],
		(totals.[Writing Other Hs]) as [Writing Other Hs],
		(totals.[Day Off Online Dating Closing Hs]) as [Day Off Online Dating Closing Hs],
		(totals.[Day Off Mobile App Hs]) as [Day Off Mobile App Hs],
		(totals.[Profile Editing Hs]) as [Profile Editing Hs],
		(totals.[SOP Updates Hs]) as [SOP Updates Hs],


		(totals.[AM / VA Team Lead Amount]+[TL - AM / VA Team Lead Amount]) as [AM / VA Team Lead Amount],

		(totals.[Closer Hours Amount]) as [Closer Hours Amount],

		(totals.[AM / VA Other Amount]) as [AM / VA Other Amount],

		(totals.[AM Sales Amount]) as [AM Sales Amount],

		(totals.[Mobile App Hours Amount]) as [Mobile App Hours Amount],

		(totals.[SMS/Texting Amount]) as [SMS/Texting Amount],

		(totals.[Writing Team Lead Amount]) as [Writing Team Lead Amount],

		(totals.[New Writer Training Amount]) as [New Writer Training Amount],

		(totals.[Blogging Amount]) as [Blogging Amount],

		(totals.[Gold+ Profiles Amount]) as [Gold+ Profiles Amount],

		(totals.[Writing Other Amount]) as [Writing Other Amount],

		(totals.[Day Off Online Dating Closing Amount]) as [Day Off Online Dating Closing Amount],

		(totals.[Day Off Mobile App Amount]) as [Day Off Mobile App Amount],
		
		(totals.[Profile Editing Amount]) as [Profile Editing Amount],
		
		(totals.[SOP Updates Amount]) as [SOP Updates Amount],

		(totals.[Asked For Date & Got Phone Number Amount]) as [Asked For Date & Got Phone Number Amount],

		(totals.[Date Completely Scheduled Online Amount]) as [Date Completely Scheduled Online Amount],

		(totals.[Got Phone Number Amount]) as [Got Phone Number Amount],

		(totals.[Commission]) as [Commission],

		client_bills.package_hours as [Last Package Hours],

		isnull(packs.package_name, 'Other') as [Last Package Name],

		isnull(packs.package_color, '#ffffff') as [Last Package Color],

		client_bills.mm as [MatchMaker],

		(totals.[POSITIVES]) as [VA Commission Positives Amount],

		(totals.[NEGATIVES]) as [VA Commission Negatives Amount]




		FROM (
				SELECT 
				client_data.[month],

				client_data.name,

				client_data.active,

				sum(case when entries.[task_group] = 'AM / VA Team Lead' and entries.task not like 'TL%' and entries.task not like 'PD%' then entries.total_time else 0. end)/60. as [AM / VA Team Lead Hs],
				sum(case when entries.[task_group] = 'AM / VA Team Lead' and entries.task not like 'TL%' and entries.task not like 'PD%' then entries.total_time else 0. end * pay.[AM / VA Team Lead Rate])/60. as [AM / VA Team Lead Amount],

				sum(case when entries.[task_group] = 'AM / VA Team Lead' and (entries.task like 'TL%' or entries.task like 'PD%') then entries.total_time else 0. end)/60. as [TL - AM / VA Team Lead Hs],
				sum(case when entries.[task_group] = 'AM / VA Team Lead' and (entries.task like 'TL%' or entries.task like 'PD%') then entries.total_time else 0. end * pay.[AM / VA Team Lead Rate])/60. as [TL - AM / VA Team Lead Amount],

				sum(case when entries.[task_group] = 'Closer Hours' then entries.total_time else 0. end)/60. as [Closer Hours Hs],
				sum(case when entries.[task_group] = 'Closer Hours' then entries.total_time else 0. end * pay.[Closer Hours Rate])/60. as [Closer Hours Amount],

				sum(case when entries.[task_group] = 'AM / VA Other' and entries.task <> 'Sales' then entries.total_time else 0. end)/60. as [AM / VA Other Hs],
				sum(case when entries.[task_group] = 'AM / VA Other' and entries.task <> 'Sales' then entries.total_time else 0. end * pay.[AM / VA Other Rate])/60. as [AM / VA Other Amount],

				sum(case when entries.[task_group] = 'AM / VA Other' and entries.task = 'Sales' then entries.total_time else 0. end)/60. as [AM Sales Hs],
				sum(case when entries.[task_group] = 'AM / VA Other' and entries.task = 'Sales' then entries.total_time else 0. end * pay.[AM / VA Other Rate])/60. as [AM Sales Amount],

				sum(case when entries.[task_group] = 'Mobile App Hours' then entries.total_time else 0. end)/60. as [Mobile App Hours Hs],
				sum(case when entries.[task_group] = 'Mobile App Hours' then entries.total_time else 0. end * pay.[Mobile App Hours Rate])/60. as [Mobile App Hours Amount],

				sum(case when entries.[task_group] = 'SMS/Texting' then entries.total_time else 0. end)/60. as [SMS/Texting Hs],
				sum(case when entries.[task_group] = 'SMS/Texting' then entries.total_time else 0. end * pay.[SMS/Texting Rate])/60. as [SMS/Texting Amount],

				sum(case when entries.[task_group] = 'Writing Team Lead' then entries.total_time else 0. end)/60. as [Writing Team Lead Hs],
				sum(case when entries.[task_group] = 'Writing Team Lead' then entries.total_time else 0. end * pay.[Writing Team Lead Rate])/60. as [Writing Team Lead Amount],

				sum(case when entries.[task_group] = 'New Writer Training' then entries.total_time else 0. end)/60. as [New Writer Training Hs],
				sum(case when entries.[task_group] = 'New Writer Training' then entries.total_time else 0. end * pay.[New Writer Training Rate])/60. as [New Writer Training Amount],

				sum(case when entries.[task_group] = 'Blogging' then entries.total_time else 0. end)/60. as [Blogging Hs],
				sum(case when entries.[task_group] = 'Blogging' then entries.total_time else 0. end * pay.[Blogging Rate])/60. as [Blogging Amount],

				sum(case when entries.[task_group] = 'Gold+ Profiles' then entries.total_time else 0. end)/60. as [Gold+ Profiles Hs],
				sum(case when entries.[task_group] = 'Gold+ Profiles' then entries.total_time else 0. end * pay.[Gold+ Profiles Rate])/60. as [Gold+ Profiles Amount],

				sum(case when entries.[task_group] = 'Writing Other' then entries.total_time else 0. end)/60. as [Writing Other Hs],
				sum(case when entries.[task_group] = 'Writing Other' then entries.total_time else 0. end * pay.[Writing Other Rate])/60. as [Writing Other Amount],

				sum(case when entries.[task_group] = 'Day Off Online Dating Closing' then entries.total_time else 0. end)/60. as [Day Off Online Dating Closing Hs],
				sum(case when entries.[task_group] = 'Day Off Online Dating Closing' then entries.total_time else 0. end * pay.[Day Off Online Dating Closing Rate])/60. as [Day Off Online Dating Closing Amount],

				sum(case when entries.[task_group] = 'Day Off Mobile App' then entries.total_time else 0. end)/60. as [Day Off Mobile App Hs],
				sum(case when entries.[task_group] = 'Day Off Mobile App' then entries.total_time else 0. end * pay.[Day Off Mobile App Rate])/60. as [Day Off Mobile App Amount],
		
				sum(case when entries.[task_group] = 'Profile Editing' then entries.total_time else 0. end)/60. as [Profile Editing Hs],
				sum(case when entries.[task_group] = 'Profile Editing' then entries.total_time else 0. end * pay.[Profile Editing Rate])/60. as [Profile Editing Amount],
		
				sum(case when entries.[task_group] = 'SOP Updates' then entries.total_time else 0. end)/60. as [SOP Updates Hs],
				sum(case when entries.[task_group] = 'SOP Updates' then entries.total_time else 0. end * pay.[SOP Updates Rate])/60. as [SOP Updates Amount],
				
				isnull(avg(nullif(client_data.[Asked For Date & Got Phone Number Amount], 0)), 0) as [Asked For Date & Got Phone Number Amount],

				isnull(avg(nullif(client_data.[Date Completely Scheduled Online Amount], 0)), 0) as [Date Completely Scheduled Online Amount],

				isnull(avg(nullif(client_data.[Got Phone Number Amount], 0)), 0) as [Got Phone Number Amount],

				isnull(avg(nullif(client_data.[Commission], 0)), 0) as [Commission],

				isnull(avg(nullif(client_data.[POSITIVES], 0)), 0) as [POSITIVES],

				isnull(avg(nullif(client_data.[NEGATIVES], 0)), 0) as [NEGATIVES]

				FROM (

					SELECT
					c.name,
					c.active,
					a.[bill_date],
					a.[bill_date_end],
					format(a.bill_date, 'MM/yyyy') as [month],
					isnull(closer_comm.[Asked For Date & Got Phone Number Amount], 0) as [Asked For Date & Got Phone Number Amount],
					isnull(closer_comm.[Date Completely Scheduled Online Amount], 0) as [Date Completely Scheduled Online Amount],
					isnull(closer_comm.[Got Phone Number Amount], 0) as [Got Phone Number Amount],
					isnull(am_comm.[Commission], 0) as [Commission],
					isnull(va_comm.[POSITIVES], 0) as [POSITIVES],
					isnull(va_comm.[NEGATIVES], 0) as [NEGATIVES]
					FROM [TRACK].[dbo].[bills] a
					inner join [TRACK].[dbo].[clients] c on a.client_id = c.client_id
					
					outer apply (

					 select 
					 sum(case when ccc.[Stage] = 'Pursued Date But Got Number' then ccc.Quant * cpay.[Asked For Date & Got Phone Number Rate] else 0. end) as [Asked For Date & Got Phone Number Amount],
					 sum(case when ccc.[Stage] = 'Date Completely Scheduled Online' then ccc.Quant * cpay.[Date Completely Scheduled Online Rate] else 0. end) as [Date Completely Scheduled Online Amount],
					 sum(case when ccc.[Stage] = 'Got Phone Number' then ccc.Quant * cpay.[Got Phone Number Rate] else 0. end) as [Got Phone Number Amount]
					 from [VIDA].[dbo].[closer_commission_client] ccc
					 inner join [TRACK].[dbo].[payroll] cpay 
					 on ltrim(rtrim(ccc.closer)) = ltrim(rtrim(cpay.[user_name]))  
					 and (case 
						when (datepart(DD, ccc.[Commission Date]) between 1 and 15) then format(ccc.[Commission Date], 'MM/yyyy') + ' - first 15 days'
						else format(ccc.[Commission Date], 'MM/yyyy') + ' - last 15 days' end = cpay.[month]

					 or cpay.[month] = format(ccc.[Commission Date], 'MM/yyyy'))

					 and cpay.deleted = 0
					 	
					 where ltrim(rtrim(ccc.Client)) = ltrim(rtrim(c.name)) 
					 and ccc.[Commission Date] >= a.bill_date and ccc.[Commission Date] < a.bill_date_end

					 ) closer_comm
					
					outer apply (

					 select 
					 sum(vc.POSITIVES*cpay.[VA Commission Positives Rate]) as [POSITIVES],
					 sum(vc.NEGATIVES*cpay.[VA Commission Negatives Rate]) as [NEGATIVES]
					 from [VIDA].[dbo].[va_commission] vc
					 inner join [TRACK].[dbo].[payroll] cpay 
					 on ltrim(rtrim(vc.Assistant)) = ltrim(rtrim(cpay.[user_name]))  
					 and (vc.[Month] = cpay.[month]

					 or cpay.[month] = left(vc.[Month], 7))

					 and cpay.deleted = 0
					 	
					 where ltrim(rtrim(vc.Client)) = ltrim(rtrim(c.name)) 
					 and vc.[Date] >= a.bill_date and vc.[Date] < a.bill_date_end

					 ) va_comm

					 cross apply (

					  SELECT sum([Commission]) as Commission
					  FROM [TRACK].[dbo].[REPORT_commission]
					  where [Client] = c.name
					  and [Payment Date] = a.bill_date
					  
					  ) am_comm
					 
					 where a.bill_date >= '2017-01-01' 
					and a.bill_date >= dateadd(mm, -6, getdate())
					and c.name <> 'None'
					and bill_date_end is not null
					and format(a.bill_date, 'MM/yyyy') <= 
						(SELECT max([month])
						FROM [TRACK].[dbo].[payroll]
						where len([month]) = 7 and deleted = 0)

					) client_data
				
				
				inner join [TRACK].[dbo].[REPORT_employee_time_log_entries] entries
				on client_data.name = entries.name and entries.[start_date] >= client_data.bill_date and entries.[start_date] < client_data.bill_date_end

				inner join [TRACK].[dbo].[payroll] pay 
				on entries.[user_name] = pay.[user_name] 
				and (case 
						when (datepart(DD, entries.[start_date]) between 1 and 15) then format(entries.[start_date], 'MM/yyyy') + ' - first 15 days'
						else format(entries.[start_date], 'MM/yyyy') + ' - last 15 days' end = pay.[month]

					or pay.[month] = format(entries.[start_date], 'MM/yyyy'))

				and pay.deleted = 0			
				
				group by
				client_data.[month],

				client_data.name,

				client_data.active

				) totals

				INNER JOIN (

				SELECT
					c.name,
					d.name as mm,
					format(a.bill_date, 'MM/yyyy') as [month],
					sum(a.[hours]) as package_hours,
					sum(a.[amount]+a.[amount_upsell]) as amount
					FROM [TRACK].[dbo].[bills] a
					inner join [TRACK].[dbo].[clients] c on a.client_id = c.client_id 
					inner join [TRACK].[dbo].[users] d on c.[user_id] = d.[user_id]
					where a.bill_date >= '2017-01-01' 
					and a.bill_date >= dateadd(mm, -6, getdate())
					and c.name <> 'None'
					and bill_date_end is not null
					and format(a.bill_date, 'MM/yyyy') <= 
						(SELECT max([month])
						FROM [TRACK].[dbo].[payroll]
						where len([month]) = 7 and deleted = 0)
					group by
					c.name,
					d.name,
					format(a.bill_date, 'MM/yyyy')

				) client_bills on totals.name = client_bills.name and totals.[month] = client_bills.[month]

				LEFT JOIN [TRACK].[dbo].[packages] as packs on packs.monthly_hours = client_bills.package_hours