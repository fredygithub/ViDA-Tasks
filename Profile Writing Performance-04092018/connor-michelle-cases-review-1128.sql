use track
go

     DECLARE @StartMonth DATETIME= DATEADD(DAY, 1, EOMONTH(GETDATE(), -3)),
	@MinClientNumber INT = 5;
/*==============
	   CRM
================*/

                SELECT ROW_NUMBER() OVER(PARTITION BY users.[First Name]+' '+users.[Last Name],
                                                      acc.[Clients Name],
                                                      CASE
                                                          WHEN([subject] LIKE '%creation%'
                                                               OR tasks.Type = 'Profile creation')
                                                          THEN 'Creation'
                                                          ELSE 'Edition'
                                                      END ORDER BY users.[First Name]+' '+users.[Last Name],
                                                                   acc.[Clients Name],
                                                                   CASE
                                                                       WHEN [subject] LIKE '%creation%'
                                                                       THEN 'Creation'
                                                                       ELSE 'Edition'
                                                                   END) AS Row#,
                       CASE
                           WHEN([subject] LIKE '%creation%'
                                OR tasks.Type = 'Profile creation')
                           THEN 'Creation'
                           ELSE 'Edition'
                       END tasktype,
                       CONVERT( NCHAR(7), tasks.[Created Time], 120) [MonthPeriod],
                       users.[First Name]+' '+users.[Last Name] [Writer],
                       acc.[Clients Name] [Client],
				   tasks.[Created Time], tasks.[Closed Time],
                       DATEDIFF(second, tasks.[Created Time], tasks.[Closed Time]) taskTime
                FROM VIDA.dbo.tasks
                     INNER JOIN VIDA.dbo.accounts acc ON acc.[Clients Id] = tasks.[Related To]
                     INNER JOIN VIDA.dbo.users ON users.[User Id] = tasks.[Task Owner Id]
                WHERE [Related To] IS NOT NULL
                      AND tasks.Type IN('Profile creation', 'Profile Editing')
                     AND tasks.[Created Time] >= @StartMonth
                     AND tasks.[Closed Time] <= GETDATE()
				 and users.[First Name]+' '+users.[Last Name]= 'Michelle Johnson' and CONVERT( NCHAR(7), tasks.[Created Time], 120) = '2018-10'

   SELECT [Writer],
                   [Client],
                   [MonthPeriod],
                   SUM(CASE
                           WHEN tasktype = 'Creation'
                           THEN taskTime
                           ELSE 0
                       END) CreationTaskTime,
                   SUM(CASE
                           WHEN tasktype = 'Edition'
                           THEN taskTime
                           ELSE 0
                       END) EditionTaskTime
            FROM
            (
                SELECT ROW_NUMBER() OVER(PARTITION BY users.[First Name]+' '+users.[Last Name],
                                                      acc.[Clients Name],
                                                      CASE
                                                          WHEN([subject] LIKE '%creation%'
                                                               OR tasks.Type = 'Profile creation')
                                                          THEN 'Creation'
                                                          ELSE 'Edition'
                                                      END ORDER BY users.[First Name]+' '+users.[Last Name],
                                                                   acc.[Clients Name],
                                                                   CASE
                                                                       WHEN [subject] LIKE '%creation%'
                                                                       THEN 'Creation'
                                                                       ELSE 'Edition'
                                                                   END) AS Row#,
                       CASE
                           WHEN([subject] LIKE '%creation%'
                                OR tasks.Type = 'Profile creation')
                           THEN 'Creation'
                           ELSE 'Edition'
                       END tasktype,
                       CONVERT( NCHAR(7), tasks.[Created Time], 120) [MonthPeriod],
                       users.[First Name]+' '+users.[Last Name] [Writer],
                       acc.[Clients Name] [Client],
                       DATEDIFF(second, tasks.[Created Time], tasks.[Closed Time]) taskTime
                FROM VIDA.dbo.tasks
                     INNER JOIN VIDA.dbo.accounts acc ON acc.[Clients Id] = tasks.[Related To]
                     INNER JOIN VIDA.dbo.users ON users.[User Id] = tasks.[Task Owner Id]
                WHERE [Related To] IS NOT NULL
                      AND tasks.Type IN('Profile creation', 'Profile Editing')
                     AND tasks.[Created Time] >= @StartMonth
                     AND tasks.[Closed Time] <= GETDATE()
				 and users.[First Name]+' '+users.[Last Name]= 'Michelle Johnson' and CONVERT( NCHAR(7), tasks.[Created Time], 120) = '2018-10'
            ) t
            WHERE Row# = 1
            GROUP BY [Writer],
                     [Client],
                     [MonthPeriod];

