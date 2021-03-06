USE [TRACK];
GO

/****** Object:  StoredProcedure [dbo].[get_writer_profile_report]    Script Date: 4/9/2018 20:42:35 ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
ALTER PROCEDURE [dbo].[get_writer_profile_report]
AS
     DECLARE @StartMonth DATETIME= DATEADD(DAY, 1, EOMONTH(GETDATE(), -3));
     IF OBJECT_ID('tempdb.dbo.#tmp_ClientFirstPackage', 'U') IS NOT NULL
         DROP TABLE #tmp_ClientFirstPackage;
     CREATE TABLE #tmp_ClientFirstPackage
     (client             NVARCHAR(50),
      [client_id]        INT,
      firstPayrollPeriod DATE,
      package_name       NVARCHAR(25),
      package_color      NVARCHAR(7),
      package_hours      FLOAT
     );
     INSERT INTO #tmp_ClientFirstPackage
     (client,
      [client_id],
      [firstPayrollPeriod],
      package_name,
      package_color,
      package_hours
     )
            SELECT client_name,
                   [client_id],
                   [firstPayrollPeriod],
                   package_name [Package Name],
                   package_color [Package Color],
                   monthly_hours [Package Hours]
            FROM
            (
                SELECT name client_name,
                       [client_id],
                       bill_date [firstPayrollPeriod],
                       package_name,
                       package_color,
                       monthly_hours,
                       RowNumber
                FROM
                (
                    SELECT clients.name,
                           clients.[client_id],
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
     IF OBJECT_ID('tempdb.dbo.#tmp_CRMFirstDrafts', 'U') IS NOT NULL
         DROP TABLE #tmp_CRMFirstDrafts;
     CREATE TABLE #tmp_CRMFirstDrafts
     ([Writer]         NVARCHAR(100),
      [Client]         NVARCHAR(100),
      [MonthPeriod]    NVARCHAR(7),
      CreationTaskTime INT,
      EditionTaskTime  INT
     );
     INSERT INTO #tmp_CRMFirstDrafts
     ([Writer],
      [Client],
      [MonthPeriod],
      CreationTaskTime,
      EditionTaskTime
     )
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
            ) t
            WHERE Row# = 1
            GROUP BY [Writer],
                     [Client],
                     [MonthPeriod];
     IF OBJECT_ID('tempdb.dbo.#tmp_LopApp', 'U') IS NOT NULL
         DROP TABLE #tmp_LopApp;
     CREATE TABLE #tmp_LopApp
     ([Writer]        NVARCHAR(100),
      [user_id]       BIGINT,
      [Client]        NVARCHAR(100),
      [client_id]     BIGINT,
      created_time    DATETIME,
      dr_created_time INT,
      isCreationTask  BIT
     );
     INSERT INTO #tmp_LopApp
     ([Writer],
      [user_id],
      [Client],
      [client_id],
      created_time,
      dr_created_time,
      isCreationTask
     )
            SELECT u.name writer,
                   u.[user_id],
                   c.name client_name,
                   c.[client_id],
                   t.created_time,
                   DENSE_RANK() OVER(PARTITION BY u.name,
                                                  c.name ORDER BY iscreationtask DESC,
                                                                  t.created_time) dr_created_time,
                   roles.isCreationTask
            FROM users u
                 INNER JOIN roles r ON r.role_id = u.role_id
                 INNER JOIN tasks ON r.role_id = tasks.role_id
                 INNER JOIN trackings t ON t.user_id = u.user_id
                                           AND t.task_id = tasks.task_id
                 INNER JOIN clients c ON c.client_id = t.client_id
                 INNER JOIN @tmp_Roles roles ON roles.role_id = tasks.role_id
                                                AND roles.taskName = tasks.task
            WHERE u.active = 1;

     IF OBJECT_ID('tempdb.dbo.#tmp_LopApp2', 'U') IS NOT NULL
         DROP TABLE #tmp_LopApp2;
     CREATE TABLE #tmp_LopApp2
     ([Writer]        NVARCHAR(100),
      [user_id]       BIGINT,
      [Client]        NVARCHAR(100),
      [client_id]     BIGINT,
      created_time    DATETIME,
      dr_created_time INT,
      isCreationTask  BIT
     );
     INSERT INTO #tmp_LopApp2
     ([Writer],
      [user_id],
      [Client],
      [client_id],
      created_time,
      dr_created_time,
      isCreationTask
     )
            SELECT LopApp.[Writer],
                   LopApp.[user_id],
                   LopApp.[Client],
                   LopApp.[client_id],
                   LopApp.created_time,
                   LopApp.dr_created_time,
                   isCreationTask
            FROM #tmp_LopApp LopApp
                 OUTER APPLY
            (
                SELECT created_time first_task
                FROM #tmp_LopApp LopApp2
                WHERE LopApp2.writer = LopApp.writer
                      AND LopApp2.client = LopApp.client
                      AND LopApp2.dr_created_time = 1
                      AND LopApp2.created_time >= @StartMonth
            ) t2
            WHERE DATEDIFF(hour, t2.first_task, LopApp.created_time) <= 72;


     SELECT LogAppFinal.writer,
            DENSE_RANK() OVER(ORDER BY LogAppFinal.writer) AS WriterNumber,
            LogAppFinal.client_name,
		  DENSE_RANK() OVER(PARTITION BY LogAppFinal.writer ORDER BY LogAppFinal.client_name) AS ClientNumber,
            LogAppFinal.package_hours,
            SUM(LogAppFinal.CreationTasksTime) TotalCreationTasksTime,
            SUM(LogAppFinal.EditionTasksTime) TotalEditionTasksTime,
            SUM(LogAppFinal.[units]) [SumUnits],
            SUM(LogAppFinal.SumTotalTime) TotalHoursTime,
            LogAppFinal.[MonthPeriod],
            LogAppFinal.ClientInitialPackage,
            SUM(ISNULL(CRMFirstDrafts.CreationTaskTime, 0)) CRM_CreationTaskTime,
            SUM(ISNULL(CRMFirstDrafts.EditionTaskTime, 0)) CRM_EditionTaskTime
     FROM
     (
         SELECT #tmp_LopApp2.writer,
                #tmp_LopApp2.client client_name,
                ClientFirstPackage.package_hours,
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
                SUM(t.units) units,
                CONVERT( NCHAR(7), t.created_time, 120) [MonthPeriod],
                ClientFirstPackage.package_name ClientInitialPackage
         FROM #tmp_LopApp2
              INNER JOIN trackings t ON t.[user_id] = #tmp_LopApp2.[user_id]
                                        AND t.client_id = #tmp_LopApp2.client_id
                                        AND t.created_time = #tmp_LopApp2.created_time
              LEFT JOIN #tmp_ClientFirstPackage ClientFirstPackage ON ClientFirstPackage.[client_id] = #tmp_LopApp2.[client_id]
         GROUP BY #tmp_LopApp2.writer,
                  #tmp_LopApp2.client,
                  package_hours,
                  CONVERT( NCHAR(7), t.created_time, 120),
                  ClientFirstPackage.package_name
     ) LogAppFinal
     LEFT JOIN #tmp_CRMFirstDrafts CRMFirstDrafts ON CRMFirstDrafts.[Client] = LogAppFinal.client_name
                                                     AND CRMFirstDrafts.[Writer] = LogAppFinal.[Writer]
                                                     AND CRMFirstDrafts.[MonthPeriod] = LogAppFinal.[MonthPeriod]
     GROUP BY LogAppFinal.writer,
              LogAppFinal.client_name,
              LogAppFinal.package_hours,
              LogAppFinal.[MonthPeriod],
              LogAppFinal.ClientInitialPackage;