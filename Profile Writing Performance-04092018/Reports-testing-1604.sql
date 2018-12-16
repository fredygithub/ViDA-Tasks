-->------------------------------------------------
--> REPORT BY WRITER WITH CLIENT, TIMES AND AVERAGE
-->------------------------------------------------
select *
    from clients c
    inner join bills b on b.client_id = c.client_id
    left join packages p on p.monthly_hours = b.hours
    where 
	   c.active = 1--c.name = 'AJ Stark'
    order by c.name, p.package_name

declare
    @user NVARCHAR(25) = 'Allison Seib'
    ,@package_name NVARCHAR(25)
    ,@client_name nvarchar(50)  = 'Alex Zhang'-- 'AJ Stark'

SELECT u.name writer,
	  r.role,
       c.name client,
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
FROM users u
     INNER JOIN roles r ON r.role_id = u.role_id
     INNER JOIN tasks ON r.role_id = tasks.role_id
     INNER JOIN trackings t ON t.user_id = u.user_id
     INNER JOIN clients c ON c.client_id = t.client_id
WHERE(tasks.task LIKE '%Profile%Creat%'
      OR tasks.task LIKE '%Profile%Edit%')
	 and u.active = 1
     --AND u.name = @user
and c.name = @client_name
GROUP BY u.name,r.role,
         c.name
ORDER BY u.name,
         c.name;
-->------------------------------------------------
--> REPORT BY WRITER WITH CLIENT, TIMES AND AVERAGE
-->------------------------------------------------


-->----------------------------------------
--> REPORT BY WRITER WITH TIMES AND AVERAGE
-->----------------------------------------
SELECT *, CONVERT(VARCHAR(5), (TotalTime/ClientCount)/60/60)
		+ ':' + RIGHT('0' + CONVERT(VARCHAR(2), (TotalTime/ClientCount)/60%60), 2)
		+ ':' + RIGHT('0' + CONVERT(VARCHAR(2), (TotalTime/ClientCount) % 60), 2) AverageProfileTime
    FROM (E
SELECT        trackings.user_id, tasks.role_id,			 
			 SUM(CASE
               WHEN tasks.task LIKE '%Profile%Creat%'
               THEN 1
               ELSE 0
           END) CreationTasks,
			 SUM(CASE
               WHEN tasks.task LIKE '%Profile%Creat%'
               THEN DATEDIFF(second, trackings.start, trackings.[end])
               ELSE 0
			END) TimeProfileCreation,
			SUM(CASE
               WHEN tasks.task LIKE '%Profile%Edit%'
               THEN 1
               ELSE 0
           END) EditionTasks,
			 SUM(CASE
			    WHEN tasks.task LIKE '%Profile%Edit%'
			    THEN DATEDIFF(second, trackings.start, trackings.[end])
			    ELSE 0
			END) TimeProfileEdition
			, SUM(DATEDIFF(second, trackings.start, trackings.[end])) TotalTime
			 , count(distinct trackings.client_id) ClientCount	 
FROM            tasks INNER JOIN
                         roles ON tasks.role_id = roles.role_id INNER JOIN
                         trackings ON tasks.task_id = trackings.task_id
WHERE        (tasks.task LIKE '%Profile%Creat%') OR
                         (tasks.task LIKE '%Profile%Edit%')
					GROUP BY trackings.user_id, tasks.role_id--, trackings.client_id

) t order by t.[user_id]
-->----------------------------------------
--> REPORT BY WRITER WITH TIMES AND AVERAGE
-->----------------------------------------