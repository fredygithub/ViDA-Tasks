--Date / Number Preference	(No column name)
--Prefers Phone Number	358
--Preferes Phone Number	44
--NULL	1740
--No Preference	205
--Prefers Date	429
---None-	1
    
    SELECT  a.Closer,a.Stage
		  , a.[Opportunities Name]
		  ,acc.[Date / Number Preference]
		  ,sum(datediff(second,c.[Created Time],c.[Closed Time]))/*/COUNT(*)*/ [SumForOE_CRM]
		  ,count(distinct c.[Task Id]) OES_CRM
		  ,count(distinct nr.[Task Id]) NR_CRM
		  ,case when a.Stage in ('Got Phone Number','Pursued Date But Got Number','Date Completely Scheduled Online') then datediff(day,min(c.[Closed Time]), [Closing Date]) else 0 end [DaysToCloseDate_CRM]
		  ,sum(case when a.Stage in ('Got Phone Number','Pursued Date But Got Number','Date Completely Scheduled Online') and c.[Closed Time]< [Closing Date] then 1 else 0 end) [OESToCloseDate_CRM]
		  ,sum(case when a.Stage in ('Got Phone Number','Pursued Date But Got Number','Date Completely Scheduled Online') and nr.[Closed Time]< [Closing Date] then 1 else 0 end) [NRToCloseDate_CRM]
		  ,count(distinct a.[Closing Date]) OppCount
		  ,case when a.Stage in ('Got Phone Number','Pursued Date But Got Number','Date Completely Scheduled Online') then 1 else 0 end CloseDateOpp
		  ,case 
		  when a.Stage in ('Got Phone Number','Pursued Date But Got Number') and acc.[Date / Number Preference] LIKE '%phone%' then 1 
		  when a.Stage = 'Date Completely Scheduled Online' and acc.[Date / Number Preference] LIKE '%Date%' then 1
		  when a.Stage in ('Got Phone Number','Pursued Date But Got Number','Date Completely Scheduled Online') AND (acc.[Date / Number Preference] LIKE '%No%Preference%' OR acc.[Date / Number Preference] IS NULL) then 1
		  else 0 end [AchievingClients_Pref]
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
        WHERE 
		  a.Stage IN('Got Phone Number'
			 , 'Pursued Date But Got Number'
			 , 'Date Completely Scheduled Online'
			 , 'Numbers exchanged' --?
			 , 'Client Inactive'
			 , 'IC Deleted Profile'
			 , 'Closed Lost'
			 , 'Negative Response IE - SEND OE')
		  AND d.[Site] <> 'eHarmony'
            AND LTRIM(RTRIM(a.[Opportunities Name])) NOT LIKE 'SALES%'
		  AND a.closer = 'Alberto Orozco' -- is not null
		  --and a.[Opportunities Name] ='Bill Vivino-Phoebe'
		  and acc.[Clients Name]  = 'Bill Vivino'
		  group by a.Closer,acc.[Date / Number Preference], a.[Opportunities Name], a.Stage, a.[Closing Date]

--Avg time for OE
SELECT 
    Closer
    ,sum(OppCount) [Total OppCount]
    ,RIGHT('0'+CONVERT( VARCHAR(5), sum([SumForOE_CRM])/SUM(OES_CRM) / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), sum([SumForOE_CRM])/SUM(OES_CRM) / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), sum([SumForOE_CRM])/SUM(OES_CRM) % 60), 2) [AvgHsForOE CRM]
    ,SUM(OES_CRM) [OES CRM]
    ,SUM(NR_CRM) [NR CRM]
    ,SUM(CloseDateOpp) [CloseDate Count]
    ,CAST(CAST(SUM([DaysToCloseDate_CRM]) AS DECIMAL(10,2))/CAST(SUM(CloseDateOpp) AS DECIMAL(10,2)) AS DECIMAL(10,2)) [DaysToCloseDate CRM]
    ,CAST(CAST(SUM([OESToCloseDate_CRM]) AS DECIMAL(10,2))/CAST(SUM(CloseDateOpp) AS DECIMAL(10,2)) AS DECIMAL(10,2)) [OESToCloseDate CRM]
    ,CAST(CAST(SUM([NRToCloseDate_CRM]) AS DECIMAL(10,2))/CAST(SUM(CloseDateOpp) AS DECIMAL(10,2)) AS DECIMAL(10,2)) [NRToCloseDate CRM]
    ,CAST((CAST(SUM([AchievingClients_Pref]) AS DECIMAL(10,2))*100)/CAST(SUM(CloseDateOpp) AS DECIMAL(10,2)) AS DECIMAL(10,2)) [AchievingClients Pref %]