/*==============
    LOG APP
================*/
     DECLARE @tmp_Roles TABLE
     (id             INT IDENTITY,
      role_id        INT,
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
            SELECT roles.role_id,
                   [role],
                   task,
                   CASE
                       WHEN task LIKE '%creation%'
                       THEN 1
                       ELSE 0
                   END isCreationTask
            FROM Roles
                 INNER JOIN tasks ON roles.role_id = tasks.role_id
            WHERE roles.[role] IN('Profile Writer', 'Closer')
                 AND tasks.task IN('Profile Creation', 'Profile Editing', 'Simple Profile Creation', 'Simple Profile Editing');

    IF OBJECT_ID('tempdb.dbo.#tmp_LopApp', 'U') IS NOT NULL
         DROP TABLE #tmp_LopApp;
     CREATE TABLE #tmp_LopApp
     ([Writer]        NVARCHAR(100),
      [user_id]       BIGINT,
      [Client]        NVARCHAR(100),
      [client_id]     BIGINT,
      created_time    DATETIME,
      dr_created_time INT,
      isCreationTask  BIT,
	 writer_active bit
     );
     INSERT INTO #tmp_LopApp
     ([Writer],
      [user_id],
      [Client],
      [client_id],
      created_time,
      dr_created_time,
      isCreationTask,
	 writer_active
     )
            SELECT u.name writer,
                   u.[user_id],
                   c.name client_name,
                   c.[client_id],
                   t.created_time,
                   DENSE_RANK() OVER(PARTITION BY c.name ORDER BY iscreationtask DESC,
                                                                  t.created_time) dr_created_time,
                   roles.isCreationTask,
			    u.active
            FROM users u
                 INNER JOIN roles r ON r.role_id = u.role_id
                 INNER JOIN tasks ON r.role_id = tasks.role_id
                 INNER JOIN trackings t ON t.user_id = u.user_id
                                           AND t.task_id = tasks.task_id
                 INNER JOIN clients c ON c.client_id = t.client_id
                 INNER JOIN @tmp_Roles roles ON roles.role_id = tasks.role_id
                                                AND roles.taskName = tasks.task

SELECT u.name writer,
                   u.[user_id],
                   c.name client_name,
                   c.[client_id],
                   t.created_time,
			    site, comments,
                   --DENSE_RANK() OVER(PARTITION BY c.name ORDER BY iscreationtask DESC,
                   --                                               t.created_time) dr_created_time,
                   --roles.isCreationTask,
			    u.active
            FROM users u
                 INNER JOIN roles r ON r.role_id = u.role_id
                 INNER JOIN tasks ON r.role_id = tasks.role_id
                 INNER JOIN trackings t ON t.user_id = u.user_id
                                           AND t.task_id = tasks.task_id
                 INNER JOIN clients c ON c.client_id = t.client_id
			  inner join [sites] on [sites].site_id = t.site_id
			  where  c.name='Bella Maree Lane' and tasks.task = 'Profile Creation'
			  order by t.created_time


     /*       SELECT u.name writer,
                   u.[user_id],
                   c.name client_name,
                   c.[client_id],
                   t.created_time,
                   --DENSE_RANK() OVER(PARTITION BY c.name ORDER BY iscreationtask DESC,
                   --                                               t.created_time) dr_created_time,
                   --roles.isCreationTask,
			    u.active
            FROM users u
                 INNER JOIN roles r ON r.role_id = u.role_id
                 INNER JOIN tasks ON r.role_id = tasks.role_id
                 INNER JOIN trackings t ON t.user_id = u.user_id
                                           AND t.task_id = tasks.task_id
                 INNER JOIN clients c ON c.client_id = t.client_id
			  where  c.name='Chris Barton' and tasks.task = 'Profile Creation'
			  order by t.created_time
			  select * from users where name like '%conn%'

                SELECT created_time first_task,*
                FROM #tmp_LopApp LopApp2
                WHERE --LopApp2.client = LopApp.client
                      /*AND LopApp2.dr_created_time = 1*/
				  /*and LopApp2.[Writer]= 'Michelle Johnson' */
				   LopApp2.[Client]='Chris Barton'
				   */

            SELECT LopApp.[Writer],
                   LopApp.[user_id],
                   LopApp.[Client],
                   LopApp.[client_id],
                   LopApp.created_time,
                   LopApp.dr_created_time,
                   isCreationTask,
			    first_task,
			    DENSE_RANK() OVER(PARTITION BY LopApp.[Writer] ORDER BY LopApp.[client_id]) AS ClientNumber
            FROM #tmp_LopApp LopApp
                 OUTER APPLY
            (
                SELECT created_time first_task
                FROM #tmp_LopApp LopApp2
                WHERE LopApp2.client = LopApp.client
                      AND LopApp2.dr_created_time = 1
                      
            ) t2
            WHERE DATEDIFF(hour, t2.first_task, LopApp.created_time) <= 72
		  AND LopApp.writer_active = 1
		  AND LopApp.created_time >= @StartMonth
		  and LopApp.[Writer]= 'Michelle Johnson' and CONVERT( NCHAR(7), LopApp.created_time, 120) = '2018-10';