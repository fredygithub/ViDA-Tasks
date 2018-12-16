use track
go

/*
Catherine Huchan
6 oct. 2017
For roles, we should consider Matchmaker, Profile Writer and Closer.

Profile Creation Tasks:
Account Manager Profile Creation
Closer Profile Creation
Profile Writer Profile Creation
Profile Writer Simple Profile Creation
Writing Team Lead Profile Writing

Profile Editing Tasks:
Administrator Profile Editing
Assistant Daily Profile Edits
Closer Profile Editing
Profile Writer Profile Editing
Profile Writer Simple Profile Editing
Writing Team Lead Profile Editing


*/
SELECT package_name,
       package_color AS Expr1,
       monthly_hours AS Expr2
FROM packages
GROUP BY package_name,
         package_color,
         monthly_hours;
--ORDER BY hours_purchased



SELECT DISTINCT
       u.user_id,
       u.name--distinct r.role--r.role, tasks.task_id, tasks.task
FROM tasks
     INNER JOIN roles r ON r.role_id = tasks.role_id
     INNER JOIN users u ON u.role_id = r.role_id
WHERE task LIKE '%Profile%'
      --AND tasks.active = 1
      --AND u.active = 1
ORDER BY u.name;

declare @USER_ACTIVE int = 0
SELECT DISTINCT u.name, 1 AS ord
FROM            tasks INNER JOIN
                         roles AS r ON r.role_id = tasks.role_id INNER JOIN
                         users AS u ON u.role_id = r.role_id
WHERE        ((tasks.task LIKE '%Profile%') AND CONVERT(int, u.active) = CONVERT(int, @USER_ACTIVE)) 
		  OR
                         ((tasks.task LIKE '%Profile%') AND (@USER_ACTIVE = -1))
ORDER BY ord, name


declare @user nvarchar(50)= 'All', @client_name nvarchar(50)= 'All'; 
SELECT        tasks.task_id, tasks.role_id, tasks.task, tasks.req_units, tasks.req_site, tasks.req_notes, tasks.package_min_hs, tasks.days_to_expire, tasks.rate_number, tasks.group_description, tasks.mobile, tasks.active
FROM            tasks INNER JOIN
                         roles ON tasks.role_id = roles.role_id INNER JOIN
                         trackings ON tasks.task_id = trackings.task_id
WHERE        (tasks.task LIKE '%Profile%Creat%' OR tasks.task LIKE '%Profile%Edit%') 
	   AND (u.name = @user or @user = 'All') AND (c.name = @client_name or @client_name = 'All')
GROUP BY u.name, c.name
ORDER BY c.name

