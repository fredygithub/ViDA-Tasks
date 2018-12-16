USE TRACK;
GO

--alter procedure dbo.get_writer_profile_report( @client NVARCHAR(50)='ALL',
--  @package_name NVARCHAR(25)= 'ALL')
--AS

DECLARE @LastTreeMonth DATETIME= DATEADD(DAY, -90, GETDATE()), @client_name NVARCHAR(50)= 'ALL', @package_name NVARCHAR(25)= 'ALL';
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
              [Last Package Name],
              [Last Package Color]
       FROM
       (
           SELECT clients.name client_name,
                  CASE
                      WHEN [Month] IS NOT NULL
                      THEN CAST([Month]+'-01' AS       DATE)
                      ELSE NULL
                  END [firstPayrollPeriod],
                  ROW_NUMBER() OVER(PARTITION BY payroll_client.client ORDER BY CASE
                                                                                    WHEN [Month] IS NOT NULL
                                                                                    THEN CAST([Month]+'-01' AS DATE)
                                                                                    ELSE NULL
                                                                                END ASC) AS RowNumber,
                  *
           FROM clients
                LEFT JOIN payroll_client ON clients.name = payroll_client.client
			 WHERE ACTIVE =1
       ) t
       WHERE (RowNumber=1 OR [Month] IS NULL)  
       ORDER BY client,
                RowNumber;
DECLARE @tmp_Roles TABLE
(id             INT IDENTITY,
 roleName       NVARCHAR(100),
 isCreationTask BIT
);
INSERT INTO @tmp_Roles
(roleName,
 isCreationTask
)
       SELECT 'Daily Profile Edits',
              0 isCreationTask
       UNION
       SELECT 'Profile Creation',
              1 isCreationTask
       UNION
       SELECT 'Profile Editing',
              0 isCreationTask
       UNION
       SELECT 'Profile Writing',
              1 isCreationTask
       UNION
       SELECT 'Simple Profile Creation',
              1 isCreationTask
       UNION
       SELECT 'Simple Profile Editing',
              0 isCreationTask;
SELECT writer,
       role, 
                                                       
       /*sum( CreationTasksCount )                                                                                                                                                                                                                         CreationTasksCount,*/
 
       RIGHT('0'+CONVERT( VARCHAR(5), SUM(CreationTasksTime) / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(CreationTasksTime) / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(CreationTasksTime) % 60), 2) TotalCreationTasksTime,
       RIGHT('0'+CONVERT( VARCHAR(5), SUM(CreationTasksTime) / Profiles / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(CreationTasksTime) / Profiles / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(CreationTasksTime) / Profiles % 60), 2) AvgCreationTasksTime, 
                                                       
       /*SUM( EditionTasksCount )                                                                                                                                                                                                                          EditionTasksCount,*/
 
       RIGHT('0'+CONVERT( VARCHAR(5), SUM(EditionTasksTime) / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(EditionTasksTime) / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(EditionTasksTime) % 60), 2) TotalEditionTasksTime,
       RIGHT('0'+CONVERT( VARCHAR(5), SUM(EditionTasksTime) / Profiles / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(EditionTasksTime) / Profiles / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(EditionTasksTime) / Profiles % 60), 2) AvgEditionTasksTime,
       Profiles,
       RIGHT('0'+CONVERT( VARCHAR(5), SUM(SumTotalTime) / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(SumTotalTime) / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(SumTotalTime) % 60), 2) TotalHoursTime
FROM
(
    SELECT u.name writer,
           r.role,
           SUM(CASE
                   WHEN isCreationTask = 1 

               /*tasks.task LIKE '%Profile%Creat%'*/

                   THEN 1
                   ELSE 0
               END) CreationTasksCount,
           SUM(CASE
                   WHEN isCreationTask = 0 

               /*tasks.task LIKE '%Profile%Edit%'*/

                   THEN 1
                   ELSE 0
               END) EditionTasksCount,
           SUM(CASE
                   WHEN isCreationTask = 1 

               /*tasks.task LIKE '%Profile%Creat%'*/

                   THEN DATEDIFF(second, t.start, t.[end])
                   ELSE 0
               END) CreationTasksTime,
           SUM(CASE
                   WHEN isCreationTask = 0 

               /*tasks.task LIKE '%Profile%Edit%'*/

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
         INNER JOIN @tmp_Roles roles ON roles.roleName = tasks.task
         LEFT JOIN @tmp_ClientFirstPackage ClientFirstPackage ON ClientFirstPackage.client = c.name
    WHERE u.active = 1
          AND (c.name = @client_name
               OR UPPER(@client_name) = 'ALL')
          AND t.created_time >= @LastTreeMonth
          AND (ClientFirstPackage.package_name = @package_name
               OR UPPER(@package_name) = 'ALL')
    GROUP BY u.name,
             r.role
) LogApp
GROUP BY writer,
         role,
         Profiles
ORDER BY writer;