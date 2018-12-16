USE track
GO

--ALTER PROCEDURE get_closer_oes_report
--AS

DECLARE
  @MobileApp VARCHAR(5)='NO';

DECLARE 
    @package_name NVARCHAR(25)= 'ALL',
    @MinProfileCount INT = 5

DECLARE
  @LastTreeMonth DATETIME=DATEADD( DAY, -90, GETDATE( ) );

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
           ) t1
           WHERE RowNumber = 1
       ) t2
       ORDER BY client_name;

DECLARE @tmp_Roles TABLE
(id             INT IDENTITY,
 role_id		 INT,
 roleName       NVARCHAR(100),
 taskName       NVARCHAR(100),
 isCreationTask BIT
);
INSERT INTO @tmp_Roles
(role_id,
 roleName,
 taskName,
 isCreationTask
)
select roles.role_id, [role], task, case when task like '%creation%' then 1 else 0 end isCreationTask
    from Track.dbo.Roles inner join
    Track.dbo.tasks on roles.role_id = tasks.role_id
where
    roles.[role] in ('Profile Writer','Closer')
    AND tasks.task in ('Profile Creation','Profile Editing','Simple Profile Creation','Simple Profile Editing')


IF OBJECT_ID('tempdb..#tmp_LogApp') IS NOT NULL
  DROP TABLE #tmp_LogApp
SELECT u.name writer,
           r.role,
		 c.name client_name,
		 package_hours,
           SUM(CASE
                   WHEN isCreationTask = 1
                   THEN 1
                   ELSE 0
               END) CreationTasksCount,
           SUM(CASE
                   WHEN isCreationTask = 0
                   THEN 1
                   ELSE 0
               END) EditionTasksCount,
           SUM(CASE
                   WHEN isCreationTask = 1
                   THEN DATEDIFF(second, t.start, t.[end])
                   ELSE 0
               END) CreationTasksTime,
           SUM(CASE
                   WHEN isCreationTask = 0
                   THEN DATEDIFF(second, t.start, t.[end])
                   ELSE 0
               END) EditionTasksTime,
           SUM(DATEDIFF(second, t.start, t.[end])) SumTotalTime,
           COUNT(DISTINCT c.name) Profiles
    INTO #tmp_LogApp
    FROM users u
         INNER JOIN roles r ON r.role_id = u.role_id
         INNER JOIN tasks ON r.role_id = tasks.role_id
         INNER JOIN trackings t ON t.user_id = u.user_id
                                   AND t.task_id = tasks.task_id
         INNER JOIN clients c ON c.client_id = t.client_id
         INNER JOIN sites ON sites.site_id = t.site_id
         INNER JOIN @tmp_Roles roles ON roles.role_id = tasks.role_id AND roles.taskName = tasks.task
         LEFT JOIN @tmp_ClientFirstPackage ClientFirstPackage ON ClientFirstPackage.client = c.name
    WHERE u.active = 1
          AND t.created_time >= @LastTreeMonth
          AND (ClientFirstPackage.package_name = @package_name
               OR UPPER(@package_name) = 'ALL')		
    GROUP BY u.name,
             r.[role]
		   ,c.name
		   ,package_hours

IF OBJECT_ID('tempdb..#tmp_CRM') IS NOT NULL
  DROP TABLE #tmp_CRM
