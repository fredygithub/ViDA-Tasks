use track
go

declare
    @user NVARCHAR(25) = 'Allison Seib'
    ,@package_name NVARCHAR(25)
    ,@MonthDate datetime = '04/01/2018'
  --  ,@client_name nvarchar(50)  = 'Alex Zhang'-- 'AJ Stark'

   SELECT DISTINCT c.name Profiles
    FROM users u
	    INNER JOIN roles r ON r.role_id = u.role_id
	    INNER JOIN tasks ON r.role_id = tasks.role_id
	    INNER JOIN trackings t ON t.user_id = u.user_id and t.task_id = tasks.task_id
	    INNER JOIN clients c ON c.client_id = t.client_id 
	    INNER JOIN sites ON sites.site_id = t.site_id
    WHERE(tasks.task LIKE '%Profile%Creat%'
		OR tasks.task LIKE '%Profile%Edit%')
		and u.active = 1
	    AND u.name = @user
	    AND --FORMAT(t.[created_time], 'MM/yyyy') = FORMAT(@MonthDate, 'MM/yyyy')
		  Month(t.[created_time]) = Month(@MonthDate) AND Year(t.[created_time]) = Year(@MonthDate)


SELECT u.name writer,
	  r.role,
       c.name client,
	  tasks.task,
	  tasks.task_id,
	  sites.site,
	  t.*
       --SUM(CASE
       --        WHEN tasks.task LIKE '%Profile%Creat%'
       --        THEN 1
       --        ELSE 0
       --    END) CreationTasks,
       --SUM(CASE
       --        WHEN tasks.task LIKE '%Profile%Edit%'
       --        THEN 1
       --        ELSE 0
       --    END) EditionTasks,
       --RIGHT('0'+CONVERT( VARCHAR(5), SUM(DATEDIFF(second, t.start, t.[end])) / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(DATEDIFF(second, t.start, t.[end])) / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(DATEDIFF(second, t.start, t.[end])) % 60), 2) TotalHoursTime
FROM users u
     INNER JOIN roles r ON r.role_id = u.role_id
     INNER JOIN tasks ON r.role_id = tasks.role_id
     INNER JOIN trackings t ON t.user_id = u.user_id and t.task_id = tasks.task_id
     INNER JOIN clients c ON c.client_id = t.client_id 
	INNER JOIN sites ON sites.site_id = t.site_id
WHERE(tasks.task LIKE '%Profile%Creat%'
      OR tasks.task LIKE '%Profile%Edit%')	 
	 and u.active = 1
     AND u.name = @user
	AND Month(t.[created_time]) = Month(@MonthDate) AND Year(t.[created_time]) = Year(@MonthDate)
--and c.name = @client_name
--GROUP BY u.name,r.role,
--         c.name
ORDER BY u.name,--t.start,u.name,		    
         c.name,
	    tasks.task,
	    t.start;



select *
from
(
    SELECT u.name writer,
		 r.role,
		 c.name client,
		 tasks.task,
		 SUM(CASE
		         WHEN tasks.task LIKE '%Profile%Creat%'
		         THEN 1
		         ELSE 0
		     END) CreationTasks,
		 SUM(CASE
		         WHEN tasks.task LIKE '%Profile%Edit%'
		         THEN 1
		         ELSE 0
		     END) EditionTasks,
		 RIGHT('0'+CONVERT( VARCHAR(5), SUM(DATEDIFF(second, t.start, t.[end])) / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(DATEDIFF(second, t.start, t.[end])) / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(DATEDIFF(second, t.start, t.[end])) % 60), 2) TotalHoursTime
		 ,COUNT(DISTINCT c.name) Profiles
    FROM users u
	    INNER JOIN roles r ON r.role_id = u.role_id
	    INNER JOIN tasks ON r.role_id = tasks.role_id
	    INNER JOIN trackings t ON t.user_id = u.user_id and t.task_id = tasks.task_id
	    INNER JOIN clients c ON c.client_id = t.client_id 
	    INNER JOIN sites ON sites.site_id = t.site_id
    WHERE(tasks.task LIKE '%Profile%Creat%'
		OR tasks.task LIKE '%Profile%Edit%')
		and u.active = 1
	    AND u.name = @user
	    AND Month(t.[created_time]) = Month(@MonthDate) AND Year(t.[created_time]) = Year(@MonthDate)
    GROUP BY
		  u.name,
		  r.role,
		  c.name,
		  tasks.task

) LogApp

    ORDER BY writer,		    
		   client,
		   task--,
		   --t.start


