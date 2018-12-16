

--Avg time for OE
SELECT 
    Closer
    ,[Opportunities Id]
    ,Tracking_Units
    ,RIGHT('0'+CONVERT( VARCHAR(5), [SumForOE_LogApp] / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumForOE_LogApp] / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumForOE_LogApp] % 60), 2) [AvgForOE_LogApp]
    ,RIGHT('0'+CONVERT( VARCHAR(5), [SumHowLongCloseDate_LogApp] / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumHowLongCloseDate_LogApp] / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumHowLongCloseDate_LogApp] % 60), 2) [HowLongCloseDate_LogApp]
    ,Tracking_OES
    ,RIGHT('0'+CONVERT( VARCHAR(5), [SumForOE_CRM] / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumForOE_CRM] / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumForOE_CRM] % 60), 2) [AvgForOE_CRM]
    ,CRM_OES
FROM (
    SELECT  a.Closer
		  , a.[Opportunities Id]
		  --,sum(tr.units) Tracking_Units
		  --,sum(datediff(second,tr.[start],tr.[end]))/COUNT(*) [SumForOE_LogApp]
		  /*,sum(CASE WHEN a.Stage IN('Got Phone Number', 'Pursued Date But Got Number', 'Date Completely Scheduled Online')
			 THEN datediff(second,tr.[start],tr.[end])
			 ELSE 0
			 END) [SumHowLongCloseDate_LogApp]*/
		  --,sum(case when tr.taskusername is not null then 1 else 0 end) Tracking_OES
		  ,sum(datediff(second,c.[Created Time],c.[Closed Time]))/COUNT(*) [SumForOE_CRM]
		  ,sum(case when c.[Related To] is not null then 1 else 0 end) CRM_OES
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
	   --left JOIN 
	   --(
		  --select t.[start],t.[end], USERS.[name] taskusername, clients.[name] clientName, t.units
		  --from TRACK.dbo.trackings t
		  --inner join TRACK.dbo.tasks on tasks.task_id = t.task_id
		  --inner join TRACK.dbo.sites on sites.site_id = t.site_id
		  --inner join TRACK.dbo.users on users.user_id = t.user_id
		  --inner join TRACK.dbo.clients on clients.client_id = t.client_id	   
	   --) tr on tr.taskusername = a.closer and tr.clientName = acc.[Clients Name] 
		  --and  convert( varchar, tr.[end],101 ) = convert( varchar, c.[Closed Time],101 )
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
		  and acc.[Clients Name] = 'Phu Vu' 
		  group by a.Closer, a.[Opportunities Id]
) t1
		  --order by c.[Modified Time]
		  where [tracking_oes] <> [crm_oes]
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









    SELECT a.[Opportunities Name], a.[Stage], a.[Closer], acc.[clients name], tasks.[subject], tasks.[type], tasks.[created time], tasks.[closed time]
    		  ,a.Assistant
    FROM [VIDA].[dbo].[opportunities] a
             LEFT JOIN [TRACK].dbo.users b ON CASE
                                                  WHEN a.Closer IS NULL
                                                  THEN 'Missing'
                                                  ELSE a.Closer
                                              END = b.name
             INNER JOIN VIDA.dbo.sites d ON REPLACE(REPLACE(a.[Site], CHAR(13), ''), CHAR(10), '') = d.origin
		   inner join VIDA.dbo.accounts acc on acc.[Clients Id] = a.[Clients Id]
		   inner join [VIDA].[dbo].[tasks] ON a.[Opportunities Id] = tasks.[Related To] and tasks.Closer = a.closer
    WHERE [Related To] IS NOT NULL
	  AND tasks.[Type] LIKE '%Outbound Email%'
	   --and a.closer = 'Alberto Orozco'
	   and a.[opportunities name] = 'Dan Graham-S_Anne_'
	   --and tasks.closer = 'Alberto Orozco'
	   and acc.[Clients Name] = 'Dan Graham' 
	   order by [closed time]

		 
 select  t.[created_time], tasks.task, USERS.[name] taskusername, clients.[name] clientName, t.units, t.[start],t.[end]
		  from TRACK.dbo.trackings t
		  inner join TRACK.dbo.tasks on tasks.task_id = t.task_id
		  inner join TRACK.dbo.sites on sites.site_id = t.site_id
		  inner join TRACK.dbo.users on users.user_id = t.user_id
		  inner join TRACK.dbo.clients on clients.client_id = t.client_id	   
	   where
		  USERS.[name] = 'Alberto Orozco' and 
		  clients.[name] = 'Dan Graham'
		  and t.task_id IN(60, 103, 131, 263)
		  AND t.site_id <> 17 -- Outbound Emails
		  and [task] LIKE '%Outbound Email%'
        order by t.[end]	   		  

 select  t.[created_time], tasks.task, USERS.[name] taskusername, clients.[name] clientName, t.units, t.[start],t.[end]
		  from TRACK.dbo.trackings t
		  inner join TRACK.dbo.tasks on tasks.task_id = t.task_id
		  inner join TRACK.dbo.sites on sites.site_id = t.site_id
		  inner join TRACK.dbo.users on users.user_id = t.user_id
		  inner join TRACK.dbo.clients on clients.client_id = t.client_id	   
	   where
		  USERS.[name] = 'Ben Gebler' and 
		  clients.[name] = 'Dan Graham'
		  and t.task_id IN(60, 103, 131, 263)
		  AND t.site_id <> 17 -- Outbound Emails
		  and [task] LIKE '%Outbound Email%'
        order by t.[end]	

