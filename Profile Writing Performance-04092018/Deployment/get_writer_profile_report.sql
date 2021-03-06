USE [TRACK]
GO
/****** Object:  StoredProcedure [dbo].[get_writer_profile_report]    Script Date: 4/9/2018 20:42:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[get_writer_profile_report]
AS
 DECLARE @StartMonth DATETIME = DATEADD(DAY,1,EOMONTH(GETDATE(),-3))

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
			 WHERE packages.package_name NOT LIKE '%deposit%'
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

DECLARE @tmp_CRMFirstDrafts TABLE
([Writer]       NVARCHAR(100),
 [Client]       NVARCHAR(100),
 [MonthPeriod]  NVARCHAR(7),
 CreationTaskTime INT,
 EditionTaskTime INT
);
INSERT INTO @tmp_CRMFirstDrafts
([Writer],
 [Client],
 [MonthPeriod],
 CreationTaskTime,
 EditionTaskTime
)
 SELECT [Writer], [Client], [MonthPeriod], sum(case when tasktype = 'Creation' then taskTime else 0 end) CreationTaskTime
	   , sum(case when tasktype = 'Edition' then taskTime else 0 end) EditionTaskTime
    FROM (
    SELECT ROW_NUMBER() OVER(
			 PARTITION BY users.[First Name] + ' '+ users.[Last Name] 
			 , acc.[Clients Name]
			 , case when ([subject] like '%creation%' OR tasks.Type ='Profile creation') then 'Creation' else 'Edition' end
			 ORDER BY users.[First Name] + ' '+ users.[Last Name], acc.[Clients Name], case when [subject] like '%creation%' then 'Creation' else 'Edition' end) AS Row#,
		  case when ([subject] like '%creation%' OR tasks.Type ='Profile creation') then 'Creation' else 'Edition' end tasktype,
           CONVERT(NCHAR(7),tasks.[Created Time],120) [MonthPeriod],
		 users.[First Name] + ' '+ users.[Last Name] [Writer],
		 acc.[Clients Name] [Client],
 		 DATEDIFF(second, tasks.[Created Time], tasks.[Closed Time]) taskTime
	   FROM VIDA.dbo.tasks inner join
		    VIDA.dbo.accounts acc
		    ON acc.[Clients Id]=tasks.[Related To] 
		    INNER JOIN
		    VIDA.dbo.users 
		    ON users.[User Id]= tasks.[Task Owner Id]             
			  WHERE [Related To] IS NOT NULL
		    AND tasks.Type in ('Profile creation','Profile Editing')
		    AND tasks.[Created Time]>=@StartMonth
		    AND tasks.[Closed Time]<= GETDATE()
	   ) t where Row# = 1
	   group by [Writer], [Client], [MonthPeriod]
	   
	     
SELECT LogApp.writer,
	  DENSE_RANK() OVER(ORDER BY LogApp.writer) AS WriterNumber,
	  DENSE_RANK() OVER(partition by LogApp.writer ORDER BY LogApp.writer,LogApp.client_name) AS NumberClients,
	  LogApp.client_name,
	  LogApp.package_hours,
	  SUM(LogApp.CreationTasksTime) TotalCreationTasksTime,
 	  SUM(LogApp.EditionTasksTime) TotalEditionTasksTime,
	  --Sum(LogApp.[units]) [SumUnits],
	  SUM(LogApp.SumTotalTime) TotalHoursTime	  
	  ,LogApp.[MonthPeriod]
	  ,LogApp.ClientInitialPackage
	  ,SUM(ISNULL(CRMFirstDrafts.CreationTaskTime,0)) CRM_CreationTaskTime
	  ,SUM(ISNULL(CRMFirstDrafts.EditionTaskTime,0)) CRM_EditionTaskTime
FROM
(
    SELECT u.name writer,
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
           SUM(DATEDIFF(second, t.start, t.[end])) SumTotalTime
		 --,SUM(t.units) units
		 ,CONVERT(NCHAR(7),t.created_time,120) [MonthPeriod]
		 ,ClientFirstPackage.package_name ClientInitialPackage
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
          AND t.created_time >= @StartMonth				
    GROUP BY u.name,
             r.[role]
		   ,c.name
		   ,package_hours
		   ,CONVERT(NCHAR(7),t.created_time,120)
		   ,ClientFirstPackage.package_name   
) LogApp
    LEFT JOIN @tmp_CRMFirstDrafts CRMFirstDrafts 
	   ON CRMFirstDrafts.[Client] = LogApp.client_name 
	   AND CRMFirstDrafts.[Writer] = LogApp.[Writer]
	   AND CRMFirstDrafts.[MonthPeriod] = LogApp.[MonthPeriod]
GROUP BY LogApp.writer,
	    LogApp.client_name,
	    LogApp.package_hours,
	    LogApp.[MonthPeriod],
	    LogApp.ClientInitialPackage