select writer,
	   [role],
	   FORMAT(@MonthDate, 'MM/yyyy') DatePeriod,
	  -- task,
	  sum(CreationTasksCount) CreationTasksCount,
	  RIGHT('0'+CONVERT( VARCHAR(5), SUM(CreationTasksTime) / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(CreationTasksTime) / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(CreationTasksTime) % 60), 2) TotalCreationTasksTime,
	  RIGHT('0'+CONVERT( VARCHAR(5), SUM(CreationTasksTime)/Profiles / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(CreationTasksTime)/Profiles / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(CreationTasksTime)/Profiles % 60), 2) AvgCreationTasksTime,
	  sum(EditionTasksCount) EditionTasksCount,
	  RIGHT('0'+CONVERT( VARCHAR(5), SUM(EditionTasksTime) / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(EditionTasksTime) / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(EditionTasksTime) % 60), 2) TotalEditionTasksTime,
	  RIGHT('0'+CONVERT( VARCHAR(5), SUM(EditionTasksTime)/Profiles / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(EditionTasksTime)/Profiles / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(EditionTasksTime)/Profiles % 60), 2) AvgEditionTasksTime,
	   Profiles,
	   RIGHT('0'+CONVERT( VARCHAR(5), SUM(SumTotalTime) / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(SumTotalTime) / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(SumTotalTime) % 60), 2) TotalHoursTime
from
(
    SELECT u.name writer,
		 r.role,
		-- c.name client,
		-- tasks.task,
		 SUM(CASE
		         WHEN tasks.task LIKE '%Profile%Creat%'
		         THEN 1
		         ELSE 0
		     END) CreationTasksCount,
		 SUM(CASE
		         WHEN tasks.task LIKE '%Profile%Edit%'
		         THEN 1
		         ELSE 0
		     END) EditionTasksCount,
		  SUM(CASE
		         WHEN tasks.task LIKE '%Profile%Creat%'
		         THEN DATEDIFF(second, t.start, t.[end])
		         ELSE 0
		     END) CreationTasksTime,
		 SUM(CASE
		         WHEN tasks.task LIKE '%Profile%Edit%'
		         THEN DATEDIFF(second, t.start, t.[end])
		         ELSE 0
		     END) EditionTasksTime,
		 --RIGHT('0'+CONVERT( VARCHAR(5), SUM(DATEDIFF(second, t.start, t.[end])) / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(DATEDIFF(second, t.start, t.[end])) / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(DATEDIFF(second, t.start, t.[end])) % 60), 2) TotalHoursTime
		 SUM(DATEDIFF(second, t.start, t.[end])) SumTotalTime
		 ,COUNT(DISTINCT c.name) Profiles
    FROM users u
	    INNER JOIN roles r ON r.role_id = u.role_id
	    INNER JOIN tasks ON r.role_id = tasks.role_id
	    INNER JOIN trackings t ON t.user_id = u.user_id and t.task_id = tasks.task_id
	    INNER JOIN clients c ON c.client_id = t.client_id 
	    INNER JOIN sites ON sites.site_id = t.site_id
    WHERE(tasks.task LIKE '%Profile%Creat%'
		OR tasks.task LIKE '%Profile%Edit%')
		and u.active = 1
	    --AND u.name = @user
	    AND Month(t.[created_time]) = Month(@MonthDate) AND Year(t.[created_time]) = Year(@MonthDate)
    GROUP BY
		  u.name,
		  r.role
		-- c.name,
		 -- tasks.task

) LogApp
    GROUP BY writer, [role], Profiles--, task, Profiles
    ORDER BY writer--,task