SELECT [Writer], 
    t2.[Clients Name],
    --SUM(case when [Type] = 'Profile creation' AND [subject] not like '%edit%' then taskTime else 0 end) sumFirstCreationTaskTime,
    --SUM(case when [Type] = 'Profile Editing' OR [subject] like '%edit%' then taskTime else 0 end) sumFirstEditionTaskTime
    SUM(case when [Type] = 'Profile creation' then taskTime else 0 end) sumFirstCreationTaskTime,
    SUM(case when [Type] = 'Profile Editing' then taskTime else 0 end) sumFirstEditionTaskTime
    INTO #tmp_CRM
    from (
	   SELECT --ROW_NUMBER() OVER(PARTITION BY users.[First Name] + ' '+ users.[Last Name], acc.[Clients Name], case when [Type] = 'Profile creation' AND [subject] not like '%edit%' then  1 else 2 end ORDER BY users.[First Name] + ' '+ users.[Last Name], acc.[Clients Name], case when [Type] = 'Profile creation' AND [subject] not like '%edit%' then  1 else 2 end) AS Row#,
	   ROW_NUMBER() OVER(PARTITION BY users.[First Name] + ' '+ users.[Last Name], acc.[Clients Name], [Type] ORDER BY users.[First Name] + ' '+ users.[Last Name], acc.[Clients Name], [Type], [Task Id]) AS Row#,
		-- case when [subject] like '%creation%' then 'Creation' else 'Edition' end tasktype,
		  [Task Id],
		  tasks.[Subject],
           tasks.[Created Time],
           [Task Owner Id],
		 users.[First Name] + ' '+ users.[Last Name] [Writer],
           [Related To],
		 acc.[Clients Name],
           tasks.[Type],
           [Closed Time]
		 ,DATEDIFF(second, tasks.[Created Time], tasks.[Closed Time]) taskTime
    FROM VIDA.dbo.tasks inner join
          VIDA.dbo.accounts acc
          ON acc.[Clients Id]=tasks.[Related To] 
		INNER JOIN
          VIDA.dbo.users 
          ON users.[User Id]= tasks.[Task Owner Id]             
		   WHERE [Related To] IS NOT NULL
          AND tasks.Type in ('Profile creation','Profile Editing')
          AND tasks.[Created Time]>=@LastTreeMonth
		AND tasks.[Closed Time]<= GETDATE()
		--and users.[First Name] + ' '+ users.[Last Name]= LogApp.Writer--'Michelle Johnson'--'Alex Stacey'
		--and acc.[Clients Name]= LogApp.client_name--'Daniel Freches'
		) t2
		
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





























