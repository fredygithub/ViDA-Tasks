USE track
GO

--ALTER PROCEDURE get_closer_oes_report
--AS

DECLARE 
    @MobileApp VARCHAR(5)='NO', 
    @package_name NVARCHAR(25)= 'ALL', 
    @LastMonth DATETIME=DATEADD(DAY, -30, GETDATE( )),
    @currentDate DATETIME = GETDATE();



DECLARE @tmp_Roles TABLE
(id             INT IDENTITY,
 role_id		 INT,
 roleName       NVARCHAR(100),
 taskName       NVARCHAR(100)
 --,isCreationTask BIT
);
INSERT INTO @tmp_Roles
(role_id,
 roleName,
 taskName
)
select roles.role_id, [role], task--, case when task like '%creation%' then 1 else 0 end isCreationTask
    from Track.dbo.Roles inner join
    Track.dbo.tasks on roles.role_id = tasks.role_id


IF OBJECT_ID('tempdb..#tmp_logapp') IS NOT NULL
    DROP TABLE #tmp_logapp;

SELECT u.name [TeamMember],
           r.[role],
		 c.name [Client],
		 sites.[site],
           DATEDIFF(second, t.start, t.[end]) TotalTime,
		 t.units,
		 t.created_time,
		 t.[end],
		 tasks.task,
		 t.comments
    into #tmp_logapp
    FROM users u
         INNER JOIN roles r ON r.role_id = u.role_id
         INNER JOIN tasks ON r.role_id = tasks.role_id
         INNER JOIN trackings t ON t.user_id = u.user_id
                                   AND t.task_id = tasks.task_id
         INNER JOIN clients c ON c.client_id = t.client_id
         INNER JOIN sites ON sites.site_id = t.site_id
         INNER JOIN @tmp_Roles roles ON roles.role_id = tasks.role_id AND roles.taskName = tasks.task
    WHERE u.active = 1
          AND t.created_time >= @LastMonth
			--and c.name = 'Karen Scott'
    ORDER BY
	   t.created_time,  t.[end]


IF OBJECT_ID('tempdb..#tmp_crm') IS NOT NULL
    DROP TABLE #tmp_crm;
