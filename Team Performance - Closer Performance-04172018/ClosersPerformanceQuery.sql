

--Avg time for OE
SELECT 
    Closer
    ,[Opportunities Id]
    ,[Opportunities Name]
    ,Tracking_Units
    ,RIGHT('0'+CONVERT( VARCHAR(5), [SumForOE_LogApp] / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumForOE_LogApp] / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumForOE_LogApp] % 60), 2) [AvgForOE_LogApp]
    ,RIGHT('0'+CONVERT( VARCHAR(5), [SumHowLongCloseDate_LogApp] / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumHowLongCloseDate_LogApp] / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumHowLongCloseDate_LogApp] % 60), 2) [HowLongCloseDate_LogApp]
    ,OES_LogApp [OES LogApp]
    ,RIGHT('0'+CONVERT( VARCHAR(5), [SumForOE_CRM] / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumForOE_CRM] / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumForOE_CRM] % 60), 2) [AvgForOE_CRM]
    ,datediff(day,First_OE, [Closing Date]) [DaysToCloseDate CRM]
    ,OES_CRM [OES CRM]
    ,NR_CRM [NR CRM]
FROM (
    SELECT  a.Closer
		  , a.[Opportunities Id]
		  , a.[Opportunities Name]
		  ,sum(tr.units) Tracking_Units
		  ,sum(datediff(second,tr.[start],tr.[end]))/COUNT(*) [SumForOE_LogApp]
		  ,sum(CASE WHEN a.Stage IN('Got Phone Number', 'Pursued Date But Got Number', 'Date Completely Scheduled Online')
			 THEN datediff(second,tr.[start],tr.[end])
			 ELSE 0
			 END) [SumHowLongCloseDate_LogApp]
		  --,sum(case when tr.taskusername is not null then 1 else 0 end) OES_LogApp
		  ,count(distinct tr.[created_time]) OES_LogApp
		  ,sum(datediff(second,c.[Created Time],c.[Closed Time]))/COUNT(*) [SumForOE_CRM]
		  ,min(c.[Closed Time]) First_OE
		  ,a.[Closing Date]
		  --,sum(case when c.[Related To] is not null then 1 else 0 end) OES_CRM
		  ,count(distinct c.[Task Id]) OES_CRM
		  --,sum(case when nr.[Related To] is not null then 1 else 0 end) NR_CRM
		  ,count(distinct nr.[Task Id]) NR_CRM
        FROM [VIDA].[dbo].[opportunities] a
             LEFT JOIN [TRACK].dbo.users b ON CASE
                                                  WHEN a.Closer IS NULL
                                                  THEN 'Missing'
                                                  ELSE a.Closer
                                              END = b.name
             INNER JOIN VIDA.dbo.sites d ON REPLACE(REPLACE(a.[Site], CHAR(13), ''), CHAR(10), '') = d.origin
		   inner join VIDA.dbo.accounts acc on acc.[Clients Id] = a.[Clients Id]
        inner JOIN
        (
            SELECT *
            FROM [VIDA].[dbo].[tasks]
            WHERE [Related To] IS NOT NULL
                  AND [Type] LIKE '%Outbound Email%' AND [Type] NOT LIKE '%NR%'
			   --group by [Related To], 
        ) c ON a.[Opportunities Id] = c.[Related To] and c.Closer = a.closer
        LEFT JOIN
        (
            SELECT *
            FROM [VIDA].[dbo].[tasks]
            WHERE [Related To] IS NOT NULL
                  AND [Type] LIKE '%nr%' and [Subject] LIKE '%nr%'
			  -- and [Subject] LIKE '%honda%'
        ) nr ON a.[Opportunities Id] = nr.[Related To] --and nr.Closer = a.closer
	   left JOIN 
	   (
		  select t.[created_time], t.[start],t.[end], USERS.[name] taskusername, clients.[name] clientName, t.units, sites.[site]
		  from TRACK.dbo.trackings t
		  inner join TRACK.dbo.tasks on tasks.task_id = t.task_id
		  inner join TRACK.dbo.sites on sites.site_id = t.site_id
		  inner join TRACK.dbo.users on users.user_id = t.user_id
		  inner join TRACK.dbo.clients on clients.client_id = t.client_id	
		  where tasks.task like '%outbound%email%'   
	   ) tr on tr.taskusername = a.closer and tr.clientName = acc.[Clients Name] 
		  and  convert( varchar, tr.[end],101 ) = convert( varchar, c.[Closed Time],101 )
		  and  tr.[site] = c.[site]
        WHERE 
		  a.Stage IN('Got Phone Number'
			 , 'Pursued Date But Got Number'
			 , 'Date Completely Scheduled Online'
			 , 'Numbers exchanged'
			 , 'Client Inactive'
			 , 'IC Deleted Profile'
			 , 'Closed Lost'
			 , 'Negative Response IE - SEND OE')
		  AND d.[Site] <> 'eHarmony'
            AND LTRIM(RTRIM(a.[Opportunities Name])) NOT LIKE 'SALES%'
		  AND a.closer = 'Alberto Orozco' -- is not null
		  --AND c.Closer IS NOT NULL
		  --and acc.[Clients Name] = 'Dan Graham' 
		  group by a.Closer, a.[Opportunities Id], a.[Opportunities Name], a.[Closing Date]
) t1
		  --order by c.[Modified Time]

		  --select top 10 * from vida.dbo.tasks where closer = 'Alberto Orozco' and [Related To] = 'zcrm_200867000047330009'