FROM (
    SELECT  a.Closer,a.Stage
		  , a.[Opportunities Name]
		  ,sum(datediff(second,c.[Created Time],c.[Closed Time]))/*/COUNT(*)*/ [SumForOE_CRM]
		  ,count(distinct c.[Task Id]) OES_CRM
		  ,count(distinct nr.[Task Id]) NR_CRM
		  ,case when a.Stage in ('Got Phone Number','Pursued Date But Got Number','Date Completely Scheduled Online') then datediff(day,min(c.[Closed Time]), [Closing Date]) else 0 end [DaysToCloseDate_CRM]
		  ,sum(case when a.Stage in ('Got Phone Number','Pursued Date But Got Number','Date Completely Scheduled Online') and c.[Closed Time]< [Closing Date] then 1 else 0 end) [OESToCloseDate_CRM]
		  ,sum(case when a.Stage in ('Got Phone Number','Pursued Date But Got Number','Date Completely Scheduled Online') and nr.[Closed Time]< [Closing Date] then 1 else 0 end) [NRToCloseDate_CRM]
		  ,count(distinct a.[Closing Date]) OppCount
		  ,case when a.Stage in ('Got Phone Number','Pursued Date But Got Number','Date Completely Scheduled Online') then 1 else 0 end CloseDateOpp
		  ,case 
		  when a.Stage in ('Got Phone Number','Pursued Date But Got Number') and acc.[Date / Number Preference] LIKE '%phone%' then 1 
		  when a.Stage = 'Date Completely Scheduled Online' and acc.[Date / Number Preference] LIKE '%Date%' then 1
		  when a.Stage in ('Got Phone Number','Pursued Date But Got Number','Date Completely Scheduled Online') AND (acc.[Date / Number Preference] LIKE '%No%Preference%' OR acc.[Date / Number Preference] IS NULL) then 1
		  else 0 end [AchievingClients_Pref]
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
        WHERE 
		  a.Stage IN('Got Phone Number'
			 , 'Pursued Date But Got Number'
			 , 'Date Completely Scheduled Online'
			 , 'Numbers exchanged' --?
			 , 'Client Inactive'
			 , 'IC Deleted Profile'
			 , 'Closed Lost'
			 , 'Negative Response IE - SEND OE')
		  AND d.[Site] <> 'eHarmony'
            AND LTRIM(RTRIM(a.[Opportunities Name])) NOT LIKE 'SALES%'
		  AND a.closer = 'Alberto Orozco' -- is not null
		  --and a.[Opportunities Name] ='Bill Vivino-Phoebe'
		  and acc.[Clients Name]  = 'Bill Vivino'
		  group by a.Closer, acc.[Date / Number Preference], a.Stage, a.[Opportunities Name],a.[Closing Date]
) t1 group by Closer


    SELECT 
	   Closer
	   --,[Opportunities Id]
	   --,[Opportunities Name]
	   ,[Tracking Units Total]
	   ,RIGHT('0'+CONVERT( VARCHAR(5), [SumForOE_LogApp] / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumForOE_LogApp] / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumForOE_LogApp] % 60), 2) [AvgForOE LogApp]
--	   ,RIGHT('0'+CONVERT( VARCHAR(5), [SumHowLongCloseDate_LogApp] / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumHowLongCloseDate_LogApp] / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumHowLongCloseDate_LogApp] % 60), 2) [HowLongCloseDate_LogApp]
	   ,[OES_LogApp] [OES LogApp]
    FROM (
		  SELECT 
			 a.Closer
			 --, a.[Opportunities Id]
			 --, a.[Opportunities Name]
			 ,acc.[Clients Name] 
			 ,sum(tr.units) [Tracking Units Total]
			 ,sum(datediff(second,tr.[start],tr.[end]))/COUNT(*) [SumForOE_LogApp]
			 --,sum(CASE WHEN a.Stage IN('Got Phone Number', 'Pursued Date But Got Number', 'Date Completely Scheduled Online')
				--THEN datediff(second,tr.[start],tr.[end])
				--ELSE null
				--END) [SumHowLongCloseDate_LogApp]
			 ,count(distinct tr.[created_time]) [OES_LogApp]
		  FROM (
			 SELECT DISTINCT Closer, [Clients Id]
			 FROM [VIDA].[dbo].[opportunities] 
			 WHERE Closer = 'Alberto Orozco' -- is not null		
				AND LTRIM(RTRIM([Opportunities Name])) NOT LIKE 'SALES%'  
				AND Stage IN('Got Phone Number'
				, 'Pursued Date But Got Number'
				, 'Date Completely Scheduled Online'
				, 'Numbers exchanged'
				, 'Client Inactive'
				, 'IC Deleted Profile'
				, 'Closed Lost'
				, 'Negative Response IE - SEND OE')
			 ) a
				INNER JOIN [TRACK].dbo.users b ON CASE
                                                  WHEN a.Closer IS NULL
                                                  THEN 'Missing'
                                                  ELSE a.Closer
                                              END = b.name
             --INNER JOIN VIDA.dbo.sites d ON REPLACE(REPLACE(a.[Site], CHAR(13), ''), CHAR(10), '') = d.origin
		   INNER JOIN VIDA.dbo.accounts acc on acc.[Clients Id] = a.[Clients Id]
		   LEFT JOIN 
		  (
			 select  t.[created_time], t.[start],t.[end], USERS.[name] taskusername, clients.[name] clientName, t.units, sites.[site] 
			 from TRACK.dbo.trackings t
			 inner join TRACK.dbo.tasks on tasks.task_id = t.task_id
			 inner join TRACK.dbo.sites on sites.site_id = t.site_id
			 inner join TRACK.dbo.users on users.user_id = t.user_id
			 inner join TRACK.dbo.clients on clients.client_id = t.client_id	
			 where tasks.task like '%outbound%email%'   
		  ) tr on tr.taskusername = a.closer and tr.clientName = acc.[Clients Name] 
		  WHERE 
			 [Site] <> 'eHarmony'			 
			 and acc.[Clients Name]  = 'Bill Vivino'
		  group by a.Closer,acc.[Clients Name] --, a.[Opportunities Id], a.[Opportunities Name],acc.[Clients Name] 
    ) t2