SELECT *
into #tmp_crm
FROM (
	   SELECT 
		  --ROW_NUMBER() OVER(PARTITION BY users.[First Name] + ' '+ users.[Last Name], acc.[Clients Name], [Type] ORDER BY users.[First Name] + ' '+ users.[Last Name], acc.[Clients Name], [Type], [Task Id]) AS Row#,
		  tasks.[Task Id],
		  tasks.[Subject],
           tasks.[Created Time],
		 tasks.[date sent],
           tasks.[Task Owner Id],
		 case when (task_owner1.[First Name] + ' '+ task_owner1.[Last Name]) = 'Brian Harwell' then tasks.Closer
		 else (task_owner1.[First Name] + ' '+ task_owner1.[Last Name]) end [TeamMember],
		 tasks.Closer,
           tasks.[Related To],
		 client1.[Clients Name] [Client],
           tasks.[Type],
		 ISNULL(tasks.[Quantity],0) [Quantity],
           tasks.[Closed Time]
		 ,DATEDIFF(SECOND, tasks.[Created Time], tasks.[Closed Time]) taskTime
    FROM VIDA.dbo.tasks
	   INNER JOIN [VIDA].[dbo].accounts client1 ON tasks.[Related To] = client1.[Clients Id]
	   INNER JOIN VIDA.dbo.users task_owner1 ON task_owner1.[User Id]= tasks.[Task Owner Id] --> Gets direct tasks related to clients and teammembers
    WHERE [Related To] IS NOT NULL
	     AND tasks.[Subject] not like 'IE-%'
          AND tasks.[Created Time]>=@LastMonth
		AND tasks.[Closed Time]<= @currentDate
		--and client1.[Clients Name] = 'Karen Scott'
UNION
	   SELECT 
		  tasks.[Task Id],
		  tasks.[Subject],
           tasks.[Created Time],
		 tasks.[date sent],
           tasks.[Task Owner Id],
		 case when (task_owner2.[First Name] + ' '+ task_owner2.[Last Name]) = 'Brian Harwell' then tasks.Closer
		 else (task_owner2.[First Name] + ' '+ task_owner2.[Last Name]) end [TeamMember],
		 tasks.Closer,--tasks.Closer,
           tasks.[Related To],
		 client2.[Clients Name] [Client],
           tasks.[Type],
		 ISNULL(tasks.[Quantity],0) [Quantity],
           tasks.[Closed Time]
		 ,DATEDIFF(SECOND, tasks.[Created Time], tasks.[Closed Time]) taskTime
    FROM VIDA.dbo.tasks
	   INNER JOIN [VIDA].[dbo].[opportunities] a on a.[Opportunities Id] = tasks.[Related To]
	   INNER JOIN VIDA.dbo.accounts client2 ON client2.[Clients Id] = a.[Clients Id]
	   INNER JOIN VIDA.dbo.users task_owner2 ON task_owner2.[User Id]= tasks.[Task Owner Id]
	 --  LEFT JOIN VIDA.dbo.users tcloser ON tasks.Closer = tcloser.[First Name] + ' '+ tcloser.[Last Name]    
    WHERE [Related To] IS NOT NULL
	     AND tasks.[Subject] not like 'IE-%'
          AND tasks.[Created Time]>=@LastMonth
		AND tasks.[Closed Time]<= @currentDate
		--and users.[First Name] + ' '+ users.[Last Name]= LogApp.Writer--'Michelle Johnson'--'Alex Stacey'
		--and acc.[Clients Name]= LogApp.client_name--'Daniel Freches'
		--and client2.[Clients Name] = 'Karen Scott'
) t ORDER BY t.[Created Time], t.[Closed Time]

--SELECT [TeamMember], [Client],
--	   Count(*) [Taks Count]	   
--FROM #tmp_crm
--    GROUP BY [TeamMember], [Client]



SELECT isnull(LogApp.[TeamMember],'') [User TimeLogApp],--[LogApp TeamMember],
       --LogApp.[Role],
	  --ISNULL(iSnull(LogApp.[Client],CRM.[Client]),'') [Client],
	  ISNULL(LogApp.[Client],'') [Client TimeLogApp], 
	  LogApp.[site] [Site TimeLogApp],
	  --LogApp.[Taks Time] [LogApp Time],
	  --LogApp.[Taks Count] [LogApp Tasks],
	  isnull(LogApp.[Total Units],'') [Units TimeLogApp],--[LogApp Units],
	  isnull(CRM.[TeamMember],'') [User CRM],--[CRM TeamMember],
	  ISNULL(CRM.[Client],'')  [Client CRM],
	  --CRM.[Taks Count] [CRM Tasks],
	  isnull(CRM.[Taks Count],'') [Tasks CRM],
	  isnull(CRM.[Total Quantity],'') [Units CRM]
FROM 
(
select [TeamMember],[role],[Client],[site],Count(*) [Taks Count], SUM([units]) [Total Units], Sum(TotalTime) [Taks Time]
    from #tmp_logapp
    group by [TeamMember],
		  [role],
		  [Client]
		  ,[site]
) LogApp full outer JOIN
    (
    SELECT [TeamMember], [Client], Count(*) [Taks Count], sum([Quantity]) [Total Quantity]
    FROM #tmp_crm
    GROUP BY [TeamMember], [Client]
    ) CRM
    ON CRM.[TeamMember] = LogApp.[TeamMember] and LogApp.[Client] = CRM.[Client]
    ORDER BY
	   ISNULL(iSnull(LogApp.[Client],CRM.[Client]),''), LogApp.[TeamMember], CRM.[TeamMember]



