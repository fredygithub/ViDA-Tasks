--Date / Number Preference	(No column name)
--Prefers Phone Number	358
--Preferes Phone Number	44
--NULL	1740
--No Preference	205
--Prefers Date	429
---None-	1
    
DECLARE @Closer varchar(50)= 'Alberto Orozco' --'Ben Jenks';'Connor Moran'--
    declare @MobileApp varchar(5) = 'NO'
    declare @LastTreeMonth datetime
    SELECT @LastTreeMonth = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 2, 0)
/*
--> VIDA.dbo.Account --> Gender field
select Gender, count(*) cnt from Vida.dbo.Accounts group by Gender
select [Min Age], [Max Age], count(*) cnt from Vida.dbo.Accounts group by [Min Age], [Max Age]
select top 100 * from Vida.dbo.Accounts 

--select top 1000 * from Vida.dbo.Accounts where Gender is null

-->Male/Female
    Male- 4
    Female- 2
    I


-->Profile Tone (only considering avg of 1st)
    1- Strong Attn Grabber
    2- Over the Top
    3- Humorous
    4- Down to Earth
    5- Warm and Friendly

-->Age (opposite for male and female in terms of difficulty) Is it [Min Age], [Max Age]? What about nulls?
    Male
    5- 18-25
    4- 25-35
    3- 35-45
    2- 45-55
    1- 55+

    Female
    1- 18-25
    2- 25-35
    3- 35-45
    4- 45-55
    5- 55+

--> Package Level
    1- Bronze
    Bronze Plus
    2- Silver
    Silver Plus
    3- Gold
    Gold Plus
    4- Platinum
    5- Sapphire
    Diamond
    Sapphire Elite
    Diamond Elite



*/


    -->Detail report
    /*
    declare @LastTreeMonth datetime
    SELECT @LastTreeMonth = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 2, 0)

	   SELECT  a.Closer,a.Stage
		  , a.[Opportunities Name]
		  ,acc.[Date / Number Preference]		  
		  ,sum(datediff(second,c.[Created Time],c.[Closed Time]))/*/COUNT(*)*/ [SumForOE_CRM]
		  ,count(distinct c.[Task Id]) OES_CRM
		  ,count(distinct c_last3months.[Task Id]) OES_CRM_Last3Months 
		  ,count(distinct nr.[Task Id]) NR_CRM
		  ,count(distinct nr_last3months.[Task Id]) NR_CRM_Last3Months
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
                  AND [Type] LIKE '%Outbound Email%' AND [Type] NOT LIKE '%NR%'
			   AND [Closed Time] >= @LastTreeMonth
        ) c_last3months ON a.[Opportunities Id] = c_last3months.[Related To] and c_last3months.Closer = a.closer
        LEFT JOIN
        (
            SELECT *, substring(convert(varchar(12), [Closed Time],102),1,7) MonthYearPeriod
            FROM [VIDA].[dbo].[tasks]
            WHERE [Related To] IS NOT NULL
                  AND [Type] LIKE '%nr%' and [Subject] LIKE '%nr%'
        ) nr ON a.[Opportunities Id] = nr.[Related To] and nr.Closer = a.closer	   
        LEFT JOIN
        (
            SELECT *, substring(convert(varchar(12), [Closed Time],102),1,7) MonthYearPeriod
            FROM [VIDA].[dbo].[tasks]
            WHERE [Related To] IS NOT NULL
                  AND [Type] LIKE '%nr%' and [Subject] LIKE '%nr%'
			   AND [Closed Time] >= @LastTreeMonth
        ) nr_last3months ON a.[Opportunities Id] = nr_last3months.[Related To] and nr_last3months.Closer = a.closer	   
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


   
   */

--Avg time for OE
SELECT 
    Closer
    --,sum(OppCount) [Total OppCount]
    ,RIGHT('0'+CONVERT( VARCHAR(5), sum([SumForOE_CRM])/SUM(OES_CRM) / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), sum([SumForOE_CRM])/SUM(OES_CRM) / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), sum([SumForOE_CRM])/SUM(OES_CRM) % 60), 2) [AvgHsForOE CRM]
    ,SUM(OES_CRM) [OES CRM]
    ,SUM(NR_CRM) [NR CRM]
    ,SUM(CloseDateOpp) [CloseDate Count]
    ,CASE WHEN SUM(CloseDateOpp) >0 THEN CAST(CAST(SUM([DaysToCloseDate_CRM]) AS DECIMAL(10,2))/CAST(SUM(CloseDateOpp) AS DECIMAL(10,2)) AS DECIMAL(10,2)) ELSE 0 END  [DaysToCloseDate CRM]
    ,CASE WHEN SUM(CloseDateOpp) >0 THEN CAST(CAST(SUM([OESToCloseDate_CRM]) AS DECIMAL(10,2))/CAST(SUM(CloseDateOpp) AS DECIMAL(10,2)) AS DECIMAL(10,2)) ELSE 0 END [OESToCloseDate CRM]
    ,CASE WHEN SUM(CloseDateOpp) >0 THEN CAST(CAST(SUM([NRToCloseDate_CRM]) AS DECIMAL(10,2))/CAST(SUM(CloseDateOpp) AS DECIMAL(10,2)) AS DECIMAL(10,2)) ELSE 0 END [NRToCloseDate CRM]
    ,CASE WHEN SUM(CloseDateOpp) >0 THEN CAST((CAST(SUM([AchievingClients_Pref]) AS DECIMAL(10,2))*100)/CAST(SUM(CloseDateOpp) AS DECIMAL(10,2)) AS DECIMAL(10,2)) ELSE 0 END [AchievingClients Pref %]
    ,SUM(OES_CRM_Last3Months) [OES CRM Last3Months]
    ,SUM(NR_CRM_Last3Months) [NR CRM Last3Months]
