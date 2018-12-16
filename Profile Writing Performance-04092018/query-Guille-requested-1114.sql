use track
go

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
    
declare @tmp_crm_createprofile table
    (client_name varchar(50), writer varchar(50), task_creationtime datetime, [subject] varchar(100))

insert into @tmp_crm_createprofile
 SELECT 
			 acc.[Clients Name],
			 users.[First Name] + ' '+ users.[Last Name] [Writer],
 		 --DATEDIFF(second, tasks.[Created Time], tasks.[Closed Time]) taskTime,
		 FORMAT(tasks.[created time],'MM-dd-yyyy HH:mm' ) [created time],
		  cast(tasks.[subject] as varchar(100))
	   FROM VIDA.dbo.tasks inner join
		    (select [Clients Id],[Clients Name] from VIDA.dbo.accounts where [created time]>@StartMonth) acc
		    ON acc.[Clients Id]=tasks.[Related To] 
		    INNER JOIN
		    VIDA.dbo.users 
		    ON users.[User Id]= tasks.[Task Owner Id]             
			  WHERE [Related To] IS NOT NULL
		    --AND tasks.Type in ('Profile creation','Profile Editing')
		    AND tasks.Type IN('Profile creation', 'Profile Editing')--='Profile creation'
		    AND tasks.[Created Time]>=@StartMonth
		    AND tasks.[Closed Time]<= GETDATE()
    		--and acc.[Clients Name] = 'Songtai Li'--'Alisa Sondak'--'Joan Leger'	

declare @tmp_logapp table
    (writer varchar(50), client_name varchar(50), [site] varchar(100), task_created datetime, [totaltime] varchar(100), dr_created_time int, dr_TotalTime int)
insert into @tmp_logapp
 SELECT u.name writer,
		 c.name client_name,
		 sites.[site],
		 t.created_time,
		 --FORMAT(t.created_time,'MM-dd-yyyy HH:mm' ) task_created,
		RIGHT('0'+CONVERT( VARCHAR(5), DATEDIFF(second, t.start, t.[end]) / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2),DATEDIFF(second, t.start, t.[end]) / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), DATEDIFF(second, t.start, t.[end]) % 60), 2) [totaltime],
		dense_rank() over (partition by u.name,c.name order by t.created_time) dr_created_time,
		dense_rank() over (partition by u.name,c.name order by DATEDIFF(second, t.start, t.[end]) desc) dr_TotalTime
    FROM users u
         INNER JOIN roles r ON r.role_id = u.role_id
         INNER JOIN tasks ON r.role_id = tasks.role_id
         INNER JOIN trackings t ON t.user_id = u.user_id
                                   AND t.task_id = tasks.task_id
         INNER JOIN clients c ON c.client_id = t.client_id
	    INNER JOIN (SELECT DISTINCT client_name FROM @tmp_crm_createprofile) crm_clients on crm_clients.client_name = c.name
         INNER JOIN sites ON sites.site_id = t.site_id
         INNER JOIN @tmp_Roles roles ON roles.role_id = tasks.role_id AND roles.taskName = tasks.task
         LEFT JOIN @tmp_ClientFirstPackage ClientFirstPackage ON ClientFirstPackage.client = c.name
    WHERE --u.active = 1
          t.created_time >= @StartMonth	
		--and
		 and tasks.task = 'Profile Creation'
		--and u.name = 'Allison Seib'
		--and c.name = 'Songtai Li'--'Alisa Sondak'--'Joan Leger'			
		  -- 'Alisa Sondak' -- more than 72 hours on a creation profile task
		 -- group by u.name, c.name, tasks.task, sites.[site]


select logapp.writer, logapp.client_name, logapp.[site], FORMAT(logapp.task_created,'MM-dd-yyyy HH:mm' ) task_created,  logapp.[totaltime]
    , case when logapp.dr_created_time=1 then 'First task' else '' end [first_task_indicator]
    , case when logapp.dr_TotalTime=1 then 'Major task' else '' end [major_task_indicator]
    , case when DATEDIFF(hour, logapp2.task_created, logapp.task_created)>72 then 'Additional task' else '' end [additional_task_indicator]
    ,DATEDIFF(hour, logapp2.task_created, logapp.task_created) [hours_diff_with_firsttask]
    ,CONVERT(NCHAR(7),logapp.task_created,120) [MonthPeriod]
from @tmp_logapp logapp
    left join  @tmp_logapp logapp2  on logapp2.writer = logapp.writer and logapp2.client_name = logapp.client_name
	   and  logapp2.dr_created_time=1
	   where 
	   CONVERT(NCHAR(7),logapp.task_created,120) = '2018-10'
	   and logapp.writer= 'Samantha Roma'
order by logapp.writer, logapp.client_name,logapp.[task_created]

