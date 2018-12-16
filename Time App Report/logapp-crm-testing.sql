USE track
GO

--ALTER PROCEDURE get_closer_oes_report
--AS

DECLARE
  @MobileApp VARCHAR(5)='NO';

DECLARE 
    @package_name NVARCHAR(25)= 'ALL'

DECLARE
  @LastMonth DATETIME=DATEADD( DAY, -30, GETDATE( ) );

select @LastMonth LastMonth;

DECLARE @tmp_ClientFirstPackage TABLE
(client             NVARCHAR(50),
 firstPayrollPeriod DATE,
 package_name       NVARCHAR(25),
 package_color      NVARCHAR(7),
 package_hours		float
);
INSERT INTO @tmp_ClientFirstPackage
(client,
 [firstPayrollPeriod],
 package_name,
 package_color,
 package_hours
)
       SELECT client_name,
              [firstPayrollPeriod],
              package_name [Package Name],
              package_color [Package Color],
		    monthly_hours [Package Hours]
       FROM
       (
           SELECT name client_name,
                  bill_date [firstPayrollPeriod],
                  package_name,
                  package_color,
			   monthly_hours,
                  RowNumber
           FROM
           (
               SELECT clients.name,
                      bills.bill_date,
                      clients.active,
                      ROW_NUMBER() OVER(PARTITION BY bills.client_id ORDER BY bill_date ASC) AS RowNumber,
                      package_name,
                      package_color,
				  monthly_hours
               FROM TRACK.dbo.clients
                    INNER JOIN TRACK.dbo.bills ON clients.client_id = bills.client_id
                    INNER JOIN TRACK.dbo.packages ON packages.monthly_hours = bills.[hours]
			 where package_name not like '%deposit%'
           ) t1
           WHERE RowNumber = 1
       ) t2
       ORDER BY client_name;

--select * from @tmp_ClientFirstPackage;

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
 --, isCreationTask
)
select roles.role_id, [role], task--, case when task like '%creation%' then 1 else 0 end isCreationTask
    from Track.dbo.Roles inner join
    Track.dbo.tasks on roles.role_id = tasks.role_id
--where
    --roles.[role] in ('Profile Writer','Closer')
    --roles.[role] = 'Closer'
    --AND tasks.task in ('Profile Creation','Profile Editing','Simple Profile Creation','Simple Profile Editing')


--select * from @tmp_Roles;
SELECT u.name writer,
           r.role,
		 c.name client_name,
		 package_hours,
           DATEDIFF(second, t.start, t.[end]) TotalTime,
		 t.units,
		 t.created_time,
		 t.[end],
		 tasks.task,
		 t.comments
    FROM users u
         INNER JOIN roles r ON r.role_id = u.role_id
         INNER JOIN tasks ON r.role_id = tasks.role_id
         INNER JOIN trackings t ON t.user_id = u.user_id
                                   AND t.task_id = tasks.task_id
         INNER JOIN clients c ON c.client_id = t.client_id
         INNER JOIN sites ON sites.site_id = t.site_id
         INNER JOIN @tmp_Roles roles ON roles.role_id = tasks.role_id AND roles.taskName = tasks.task
         INNER JOIN @tmp_ClientFirstPackage ClientFirstPackage ON ClientFirstPackage.client = c.name
    WHERE u.active = 1
          AND t.created_time >= @LastMonth
          AND (ClientFirstPackage.package_name = @package_name
               OR UPPER(@package_name) = 'ALL')	
			and c.name = 'Karen Scott'
    ORDER BY
	   t.created_time,  t.[end]
    --ORDER BY u.name,
    --         r.[role]
		  -- ,c.name
		  -- ,package_hours	





		   /*
IF OBJECT_ID('tempdb..#tmp_LogApp') IS NOT NULL
  DROP TABLE #tmp_LogApp
SELECT u.name writer,
           r.role,
		 c.name client_name,
		 package_hours,
           SUM(DATEDIFF(second, t.start, t.[end])) SumTotalTime,
		 --DATEDIFF(second, t.start, t.[end]) TotalTime,
		 SUM(t.units) SumUnits,
		 COUNT(*) CountTaks
           --,COUNT(DISTINCT c.name) Profiles
    INTO #tmp_LogApp
    FROM users u
         INNER JOIN roles r ON r.role_id = u.role_id
         INNER JOIN tasks ON r.role_id = tasks.role_id
         INNER JOIN trackings t ON t.user_id = u.user_id
                                   AND t.task_id = tasks.task_id
         INNER JOIN clients c ON c.client_id = t.client_id
         INNER JOIN sites ON sites.site_id = t.site_id
         INNER JOIN @tmp_Roles roles ON roles.role_id = tasks.role_id AND roles.taskName = tasks.task
         INNER JOIN @tmp_ClientFirstPackage ClientFirstPackage ON ClientFirstPackage.client = c.name
    WHERE u.active = 1
          AND t.created_time >= @LastMonth
          AND (ClientFirstPackage.package_name = @package_name
               OR UPPER(@package_name) = 'ALL')		
    GROUP BY u.name,
             r.[role]
		   ,c.name
		   ,package_hours*/


