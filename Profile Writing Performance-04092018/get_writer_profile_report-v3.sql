USE TRACK;
GO
-- get_writer_profile_report 'ALL',NULL, 5
ALTER PROCEDURE dbo.get_writer_profile_report( 
   -- @client_name NVARCHAR(50)='ALL',
    @package_name NVARCHAR(25)= 'ALL',
    @LastTreeMonth DATETIME,
    @MinProfileCount INT = 5
    )
AS

IF @LastTreeMonth IS NULL
    SET @LastTreeMonth = DATEADD(DAY, -90, GETDATE());
DECLARE @tmp_ClientFirstPackage TABLE
(client             NVARCHAR(50),
 firstPayrollPeriod DATE,
 package_name       NVARCHAR(25),
 package_color      NVARCHAR(7)
);
INSERT INTO @tmp_ClientFirstPackage
(client,
 [firstPayrollPeriod],
 package_name,
 package_color
)
       SELECT client_name,
              [firstPayrollPeriod],
              package_name [Package Name],
              package_color [Package Color]
       FROM
       (
           SELECT name client_name,
                  bill_date [firstPayrollPeriod],
                  package_name,
                  package_color,
                  RowNumber
           FROM
           (
               SELECT clients.name,
                      bills.bill_date,
                      clients.active,
                      ROW_NUMBER() OVER(PARTITION BY bills.client_id ORDER BY bill_date ASC) AS RowNumber,
                      package_name,
                      package_color
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
    from Roles inner join
    tasks on roles.role_id = tasks.role_id
where
    roles.[role] in ('Profile Writer','Closer')
    AND tasks.task in ('Profile Creation','Profile Editing','Simple Profile Creation','Simple Profile Editing')

      /*--SELECT 'Daily Profile Edits',
       --       0 isCreationTask
       --UNION
       SELECT 'Profile Creation',
              1 isCreationTask
       UNION
       SELECT 'Profile Editing',
              0 isCreationTask
       --UNION
       --SELECT 'Profile Writing',
       --       1 isCreationTask
       UNION
       SELECT 'Simple Profile Creation',
              1 isCreationTask
       UNION
       SELECT 'Simple Profile Editing',
              0 isCreationTask;*/
SELECT writer,
       [role],
	  client_name,
	  SUM(CreationTasksTime) TotalCreationTasksTime,
       --RIGHT('0'+CONVERT( VARCHAR(5), SUM(CreationTasksTime) / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(CreationTasksTime) / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(CreationTasksTime) % 60), 2) TotalCreationTasksTime,
	  SUM(CreationTasksTime) / Profiles AvgCreationTasksTime,
       --RIGHT('0'+CONVERT( VARCHAR(5), SUM(CreationTasksTime) / Profiles / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(CreationTasksTime) / Profiles / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(CreationTasksTime) / Profiles % 60), 2) AvgCreationTasksTime,
	  SUM(EditionTasksTime) TotalEditionTasksTime,
       --RIGHT('0'+CONVERT( VARCHAR(5), SUM(EditionTasksTime) / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(EditionTasksTime) / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(EditionTasksTime) % 60), 2) TotalEditionTasksTime,
	  SUM(EditionTasksTime) / Profiles AvgEditionTasksTime,
       --RIGHT('0'+CONVERT( VARCHAR(5), SUM(EditionTasksTime) / Profiles / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(EditionTasksTime) / Profiles / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(EditionTasksTime) / Profiles % 60), 2) AvgEditionTasksTime,
       Profiles,
	  SUM(SumTotalTime) TotalHoursTime
       --RIGHT('0'+CONVERT( VARCHAR(5), SUM(SumTotalTime) / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(SumTotalTime) / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(SumTotalTime) % 60), 2) TotalHoursTime
FROM
(
    SELECT u.name writer,
           r.role,
		 c.name client_name,
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
          --AND (c.name = @client_name
          --     OR UPPER(@client_name) = 'ALL')
          AND t.created_time >= @LastTreeMonth
          AND (ClientFirstPackage.package_name = @package_name
               OR UPPER(@package_name) = 'ALL')
		
    GROUP BY u.name,
             r.[role]
		   ,c.name
    --HAVING COUNT(DISTINCT c.name) > @MinProfileCount
) LogApp
GROUP BY writer,
         [role],
	    client_name,
         Profiles
ORDER BY writer;

   -- SELECT c.name, tasks.task, t.*
   -- FROM users u
   --      INNER JOIN roles r ON r.role_id = u.role_id
   --      INNER JOIN tasks ON r.role_id = tasks.role_id
   --      INNER JOIN trackings t ON t.user_id = u.user_id
   --                                AND t.task_id = tasks.task_id
   --      INNER JOIN clients c ON c.client_id = t.client_id
   --      INNER JOIN sites ON sites.site_id = t.site_id
   --      INNER JOIN @tmp_Roles roles ON roles.roleName = tasks.task
   --      LEFT JOIN @tmp_ClientFirstPackage ClientFirstPackage ON ClientFirstPackage.client = c.name
   -- WHERE --u.active = 1 AND 
	  -- (c.name = @client_name
   --            OR UPPER(@client_name) = 'ALL')
   --       AND t.created_time >= @LastTreeMonth
   --       AND (ClientFirstPackage.package_name = @package_name
   --            OR UPPER(@package_name) = 'ALL')
			--and  c.name = 'Ada Cooper'