SELECT    *
        FROM [VIDA].[dbo].[opportunities] a
             LEFT JOIN [TRACK].dbo.users b ON CASE
                                                  WHEN a.Closer IS NULL
                                                  THEN 'Missing'
                                                  ELSE a.Closer
                                              END = b.name
             INNER JOIN VIDA.dbo.sites d ON REPLACE(REPLACE(a.[Site], CHAR(13), ''), CHAR(10), '') = d.origin
		   inner join VIDA.dbo.accounts acc on acc.[Clients Id] = a.[Clients Id]
        INNER JOIN
        (
            SELECT *
            FROM [VIDA].[dbo].[tasks]
            WHERE [Related To] IS NOT NULL
                  AND [Type] LIKE '%Outbound Email%'
        ) c ON a.[Opportunities Id] = c.[Related To] and c.Closer = a.closer
	   left JOIN 
	   (
		  select t.[start],t.[end], USERS.[name] taskusername, clients.[name] clientName, t.units
		  from TRACK.dbo.trackings t
		  inner join TRACK.dbo.tasks on tasks.task_id = t.task_id
		  inner join TRACK.dbo.sites on sites.site_id = t.site_id
		  inner join TRACK.dbo.users on users.user_id = t.user_id
		  inner join TRACK.dbo.clients on clients.client_id = t.client_id	   
	   ) tr on tr.taskusername = a.closer and tr.clientName = acc.[Clients Name] 
		  and  convert( varchar, tr.[end],101 ) = convert( varchar, c.[Closed Time],101 )
		  and  tr.[site] = c.[site]
        WHERE 
		  a.Stage IN('Got Phone Number'
			 , 'Pursued Date But Got Number'
			 , 'Date Completely Scheduled Online'
			 , 'Numbers exchanged'
			 , 'Client Inactive'
			 , 'IC Deleted Profile'
			 , 'Closed Lost'
			 , 'Negative Response IE - SEND OE')
		  AND d.[Site] <> 'eHarmony'
            AND LTRIM(RTRIM(a.[Opportunities Name])) NOT LIKE 'SALES%'
		  AND a.closer = 'Alberto Orozco'
		  AND  [Opportunities Id] = 'zcrm_200867000042736631'


            SELECT t.*
            FROM [VIDA].[dbo].[opportunities] a
		  inner join [VIDA].[dbo].[tasks] t on a.[Opportunities Id] = t.[Related To] and t.Closer = a.closer
		  INNER JOIN VIDA.dbo.sites d ON REPLACE(REPLACE(a.[Site], CHAR(13), ''), CHAR(10), '') = d.origin
            WHERE [Related To] IS NOT NULL
                  AND t.[Type] LIKE '%Outbound Email%' AND t.[Type] not LIKE '%non%'
			 --  and [Related To] = 'zcrm_200867000042194496'
			   and t.Closer = 'Alberto Orozco'
			   and a.[clients id] = 'zcrm_200867000041061015'
			   AND LTRIM(RTRIM([Opportunities Name])) NOT LIKE 'SALES%'  
				AND Stage IN('Got Phone Number'
				, 'Pursued Date But Got Number'
				, 'Date Completely Scheduled Online'
				, 'Numbers exchanged'
				, 'Client Inactive'
				, 'IC Deleted Profile'
				, 'Closed Lost'
				, 'Negative Response IE - SEND OE')
				AND d.[Site] <> 'eHarmony'
			   order by [Closed Time] 

		  select *--t.[created_time], t.[start],t.[end], USERS.[name] taskusername, clients.[name] clientName, t.units
		  from TRACK.dbo.trackings t
		  inner join TRACK.dbo.tasks on tasks.task_id = t.task_id
		  inner join TRACK.dbo.sites on sites.site_id = t.site_id
		  inner join TRACK.dbo.users on users.user_id = t.user_id
		  inner join TRACK.dbo.clients on clients.client_id = t.client_id	
		  where tasks.task like '%outbound%email%'   
			 and USERS.[name] = 'Alberto Orozco'
			 and clients.[name] = 'Bill Vivino'
			 order by t.[end]

			 --select * from track.dbo.clients where name = 'Bill Vivino'
			 select top 10 * from accounts where [clients name] = 'Bill Vivino'