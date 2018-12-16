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
    

 SELECT 
			 acc.[Clients Name],
			 users.[First Name] + ' '+ users.[Last Name] [Writer],
			 acc.[Clients Name] [Client],
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
		    AND tasks.[Created Time]>=@StartMonth
		    AND tasks.[Closed Time]<= GETDATE()
    		and acc.[Clients Name] = 'Songtai Li'--'Alisa Sondak'--'Joan Leger'	


 SELECT u.name writer,
           --r.role,
		 c.name client_name,
		 package_hours,
		 DATEDIFF(second, t.start, t.[end])/60 TotalTime,
          *
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
          AND t.created_time >= @StartMonth	
		and c.name = 'Songtai Li'--'Alisa Sondak'--'Joan Leger'			
		  -- 'Alisa Sondak' -- more than 72 hours on a creation profile task
   