FROM (

    SELECT  a.Closer,a.Stage
		  , a.[Opportunities Name]
		  ,sum(datediff(second,c.[Created Time],c.[Closed Time]))/*/COUNT(*)*/ [SumForOE_CRM]
		  ,ISNULL(count(distinct c.[Task Id]),0) OES_CRM
		  ,ISNULL(count(distinct nr.[Task Id]),0) NR_CRM
		  ,ISNULL(count(distinct c_last3months.[Task Id]),0) OES_CRM_Last3Months 
		  ,ISNULL(count(distinct nr_last3months.[Task Id]),0) NR_CRM_Last3Months
		  ,case when a.Stage in ('Got Phone Number','Pursued Date But Got Number','Date Completely Scheduled Online') then datediff(day,min(c.[Closed Time]), [Closing Date]) else 0 end [DaysToCloseDate_CRM]
		  ,sum(case when a.Stage in ('Got Phone Number','Pursued Date But Got Number','Date Completely Scheduled Online') and c.[Closed Time]< [Closing Date] then 1 else 0 end) [OESToCloseDate_CRM]
		  ,sum(case when a.Stage in ('Got Phone Number','Pursued Date But Got Number','Date Completely Scheduled Online') and nr.[Closed Time]< [Closing Date] then 1 else 0 end) [NRToCloseDate_CRM]
		  ,ISNULL(count(distinct a.[Closing Date]),0) OppCount
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
                  AND [Type] LIKE '%Outbound Email%' AND [Type] NOT LIKE '%NR%'
			   AND [Closed Time] >= @LastTreeMonth
        ) c_last3months ON a.[Opportunities Id] = c_last3months.[Related To] and c_last3months.Closer = a.closer
        LEFT JOIN
        (
            SELECT *
            FROM [VIDA].[dbo].[tasks]
            WHERE [Related To] IS NOT NULL
                  AND [Type] LIKE '%nr%' and [Subject] LIKE '%nr%'
        ) nr ON a.[Opportunities Id] = nr.[Related To] and nr.Closer = a.closer	   
        LEFT JOIN
        (
            SELECT *
            FROM [VIDA].[dbo].[tasks]
            WHERE [Related To] IS NOT NULL
                  AND [Type] LIKE '%nr%' and [Subject] LIKE '%nr%'
			   AND [Closed Time] >= @LastTreeMonth
        ) nr_last3months ON a.[Opportunities Id] = nr_last3months.[Related To] and nr_last3months.Closer = a.closer	   
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
		  AND UPPER(ISNULL(a.[Mobile App], 'NO')) = @MobileApp
		 -- AND a.closer = @Closer--'Alberto Orozco' -- is not null
		  --and a.[Opportunities Name] ='Bill Vivino-Phoebe'
		  --and acc.[Clients Name]  = 'Bill Vivino'
		  group by a.Closer, acc.[Date / Number Preference], a.Stage, a.[Opportunities Name],a.[Closing Date]
) t1 group by Closer
ORDER BY [OES CRM Last3Months] DESC, [NR CRM Last3Months], [DaysToCloseDate CRM]

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
			 --,acc.[Clients Name] 
			 ,sum(tr.units) [Tracking Units Total]
			 ,sum(datediff(second,tr.[start],tr.[end]))/COUNT(*) [SumForOE_LogApp]
			 --,sum(CASE WHEN a.Stage IN('Got Phone Number', 'Pursued Date But Got Number', 'Date Completely Scheduled Online')
				--THEN datediff(second,tr.[start],tr.[end])
				--ELSE null
				--END) [SumHowLongCloseDate_LogApp]
			 ,count(distinct tr.[created_time]) [OES_LogApp]
		  FROM (
			 SELECT DISTINCT Closer, [Clients Id], [Mobile App]
			 FROM [VIDA].[dbo].[opportunities] 
			 WHERE Closer = @Closer--'Alberto Orozco' -- is not null		
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
			 AND UPPER(ISNULL([Mobile App], 'NO')) = @MobileApp
			 --and acc.[Clients Name]  = 'Bill Vivino'
		  group by a.Closer--,acc.[Clients Name] --, a.[Opportunities Id], a.[Opportunities Name],acc.[Clients Name] 
    ) t2