--SELECT '#tmp_LogApp', * FROM #tmp_LogApp;
/*	   SELECT 
		  [Task Id],
		  tasks.[Subject],
           tasks.[Created Time],
		 tasks.[date sent],
           [Task Owner Id],
		 users.[First Name] + ' '+ users.[Last Name] [AssignTo],
		 tasks.Closer,--tasks.Closer,
           [Related To],
		 acc.[Clients Name],
           tasks.[Type],
           [Closed Time]
		 ,DATEDIFF(SECOND, tasks.[Created Time], tasks.[Closed Time]) taskTime
    FROM VIDA.dbo.tasks
	   INNER JOIN [VIDA].[dbo].[opportunities] a on a.[Opportunities Id] = tasks.[Related To]
	   INNER JOIN VIDA.dbo.accounts acc ON acc.[Clients Id] = a.[Clients Id]
	   LEFT JOIN VIDA.dbo.users ON users.[User Id]= tasks.[Task Owner Id]
    WHERE [Related To] IS NOT NULL and
          tasks.[Created Time]>=@LastMonth
		AND tasks.[Closed Time]<= GETDATE()
		and acc.[Clients Name] = 'Karen Scott'
		and tasks.Closer='Bonnie Lamer'
		order by tasks.[Created Time], tasks.[closed time]*/


/*IF OBJECT_ID('tempdb..#tmp_CRM') IS NOT NULL
  DROP TABLE #tmp_CRM
SELECT [Writer], 
    t2.[Clients Name],
    SUM(taskTime)
    INTO #tmp_CRM
    from (*/
