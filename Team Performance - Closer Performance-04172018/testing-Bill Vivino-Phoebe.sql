SELECT --*
    Closer
    ,[Opportunities Id]
    ,[Opportunities Name]
    , sum(case when [RowNum] = 1 then 1 else 0 end) Tracking_Units
    ,RIGHT('0'+CONVERT( VARCHAR(5), [SumForOE_LogApp] / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumForOE_LogApp] / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumForOE_LogApp] % 60), 2) [AvgForOE_LogApp]
    ,RIGHT('0'+CONVERT( VARCHAR(5), [SumHowLongCloseDate_LogApp] / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumHowLongCloseDate_LogApp] / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumHowLongCloseDate_LogApp] % 60), 2) [HowLongCloseDate_LogApp]
    ,OES_LogApp [OES LogApp]
    ,RIGHT('0'+CONVERT( VARCHAR(5), [SumForOE_CRM] / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumForOE_CRM] / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumForOE_CRM] % 60), 2) [AvgForOE_CRM]
    ,datediff(day,First_OE, [Closing Date]) [DaysToCloseDate CRM]
    ,OES_CRM [OES CRM]
    ,NR_CRM [NR CRM]
FROM (
    SELECT --c.*, tr.*
		  
		   a.Closer
		  , a.[Opportunities Id]
		  , a.[Opportunities Name]
		  , ROW_NUMBER() OVER (PARTITION BY c.[Task Id], tr.[end] ORDER BY c.[Closed time]) [RowNum]
		 -- ,sum(tr.units) Tracking_Units
		  ,sum(datediff(second,tr.[start],tr.[end]))/COUNT(*) [SumForOE_LogApp]
		  ,sum(CASE WHEN a.Stage IN('Got Phone Number', 'Pursued Date But Got Number', 'Date Completely Scheduled Online')
			 THEN datediff(second,tr.[start],tr.[end])
			 ELSE 0
			 END) [SumHowLongCloseDate_LogApp]
		  ,count(distinct tr.[created_time]) OES_LogApp
		  ,sum(datediff(second,c.[Created Time],c.[Closed Time]))/COUNT(*) [SumForOE_CRM]
		  ,min(c.[Closed Time]) First_OE
		  ,a.[Closing Date]
		  ,count(distinct c.[Task Id]) OES_CRM
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
		  select t.[created_time], t.[start],t.[end], USERS.[name] taskusername, clients.[name] clientName, t.units, sites.[site] [site2]
		  from TRACK.dbo.trackings t
		  inner join TRACK.dbo.tasks on tasks.task_id = t.task_id
		  inner join TRACK.dbo.sites on sites.site_id = t.site_id
		  inner join TRACK.dbo.users on users.user_id = t.user_id
		  inner join TRACK.dbo.clients on clients.client_id = t.client_id	
		  where tasks.task like '%outbound%email%'   
	   ) tr on tr.taskusername = a.closer and tr.clientName = acc.[Clients Name] 
		  and  convert( varchar, tr.[end],101 ) = convert( varchar, c.[Closed Time],101 )
		  and  tr.[site2] = c.[site]
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
		  --group by a.Closer, a.[Opportunities Id], a.[Opportunities Name], a.[Closing Date]
		  and a.[Opportunities Name] ='Bill Vivino-Phoebe'
		  group by a.Closer, a.[Opportunities Id], a.[Opportunities Name], c.[Closed Time]
) t1



SELECT 
    Closer
    ,[Opportunities Id]
    ,[Opportunities Name]
    , sum(case when [RowNum] = 1 then 1 else 0 end) Tracking_Units
    ,RIGHT('0'+CONVERT( VARCHAR(5), sum(datediff(second,[start],[end]))/COUNT(*) / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), sum(datediff(second,[start],[end]))/COUNT(*) / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), sum(datediff(second,[start],[end]))/COUNT(*) % 60), 2) [AvgForOE_LogApp]
    ,RIGHT('0'+CONVERT( VARCHAR(5), sum(CASE WHEN Stage IN('Got Phone Number', 'Pursued Date But Got Number', 'Date Completely Scheduled Online') THEN datediff(second,[start],[end]) ELSE 0 END) / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), sum(CASE WHEN Stage IN('Got Phone Number', 'Pursued Date But Got Number', 'Date Completely Scheduled Online') THEN datediff(second,[start],[end]) ELSE 0 END) / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), sum(CASE WHEN Stage IN('Got Phone Number', 'Pursued Date But Got Number', 'Date Completely Scheduled Online') THEN datediff(second,[start],[end]) ELSE 0 END) % 60), 2) [HowLongCloseDate_LogApp]
    ,count(distinct [tr_created_time]) [OES LogApp]
    ,RIGHT('0'+CONVERT( VARCHAR(5), sum(datediff(second,[Created Time],[Closed Time]))/COUNT(*) / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), sum(datediff(second,[Created Time],[Closed Time]))/COUNT(*) / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), sum(datediff(second,[Created Time],[Closed Time]))/COUNT(*) % 60), 2) [AvgForOE_CRM]
    ,datediff(day,min([Closed Time]), max([Closed Time])) [DaysToCloseDate CRM]
    ,count(distinct [Task Id]) [OES CRM]
    ,count(distinct [NrTask Id]) [NR CRM]
FROM (
    SELECT  a.Closer
		  , a.Stage
		  , a.[Opportunities Id]
		  , a.[Opportunities Name]
		  , ROW_NUMBER() OVER (PARTITION BY c.[Task Id], tr.[end] ORDER BY c.[Closed time]) [RowNum]
		  ,tr.[start]
		  ,tr.[end]
		  ,c.[Closed Time]
		  ,c.[Task Id] 
		  ,c.[Created Time]
		  ,nr.[Task Id] [NrTask Id]
		  ,tr.[created_time] [tr_created_time]
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
        ) c ON a.[Opportunities Id] = c.[Related To] and c.Closer = a.closer
        LEFT JOIN
        (
            SELECT *
            FROM [VIDA].[dbo].[tasks]
            WHERE [Related To] IS NOT NULL
                  AND [Type] LIKE '%nr%' and [Subject] LIKE '%nr%'
        ) nr ON a.[Opportunities Id] = nr.[Related To] and nr.Closer = a.closer
	   left JOIN 
	   (
		  select t.[created_time], t.[start],t.[end], USERS.[name] taskusername, clients.[name] clientName, t.units, sites.[site] [site2]
		  from TRACK.dbo.trackings t
		  inner join TRACK.dbo.tasks on tasks.task_id = t.task_id
		  inner join TRACK.dbo.sites on sites.site_id = t.site_id
		  inner join TRACK.dbo.users on users.user_id = t.user_id
		  inner join TRACK.dbo.clients on clients.client_id = t.client_id	
		  where tasks.task like '%outbound%email%'   
	   ) tr on tr.taskusername = a.closer and tr.clientName = acc.[Clients Name] 
		  and  convert( varchar, tr.[end],101 ) = convert( varchar, c.[Closed Time],101 )
		  and  tr.[site2] = c.[site]
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
		  --and a.[Opportunities Name] ='Bill Vivino-Phoebe'
		  AND acc.[Clients Name] = 'Bill Vivino' 

		  
) t1 group by Closer, [Opportunities Id], [Opportunities Name]