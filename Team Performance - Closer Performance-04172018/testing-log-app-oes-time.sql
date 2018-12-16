use Track
GO

DECLARE @Closer varchar(50)= 'Alberto Orozco' ,
 @MobileApp varchar(5) = 'NO', 
@LastTreeMonth DATETIME = DATEADD( DAY, -90, GETDATE( ) );

SELECT 
	   Closer
	   ,[Tracking Units Total]
	   ,RIGHT('0'+CONVERT( VARCHAR(5), [SumForOE_LogApp] / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumForOE_LogApp] / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), [SumForOE_LogApp] % 60), 2) [AvgForOE LogApp]
	   ,[OES_LogApp] [OES LogApp]
    FROM (
			 SELECT 
				a.Closer
				,sum(tr.units) [Tracking Units Total]
				,sum(datediff(second,tr.[start],tr.[end]))/COUNT(*) [SumForOE_LogApp]
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
				    INNER JOIN [TRACK].dbo.users b ON a.Closer = b.name
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
				and t.[end]>=@LastTreeMonth
			 ) tr on tr.taskusername = a.closer and tr.clientName = acc.[Clients Name] 
			 WHERE 
				[Site] <> 'eHarmony'			 
				AND UPPER(ISNULL([Mobile App], 'NO')) = @MobileApp
			 group by a.Closer
		  ) t


DECLARE @Closer varchar(50)= 'Alberto Orozco' ,
 @MobileApp varchar(5) = 'NO', 
@LastTreeMonth DATETIME = DATEADD( DAY, -90, GETDATE( ) );

	 SELECT 
				*
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
				    INNER JOIN [TRACK].dbo.users b ON a.Closer = b.name
			  --INNER JOIN VIDA.dbo.sites d ON REPLACE(REPLACE(a.[Site], CHAR(13), ''), CHAR(10), '') = d.origin
			  INNER JOIN VIDA.dbo.accounts acc on acc.[Clients Id] = a.[Clients Id]
			  LEFT JOIN 
			 (
				select  tasks.task,t.[created_time], t.[start],t.[end], USERS.[name] taskusername, clients.[name] clientName, t.units, sites.[site] 
				from TRACK.dbo.trackings t
				inner join TRACK.dbo.tasks on tasks.task_id = t.task_id
				inner join TRACK.dbo.sites on sites.site_id = t.site_id
				inner join TRACK.dbo.users on users.user_id = t.user_id
				inner join TRACK.dbo.clients on clients.client_id = t.client_id	
				where tasks.task like '%outbound%email%'
				and t.[end]>=@LastTreeMonth
			 ) tr on tr.taskusername = a.closer and tr.clientName = acc.[Clients Name] 
			 WHERE 
				[Site] <> 'eHarmony'			 
				AND UPPER(ISNULL([Mobile App], 'NO')) = @MobileApp
				--and acc.[Clients Name]  = 'Bill Vivino'
			 group by a.Closer--,acc.[Clients Name] --, a.[Opportunities Id], a.[Opportunities Name],acc.[Clients Name] 