SELECT *
FROM (
	   SELECT 
		  --ROW_NUMBER() OVER(PARTITION BY users.[First Name] + ' '+ users.[Last Name], acc.[Clients Name], [Type] ORDER BY users.[First Name] + ' '+ users.[Last Name], acc.[Clients Name], [Type], [Task Id]) AS Row#,
		  tasks.[Task Id],
		  tasks.[Subject],
           tasks.[Created Time],
		 tasks.[date sent],
           tasks.[Task Owner Id],
		 task_owner1.[First Name] + ' '+ task_owner1.[Last Name] [AssignTo],
		 tasks.Closer,--tasks.Closer,
           tasks.[Related To],
		 client1.[Clients Name],
           tasks.[Type],
           tasks.[Closed Time]
		 ,DATEDIFF(SECOND, tasks.[Created Time], tasks.[Closed Time]) taskTime
    FROM VIDA.dbo.tasks
	   LEFT JOIN [VIDA].[dbo].accounts client1 ON tasks.[Related To] = client1.[Clients Id]
	   INNER JOIN VIDA.dbo.users task_owner1 ON task_owner1.[User Id]= tasks.[Task Owner Id] --> Gets direct tasks related to clients and teammembers
	 --  LEFT JOIN VIDA.dbo.users tcloser ON tasks.Closer = tcloser.[First Name] + ' '+ tcloser.[Last Name]    
    WHERE [Related To] IS NOT NULL
	     AND tasks.[Subject] not like 'IE-%'
          AND tasks.[Created Time]>=@LastMonth
		AND tasks.[Closed Time]<= GETDATE()
		--and users.[First Name] + ' '+ users.[Last Name]= LogApp.Writer--'Michelle Johnson'--'Alex Stacey'
		--and acc.[Clients Name]= LogApp.client_name--'Daniel Freches'
		and client1.[Clients Name] = 'Karen Scott'
UNION
	   SELECT 
		  --ROW_NUMBER() OVER(PARTITION BY users.[First Name] + ' '+ users.[Last Name], acc.[Clients Name], [Type] ORDER BY users.[First Name] + ' '+ users.[Last Name], acc.[Clients Name], [Type], [Task Id]) AS Row#,
		  tasks.[Task Id],
		  tasks.[Subject],
           tasks.[Created Time],
		 tasks.[date sent],
           tasks.[Task Owner Id],
		 task_owner2.[First Name] + ' '+ task_owner2.[Last Name] [AssignTo],
		 tasks.Closer,--tasks.Closer,
           tasks.[Related To],
		 client2.[Clients Name],
           tasks.[Type],
           tasks.[Closed Time]
		 ,DATEDIFF(SECOND, tasks.[Created Time], tasks.[Closed Time]) taskTime
    FROM VIDA.dbo.tasks
	   LEFT JOIN [VIDA].[dbo].[opportunities] a on a.[Opportunities Id] = tasks.[Related To]
	   INNER JOIN VIDA.dbo.accounts client2 ON client2.[Clients Id] = a.[Clients Id]
	   INNER JOIN VIDA.dbo.users task_owner2 ON task_owner2.[User Id]= tasks.[Task Owner Id]
	 --  LEFT JOIN VIDA.dbo.users tcloser ON tasks.Closer = tcloser.[First Name] + ' '+ tcloser.[Last Name]    
    WHERE [Related To] IS NOT NULL
	     AND tasks.[Subject] not like 'IE-%'
          AND tasks.[Created Time]>=@LastMonth
		AND tasks.[Closed Time]<= GETDATE()
		--and users.[First Name] + ' '+ users.[Last Name]= LogApp.Writer--'Michelle Johnson'--'Alex Stacey'
		--and acc.[Clients Name]= LogApp.client_name--'Daniel Freches'
		and client2.[Clients Name] = 'Karen Scott'
) t ORDER BY t.[Created Time], t.[Closed Time]


		/*) t2		
		where Row# = 1
		group by
		  [Writer], t2.[Clients Name]


SELECT LogApp.writer,
       LogApp.[role],
	  LogApp.client_name,
	  LogApp.package_hours,
	  SUM(LogApp.CreationTasksTime) TotalCreationTasksTime,
	  SUM(LogApp.CreationTasksTime) / Profiles AvgCreationTasksTime,
 	  SUM(LogApp.EditionTasksTime) TotalEditionTasksTime,
 	  SUM(LogApp.EditionTasksTime) / Profiles AvgEditionTasksTime,
       LogApp.Profiles,
	  SUM(LogApp.SumTotalTime) TotalHoursTime
	  , CRM.sumFirstCreationTaskTime, CRM.sumFirstEditionTaskTime
FROM #tmp_LogApp LogApp
LEFT JOIN #tmp_CRM CRM ON CRM.Writer = LogApp.Writer and LogApp.client_name = CRM.[Clients Name]
GROUP BY LogApp.writer,
         LogApp.[role],
	    LogApp.client_name,
	    LogApp.package_hours,
         LogApp.Profiles
	    , CRM.sumFirstCreationTaskTime, CRM.sumFirstEditionTaskTime
ORDER BY LogApp.profiles desc, SUM(LogApp.CreationTasksTime) / LogApp.Profiles desc;
*/







--select top 10 *
--    from VIDA.dbo.users 
--	   inner join vida.dbo.
--    where 
--	   [first name] + ' ' + [Last Name] = 'Brian Harwell'

--select top 10 *
--    from track.dbo.users
--	   inner join roles on roles.role_id = users.role_id
--    where 
--	  name like '%bonnie%'




