/*select t1.*, t2.*
--SELECT t1.writer,
--       t1.[role],
--	  t1.client_name,
--	  t1.package_hours,
--	  SUM(CreationTasksTime) TotalCreationTasksTime,
--	  SUM(CreationTasksTime) / Profiles AvgCreationTasksTime,
-- 	  SUM(EditionTasksTime) TotalEditionTasksTime,
-- 	  SUM(EditionTasksTime) / Profiles AvgEditionTasksTime,
--       t1.Profiles,
--	  SUM(SumTotalTime) TotalHoursTime
FROM
(*/
 /* SELECT u.name writer,
           r.role,
		 c.name client_name,
		 package_hours,
           SUM(CASE
                   WHEN isCreationTask = 1
                   THEN 1
                   ELSE 0
               END) CreationTasksCount,
           SUM(CASE
                   WHEN isCreationTask = 0
                   THEN 1
                   ELSE 0
               END) EditionTasksCount,
           SUM(CASE
                   WHEN isCreationTask = 1
                   THEN DATEDIFF(second, t.start, t.[end])
                   ELSE 0
               END) CreationTasksTime,
           SUM(CASE
                   WHEN isCreationTask = 0
                   THEN DATEDIFF(second, t.start, t.[end])
                   ELSE 0
               END) EditionTasksTime,
           SUM(DATEDIFF(second, t.start, t.[end])) SumTotalTime,
           COUNT(DISTINCT c.name) Profiles 
		-- ,RIGHT( '0'+CONVERT( VARCHAR(5), DATEDIFF(second, t.start, t.[end])/60/60 ), 2 )+':'+RIGHT( '0'+CONVERT( VARCHAR(2), DATEDIFF(second, t.start, t.[end])/60%60 ), 2 ) TaskTimeMin
  */SELECT u.name writer,
           r.role,
		 c.name client_name,
		 tasks.task,
		 --tasks.*,
		 t.*,-- DATEDIFF(second, t.start, t.[end])/60 TaskTimeMin
		 RIGHT( '0'+CONVERT( VARCHAR(5), DATEDIFF(second, t.start, t.[end])/60/60 ), 2 )+':'+RIGHT( '0'+CONVERT( VARCHAR(2), DATEDIFF(second, t.start, t.[end])/60%60 ), 2 ) TaskTimeMin
		 , t2.*
    FROM Track.dbo.users u
         INNER JOIN Track.dbo.roles r ON r.role_id = u.role_id
         INNER JOIN Track.dbo.tasks ON r.role_id = tasks.role_id
         INNER JOIN Track.dbo.trackings t ON t.user_id = u.user_id
                                   AND t.task_id = tasks.task_id
         INNER JOIN Track.dbo.clients c ON c.client_id = t.client_id
         INNER JOIN Track.dbo.sites ON sites.site_id = t.site_id
         INNER JOIN @tmp_Roles roles ON roles.role_id = tasks.role_id AND roles.taskName = tasks.task
         LEFT JOIN @tmp_ClientFirstPackage ClientFirstPackage ON ClientFirstPackage.client = c.name
	    OUTER APPLY(
		 SELECT TOP 1 [Task Id],
             tasks.[Subject],
             tasks.[Created Time],
             [Task Owner Id],
             users.[First Name]+' '+users.[Last Name] [Writer],
             [Related To],
             acc.[Clients Name],
             tasks.[Type],
             [Closed Time]
		  FROM VIDA.dbo.tasks
			  INNER JOIN VIDA.dbo.accounts acc ON acc.[Clients Id] = tasks.[Related To]
			  INNER JOIN VIDA.dbo.users ON users.[User Id] = tasks.[Task Owner Id]
		  WHERE [Related To] IS NOT NULL
			   --AND tasks.[Type] IN('Profile creation', 'Profile Editing')
			 --AND ((isCreationTask = 1 AND tasks.[Type] = 'Profile creation') OR (isCreationTask = 0 AND tasks.[Type] ='Profile Editing'))
			 AND tasks.[Created Time] >= @LastTreeMonth
			 AND users.[First Name]+' '+users.[Last Name] = u.name--'Alex Stacey'
			 AND c.name = acc.[Clients Name] 
			 --AND CONVERT(VARCHAR(12), t.[end], 101) = CONVERT(VARCHAR(12),tasks.[Closed Time],  101)
			  AND t.[end] between tasks.[Created Time] and tasks.[Closed Time]
		 ) t2
    WHERE u.active = 1
          AND t.created_time >= @LastTreeMonth
		AND u.name = 'Alex Stacey'
		AND c.name = 'Daniel Freches'
          --AND (ClientFirstPackage.package_name = @package_name
          --     OR UPPER(@package_name) = 'ALL')
	
  /*  GROUP BY u.name,
             r.[role]
		   ,c.name
		   ,package_hours*/
	
	/*     ) t1
		inner JOIN
		(
  declare @LastTreeMonth DATETIME=DATEADD( DAY, -90, GETDATE( ) );
SELECT ROW_NUMBER() OVER(PARTITION BY users.[First Name] + ' '+ users.[Last Name], acc.[Clients Name], tasks.[Type] ORDER BY [Task Id] ASC) 
    AS Row#,
		  [Task Id],
		  tasks.[Subject],
           tasks.[Created Time],
           [Task Owner Id],
		 users.[First Name] + ' '+ users.[Last Name] [Writer],
           [Related To],
		 acc.[Clients Name],
           tasks.Type,
           [Closed Time]
    FROM VIDA.dbo.tasks inner join
          VIDA.dbo.accounts acc
          ON acc.[Clients Id]=tasks.[Related To] 
		INNER JOIN
          VIDA.dbo.users 
          ON users.[User Id]= tasks.[Task Owner Id]             
		   WHERE [Related To] IS NOT NULL
          AND tasks.Type in ('Profile creation','Profile Editing')
          AND tasks.[Created Time]>=@LastTreeMonth
		and users.[First Name] + ' '+ users.[Last Name]= 'Alex Stacey'
   -- order by users.[First Name] + ' '+ users.[Last Name], acc.[Clients Name], tasks.[Created Time]
) t2 
on t1.writer = t2.[Writer] and t1.client_name = t2.[Clients Name] and convert(varchar(12), t1.[end], 101) = convert(varchar(12),t2.[Closed Time],  101)

*/

