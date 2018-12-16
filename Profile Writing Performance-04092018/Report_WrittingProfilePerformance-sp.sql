use track
go

--CREATE PROCEDURE Report_WrittingProfilePerformance
--(
--    @user NVARCHAR(25) = 'Allison Seib'
--    ,@package_name NVARCHAR(25)
--    ,@client_name nvarchar(50)  = 'Peter Biedak'
--)
--AS
declare
    @user NVARCHAR(25) = 'Allison Seib'
    ,@package_name NVARCHAR(25)
    ,@client_name nvarchar(50)  = 'AJ Stark'--'Peter Biedak'


--select DATEDIFF(hour,'2012-05-29 08:30:00.000','2012-05-29 15:00:00.000')
--,CONVERT(VARCHAR(5), DATEDIFF(second,'2012-05-29 08:30:00.000','2012-05-29 15:00:00.000')/60/60)
--		+ ':' + RIGHT('0' + CONVERT(VARCHAR(2), DATEDIFF(second,'2012-05-29 08:30:00.000','2012-05-29 15:00:00.000')/60%60), 2)
--		+ ':' + RIGHT('0' + CONVERT(VARCHAR(2), DATEDIFF(second,'2012-05-29 08:30:00.000','2012-05-29 15:00:00.000') % 60), 2)

--select  u.name writer, c.name client
--	   , t.start, t.[end]
--	   , datediff(hour, t.start, t.[end]) Hours_TotalTime
--	   , datediff(minute, t.start, t.[end]) Minutes_TotalTime
--	   , datediff(second, t.start, t.[end]) Seconds_TotalTime
--	   ,CONVERT(VARCHAR(5), datediff(second, t.start, t.[end])/60/60)
--		+ ':' + RIGHT('0' + CONVERT(VARCHAR(2), datediff(second, t.start, t.[end])/60%60), 2)
--		+ ':' + RIGHT('0' + CONVERT(VARCHAR(2), datediff(second, t.start, t.[end]) % 60), 2)
--    from users u 
--	   inner join roles r on r.role_id = u.role_id 
--        inner join tasks on r.role_id = tasks.role_id
--	   inner join trackings t on t.user_id = u.user_id
--	   inner join clients c on c.client_id = t.client_id
--    where
--	   (tasks.task like '%Profile%Creat%'
--	   or  tasks.task like '%Profile%Edit%')
--	   and u.name = @user
--	   and c.name = @client_name
--	   order by c.name

SELECT u.name writer,
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
--,CONVERT(VARCHAR(10), (sum(datediff(second, t.start, t.[end])) / 86400 )) + ' Days '
--      + CONVERT(VARCHAR(10), ( (sum(datediff(second, t.start, t.[end])) % 86400 ) / 3600 )) + ' Hours '
--      + CONVERT(VARCHAR(10), ( ( (sum(datediff(second, t.start, t.[end])) % 86400 ) % 3600 ) / 60 ))
--      + ' Minutes ' + CONVERT(VARCHAR(10), ( ( (sum(datediff(second, t.start, t.[end])) % 86400 ) % 3600 ) % 60 ))
--      + ' Seconds'
FROM users u
     INNER JOIN roles r ON r.role_id = u.role_id
     INNER JOIN tasks ON r.role_id = tasks.role_id
     INNER JOIN trackings t ON t.user_id = u.user_id
     INNER JOIN clients c ON c.client_id = t.client_id
WHERE(tasks.task LIKE '%Profile%Creat%'
      OR tasks.task LIKE '%Profile%Edit%')
     AND u.name = @user
--and c.name = @client_name
GROUP BY u.name,
         c.name
ORDER BY c.name;

SELECT [user_id], [role_id], CONVERT(VARCHAR(5), (SumTime/ClientCount)/60/60)
		+ ':' + RIGHT('0' + CONVERT(VARCHAR(2), (SumTime/ClientCount)/60%60), 2)
		+ ':' + RIGHT('0' + CONVERT(VARCHAR(2), (SumTime/ClientCount) % 60), 2) ProfileTime
FROM
(
SELECT        trackings.user_id, tasks.role_id--, tasks.task, trackings.client_id
			 , SUM(DATEDIFF(second, trackings.start, trackings.[end])) SumTime	
			 , count(distinct trackings.client_id) ClientCount	 
FROM            tasks INNER JOIN
                         roles ON tasks.role_id = roles.role_id INNER JOIN
                         trackings ON tasks.task_id = trackings.task_id
WHERE        (tasks.task LIKE '%Profile%Creat%') OR
                         (tasks.task LIKE '%Profile%Edit%')
					GROUP BY trackings.user_id, tasks.role_id
) t
--GROUP BY trackings.user_id, tasks.role_id--, tasks.task, trackings.client_id
order by [user_id]--, trackings.client_id
--ORDER BY c.name

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

/*
select --u.user_id, u.name writer, r.role, c.name client, tasks.task, tasks.group_description, t.* 
	   u.name writer, c.name client
	   , sum(case when tasks.task like '%Profile%Creat%' then 1 else 0 end) CreationTasks
	   , sum(case when tasks.task like '%Profile%Edit%' then 1 else 0 end) EditionTasks
	   , sum(datediff(hour, t.start, t.[end])) TotalTime
    from users u 
	   inner join roles r on r.role_id = u.role_id 
        inner join tasks on r.role_id = tasks.role_id
	   inner join trackings t on t.user_id = u.user_id
	   inner join clients c on c.client_id = t.client_id
    where
	   (tasks.task like '%Profile%Creat%'
	   or  tasks.task like '%Profile%Edit%')
	   
	   --(([role]  = 'Account Manager' and task = 'Profile Creation')
	   --or ([role]  = 'Closer' and task in ('Profile Creation','Profile Editing'))
	   --or ([role]  = 'Profile Writer' and task in ('Profile Creation', 'Simple Profile Creation', 'Profile Editing','Simple Profile Editing'))
	   --or ([role]  = 'Writing Team Lead' and task in ('Profile Writing','Profile Editing'))
	   --or ([role]  = 'Administrator' and task = 'Profile Editing')
	   --or ([role]  = 'Assistant' and task = 'Daily Profile Edits')
	   --)
	   and u.name = @user
	   and c.name = @client_name
	   group by u.name, c.name--, tasks.task
    --order by c.name, u.name, t.created_time, t.start, t.[end]
    */

/*
select r.role, tasks.task, count(*)
    from users u 
	   inner join roles r on r.role_id = u.role_id 
        inner join tasks on r.role_id = tasks.role_id
	   inner join trackings t on t.user_id = u.user_id
	   inner join clients c on c.client_id = t.client_id
    where
	   tasks.task like '%Profile%'
	   and u.name = @user
	   and c.name = @client_name
	   group by r.role,tasks.task*/




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
	  tasks.*,
	  t.start, t.[end] 
       --RIGHT('0'+CONVERT( VARCHAR(5), SUM(DATEDIFF(second, t.start, t.[end])) / 60 / 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(DATEDIFF(second, t.start, t.[end])) / 60 % 60), 2)+':'+RIGHT('0'+CONVERT(VARCHAR(2), SUM(DATEDIFF(second, t.start, t.[end])) % 60), 2) TotalHoursTime
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
order by t.start
--GROUP BY u.name,r.role,
--         c.name
ORDER BY u.name,
         c.name;
