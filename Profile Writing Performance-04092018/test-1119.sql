use track
go
SELECT TOP 10 * FROM users WHERE NAME LIKE '%Onawa Gardiner%'


		  DECLARE @StartMonth DATETIME = DATEADD(DAY,1,EOMONTH(GETDATE(),-3))

		  
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


    --        SELECT u.name writer,
    --               u.[user_id],
    --               c.name client_name,
    --               c.[client_id],
    --               t.created_time,
    --               DENSE_RANK() OVER(PARTITION BY u.name,
    --                                              c.name ORDER BY iscreationtask DESC,
    --                                                              t.created_time) dr_created_time,
    --               roles.isCreationTask
    --        FROM users u
    --             INNER JOIN roles r ON r.role_id = u.role_id
    --             INNER JOIN tasks ON r.role_id = tasks.role_id
    --             INNER JOIN trackings t ON t.user_id = u.user_id
    --                                       AND t.task_id = tasks.task_id
    --             INNER JOIN clients c ON c.client_id = t.client_id
    --             INNER JOIN @tmp_Roles roles ON roles.role_id = tasks.role_id
    --                                            AND roles.taskName = tasks.task
    --        WHERE --u.active = 1 AND 
		  --c.name = 'Allyson Ford';

		  SELECT *,
		 dense_rank() over (partition by u.name,c.name order by iscreationtask desc,t.created_time) dr_created_time,
		 roles.isCreationTask
    FROM users u
         INNER JOIN roles r ON r.role_id = u.role_id
         INNER JOIN tasks ON r.role_id = tasks.role_id
         INNER JOIN trackings t ON t.user_id = u.user_id
                                   AND t.task_id = tasks.task_id
         INNER JOIN clients c ON c.client_id = t.client_id
         INNER JOIN @tmp_Roles roles ON roles.role_id = tasks.role_id AND roles.taskName = tasks.task
    WHERE u.active = 1
          AND t.created_time >= @StartMonth		
and 	   CONVERT(NCHAR(7),created_time,120) = '2018-10'
	   and u.name= 'Allison Seib'--'Allison Seib'		