DECLARE
  @LastTreeMonth DATETIME=DATEADD( DAY, -90, GETDATE( ) );

  SELECT ROW_NUMBER() OVER(
			 PARTITION BY users.[First Name] + ' '+ users.[Last Name]
			 , acc.[Clients Name]
			 , case when [subject] like '%creation%' then 'Creation' else 'Edition' end/*tasks.[Type]*/ 
			 ORDER BY users.[First Name] + ' '+ users.[Last Name], acc.[Clients Name], case when [subject] like '%creation%' then 'Creation' else 'Edition' end) AS Row#,
		  case when [subject] like '%creation%' then 'Creation' else 'Edition' end tasktype,
		  [Task Id],
		  tasks.[Subject],
           tasks.[Created Time],
           [Task Owner Id],
		 users.[First Name] + ' '+ users.[Last Name] [Writer],
           [Related To],
		 acc.[Clients Name],
           tasks.Type,
           [Closed Time]
		 ,DATEDIFF(second, tasks.[Created Time], tasks.[Closed Time]) taskTime
		 --,RIGHT( '0'+CONVERT( VARCHAR(5), DATEDIFF(second, tasks.[Created Time], tasks.[Closed Time])/60/60 ), 2 )+':'+RIGHT( '0'+CONVERT( VARCHAR(2), DATEDIFF(second, tasks.[Created Time], tasks.[Closed Time])/60%60 ), 2 ) CRMTaskTimeMin
    FROM VIDA.dbo.tasks inner join
          VIDA.dbo.accounts acc
          ON acc.[Clients Id]=tasks.[Related To] 
		INNER JOIN
          VIDA.dbo.users 
          ON users.[User Id]= tasks.[Task Owner Id]             
		   WHERE [Related To] IS NOT NULL
          AND tasks.Type in ('Profile creation','Profile Editing')
          AND tasks.[Created Time]>=@LastTreeMonth
		AND tasks.[Closed Time]<= GETDATE()
		and users.[First Name] + ' '+ users.[Last Name]= 'Michelle Johnson'--'Alex Stacey'
		ORDER BY users.[First Name] + ' '+ users.[Last Name] , acc.[Clients Name], tasktype, Row#

select [Writer], 
    t2.[Clients Name],
    --tasktype,
    SUM(case when [subject] like '%creation%' then taskTime else 0 end) sumFirstCreationTaskTime,
    SUM(case when [subject] like '%edit%' then taskTime else 0 end) sumFirstEditionTaskTime
    --SUM(case when [subject] like '%creation%' then taskTime else 0 end)/SUM(case when [subject] like '%creation%' then 1 else 0 end) sumCreationTaskTime,
    --SUM(case when [subject] like '%creation%' then 0 else taskTime end)/SUM(case when [subject] like '%creation%' then 0 else 1 end) sumEditionTaskTime
    --count(*) profiles,
    --,RIGHT( ' '+CONVERT( VARCHAR(5), SUM(taskTime)/count(*)/60/60 ), 3 )+':'+RIGHT( '0'+CONVERT( VARCHAR(2), SUM(taskTime)/count(*)/60%60 ), 2 ) CRMTaskTimeMin
    from (
	   SELECT ROW_NUMBER() OVER(
			 PARTITION BY users.[First Name] + ' '+ users.[Last Name]
			 , acc.[Clients Name]
			 , case when [subject] like '%creation%' then 'Creation' else 'Edition' end/*tasks.[Type]*/ 
			 ORDER BY users.[First Name] + ' '+ users.[Last Name], acc.[Clients Name], case when [subject] like '%creation%' then 'Creation' else 'Edition' end) AS Row#,
		  case when [subject] like '%creation%' then 'Creation' else 'Edition' end tasktype,
		  [Task Id],
		  tasks.[Subject],
           tasks.[Created Time],
           [Task Owner Id],
		 users.[First Name] + ' '+ users.[Last Name] [Writer],
           [Related To],
		 acc.[Clients Name],
           tasks.Type,
           [Closed Time]
		 ,DATEDIFF(second, tasks.[Created Time], tasks.[Closed Time]) taskTime
		 --,RIGHT( '0'+CONVERT( VARCHAR(5), DATEDIFF(second, tasks.[Created Time], tasks.[Closed Time])/60/60 ), 2 )+':'+RIGHT( '0'+CONVERT( VARCHAR(2), DATEDIFF(second, tasks.[Created Time], tasks.[Closed Time])/60%60 ), 2 ) CRMTaskTimeMin
    FROM VIDA.dbo.tasks inner join
          VIDA.dbo.accounts acc
          ON acc.[Clients Id]=tasks.[Related To] 
		INNER JOIN
          VIDA.dbo.users 
          ON users.[User Id]= tasks.[Task Owner Id]             
		   WHERE [Related To] IS NOT NULL
          AND tasks.Type in ('Profile creation','Profile Editing')
          AND tasks.[Created Time]>=@LastTreeMonth
		AND tasks.[Closed Time]<= GETDATE()
		and users.[First Name] + ' '+ users.[Last Name]= 'Michelle Johnson'--'Alex Stacey'
		--and acc.[Clients Name]='Daniel Freches'
		) t2
		--where Row# = 1
		group by
		  [Writer], t2.[Clients Name]--, tasktype



DECLARE
  @LastTreeMonth DATETIME=DATEADD( DAY, -90, GETDATE( ) );		  
