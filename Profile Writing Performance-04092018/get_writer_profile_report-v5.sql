USE TRACK;
GO
-- get_writer_profile_report 'ALL',NULL, 5
ALTER PROCEDURE dbo.get_writer_profile_report( 
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
    from Roles inner join
    tasks on roles.role_id = tasks.role_id
where
    roles.[role] in ('Profile Writer','Closer')
    AND tasks.task in ('Profile Creation','Profile Editing','Simple Profile Creation','Simple Profile Editing')

  
SELECT writer,
       [role],
	  client_name,
	  package_hours,
	  SUM(CreationTasksTime) TotalCreationTasksTime,
	  SUM(CreationUnitsCount) CreationUnitsCount,
	  CASE WHEN SUM(CreationUnitsCount)>0 THEN SUM(CreationTasksTime) / SUM(CreationUnitsCount) ELSE 0 END AvgCreationTasksTime,
 	  SUM(EditionTasksTime) TotalEditionTasksTime,
	  SUM(EditionUnitsCount) EditionUnitsCount,
 	  CASE WHEN SUM(EditionUnitsCount)>0 THEN SUM(EditionTasksTime) / SUM(EditionUnitsCount) ELSE 0 END AvgEditionTasksTime,
       ClientCount,
	  Sum([units]) [SumUnits],
	  SUM(SumTotalTime) TotalHoursTime	  
FROM
(
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
           COUNT(DISTINCT c.name) ClientCount
		 ,SUM(CASE
                   WHEN isCreationTask = 1
                   THEN t.units
                   ELSE 0
               END) CreationUnitsCount,
           SUM(CASE
                   WHEN isCreationTask = 0
                   THEN t.units
                   ELSE 0
               END) EditionUnitsCount
		 ,SUM(t.units) units
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
) LogApp
GROUP BY writer,
         [role],
	    client_name,
	    package_hours,
         ClientCount
--ORDER BY SUM(CreationUnitsCount) desc, CASE WHEN SUM(CreationUnitsCount)>0 THEN SUM(CreationTasksTime) / SUM(CreationUnitsCount) ELSE 0 END desc;
