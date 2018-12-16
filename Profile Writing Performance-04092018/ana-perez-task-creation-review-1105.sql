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
    AND tasks.task = 'Profile Creation' --in ('Profile Creation','Profile Editing','Simple Profile Creation','Simple Profile Editing')
   
   
    SELECT u.name writer,
		 c.name client_name,
		 package_hours,
		 sites.[site],
		 tasks.task,
		 DATEDIFF(minute, t.start, t.[end]) [MinutesLoaded],
		 t.*
		 ,CONVERT(NCHAR(7),t.created_time,120) [MonthPeriod]
		 ,ClientFirstPackage.package_name ClientInitialPackage
		 --DISTINCT DATEDIFF(minute, t.start, t.[end])
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
		and u.name= 'Ana Perez'	
		--and c.name = 'Joan Leger'
    ORDER BY 
	  u.name, c.name,  t.created_time





IF OBJECT_ID('tempdb..#tmpTasks', 'U') IS NOT NULL
/*Then it exists*/
DROP TABLE #tmpTasks

    SELECT u.name writer,
		 c.name client_name,
		 tasks.task,
		 t.created_time,
		 t.[start],
		 t.[end]
		 --min(t.[end]) MinEnd,
		 --max(t.[end]) MaxEnd		
		 into #tmpTasks
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
		--order by 	u.name, c.name, t.created_time
		--and u.name= 'Ana Perez'
		--and c.name = 'Lucas Siegel'
    /*group by
		  u.name ,
		  c.name,
		  tasks.task*/

--SELECT * FROM #tmpTasks ORDER BY writer, client_name, created_time

SELECT  T1.writer, 
        T1.client_name, 
	   T1.[end],
--        T1.task, 
--	   T1.created_time,
        MIN(T2.[start]) AS Date2, 
        DATEDIFF(hour, T1.[end], MIN(T2.[start])) AS DaysDiff_WithNextTask
FROM    #tmpTasks T1
        LEFT JOIN #tmpTasks T2
            ON T1.writer = T2.writer
		  AND T1.client_name = T2.client_name
            AND T2.[start] > T1.[end]
GROUP BY T1.writer, T1.client_name, T1.[end]
having
    MIN(T2.[end]) is not null
    and DATEDIFF(hour, T1.[end], MIN(T2.[start]))>=72
order by T1.writer, 
        T1.client_name, T1.[end]


/*


 SELECT	  writer,
		  client_name,
		task,
		--DATEDIFF(minute, MinEnd, MaxEnd)/60 TimeGap		
		RIGHT('0'+CONVERT( VARCHAR(5), DATEDIFF(second, MinEnd, MaxEnd) / 60 / 60), 3)
		+':'+RIGHT('0'+CONVERT(VARCHAR(2), DATEDIFF(second, MinEnd, MaxEnd) / 60 % 60), 2)
		+':'+RIGHT('0'+CONVERT(VARCHAR(2), DATEDIFF(second, MinEnd, MaxEnd)), 2) [TimeGap]
		 FROM #tmpTasks

--	   select * from #tmpTasks 
--	   where client_name = 'Lucas Siegel'

--select 		 tmp.[MinutesLoaded],
--		  DATEDIFF(minute, t.[end], tmp.[end]) [TimeGap],
--		  * from
--(
--    SELECT u.name writer,
--		 c.name client_name,
--		 --package_hours,
--		 tasks.task,
--		 DATEDIFF(minute, t.start, t.[end]) [MinutesLoaded],

		 
--		 t.*
--		 ,CONVERT(NCHAR(7),t.created_time,120) [MonthPeriod]
--		 ,ClientFirstPackage.package_name ClientInitialPackage     
--    FROM users u
--         INNER JOIN roles r ON r.role_id = u.role_id
--         INNER JOIN tasks ON r.role_id = tasks.role_id
--         INNER JOIN trackings t ON t.user_id = u.user_id
--                                   AND t.task_id = tasks.task_id
--         INNER JOIN clients c ON c.client_id = t.client_id
--         INNER JOIN sites ON sites.site_id = t.site_id
--         INNER JOIN @tmp_Roles roles ON roles.role_id = tasks.role_id AND roles.taskName = tasks.task
--         LEFT JOIN @tmp_ClientFirstPackage ClientFirstPackage ON ClientFirstPackage.client = c.name
	    
--    WHERE u.active = 1
--          AND t.created_time >= @StartMonth			
--		and u.name= 'Ana Perez'	
--		and c.name = 'Lucas Siegel'
--		) t
--		left join #tmpTasks tmp on tmp.writer= t.writer and tmp.client_name= t.client_name and tmp.task = t.task --and tmp.[end]<>t.[end]

*/