SELECT 
ROW_NUMBER() OVER(PARTITION BY users.[First Name] + ' '+ users.[Last Name], acc.[Clients Name], case when [Type] = 'Profile creation' then  1 else 2 end ORDER BY users.[First Name] + ' '+ users.[Last Name], acc.[Clients Name], case when [Type] = 'Profile creation' then  1 else 2 end) AS Row#,
DATEDIFF(second, tasks.[Created Time], tasks.[Closed Time]) taskTime,
		tasks.*
    FROM VIDA.dbo.tasks inner join
          VIDA.dbo.accounts acc
          ON acc.[Clients Id]=tasks.[Related To] 
		INNER JOIN
          VIDA.dbo.users 
          ON users.[User Id]= tasks.[Task Owner Id]             
		   WHERE [Related To] IS NOT NULL
          AND tasks.Type in ('Profile creation','Profile Editing')
          AND tasks.[Created Time]>=@LastTreeMonth
		and users.[First Name] + ' '+ users.[Last Name]= 'Mark Reagan'--'Alex Stacey'
		and acc.[Clients Name]='Jon Huff'

DECLARE
  @LastTreeMonth DATETIME=DATEADD( DAY, -90, GETDATE( ) );	
SELECT Subject, Type, COUNT(*)
FROM VIDA.dbo.tasks inner join
          VIDA.dbo.accounts acc
          ON acc.[Clients Id]=tasks.[Related To] 
		INNER JOIN
          VIDA.dbo.users 
          ON users.[User Id]= tasks.[Task Owner Id]             
		   WHERE [Related To] IS NOT NULL
          AND tasks.Type in ('Profile creation','Profile Editing')
          AND tasks.[Created Time]>=@LastTreeMonth
		GROUP BY Subject, Type
SELECT Subject, Type, COUNT(*)
FROM VIDA.dbo.tasks inner join
          VIDA.dbo.accounts acc
          ON acc.[Clients Id]=tasks.[Related To] 
		INNER JOIN
          VIDA.dbo.users 
          ON users.[User Id]= tasks.[Task Owner Id]             
		   WHERE [Related To] IS NOT NULL
          AND tasks.Type in ('Profile creation','Profile Editing')
          AND tasks.[Created Time]>=@LastTreeMonth
		GROUP BY Subject, Type
/*
DECLARE
  @MobileApp VARCHAR(5)='NO';

DECLARE 
    @package_name NVARCHAR(25)= 'ALL',
    @MinProfileCount INT = 5

DECLARE
  @LastTreeMonth DATETIME=DATEADD( DAY, -90, GETDATE( ) );
  select @LastTreeMonth
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
           ) t1
           WHERE RowNumber = 1
       ) t2
       ORDER BY client_name;

DECLARE @tmp_Roles TABLE
(id             INT IDENTITY,
 role_id		 INT,
 roleName       NVARCHAR(100),
 taskName       NVARCHAR(100),
 isCreationTask BIT
);
INSERT INTO @tmp_Roles
(role_id,
 roleName,
 taskName,
 isCreationTask
)
select roles.role_id, [role], task, case when task like '%creation%' then 1 else 0 end isCreationTask
    from Track.dbo.Roles inner join
    Track.dbo.tasks on roles.role_id = tasks.role_id
where
    roles.[role] in ('Profile Writer','Closer')
    AND tasks.task in ('Profile Creation','Profile Editing','Simple Profile Creation','Simple Profile Editing')
SELECT 
           u.name username, c.name clientname, tasks.task, t.start, t.[end], t.units, sites.[site], t.comments
    FROM users u
         INNER JOIN roles r ON r.role_id = u.role_id
         INNER JOIN tasks ON r.role_id = tasks.role_id
         INNER JOIN trackings t ON t.user_id = u.user_id
                                   AND t.task_id = tasks.task_id
         INNER JOIN clients c ON c.client_id = t.client_id
         INNER JOIN sites ON sites.site_id = t.site_id
         INNER JOIN @tmp_Roles roles ON roles.role_id = tasks.role_id AND roles.taskName = tasks.task
         LEFT JOIN @tmp_ClientFirstPackage ClientFirstPackage ON ClientFirstPackage.client = c.name
    WHERE u.active = 1
          AND t.created_time >= @LastTreeMonth
          AND (ClientFirstPackage.package_name = @package_name
               OR UPPER(@package_name) = 'ALL')	
	   AND u.name = 'Ana Perez'--'Mark Reagan'
	   and c.name = 'Adam Cohen'--'Jon Huff'
*/