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
select r.role, tasks.task_id, tasks.task
    from tasks
	   inner join roles r on r.role_id = tasks.role_id
    where	  task like '%Profile%'
	   and active = 1
	   order by r.role_id, tasks.task_id

select * 
    from roles r
        inner join tasks on r.role_id = tasks.role_id
    where
	   ([role]  = 'Account Manager' and task = 'Profile Creation')
	   or ([role]  = 'Closer' and task in ('Profile Creation','Profile Editing'))
	   or ([role]  = 'Profile Writer' and task in ('Profile Creation', 'Simple Profile Creation', 'Profile Editing','Simple Profile Editing'))
	   or ([role]  = 'Writing Team Lead' and task in ('Profile Writing','Profile Editing'))
	   or ([role]  = 'Administrator' and task = 'Profile Editing')
	   or ([role]  = 'Assistant' and task = 'Daily Profile Edits')
    order by r.role_id, tasks.task_id


select u.user_id, u.name, r.role, c.name client, tasks.task, tasks.group_description, t.* 
    from users u 
	   inner join roles r on r.role_id = u.role_id 
        inner join tasks on r.role_id = tasks.role_id
	   inner join trackings t on t.user_id = u.user_id
	   inner join clients c on c.client_id = t.client_id
    where
	   (([role]  = 'Account Manager' and task = 'Profile Creation')
	   or ([role]  = 'Closer' and task in ('Profile Creation','Profile Editing'))
	   or ([role]  = 'Profile Writer' and task in ('Profile Creation', 'Simple Profile Creation', 'Profile Editing','Simple Profile Editing'))
	   or ([role]  = 'Writing Team Lead' and task in ('Profile Writing','Profile Editing'))
	   or ([role]  = 'Administrator' and task = 'Profile Editing')
	   or ([role]  = 'Assistant' and task = 'Daily Profile Edits')
	   )
	   and u.name = 'Allison Seib'
	   and c.name = 'Peter Biedak'
	   
    order by c.name, u.name, t.created_time, t.start, t.[end]


	   select * from tasks_audit

select u.user_id, u.name, r.role, c.name client, t.*, tasks.*
    from users u 
	   inner join roles r on r.role_id = u.role_id
	   inner join trackings t on t.user_id = u.user_id
	   inner join tasks on tasks.task_id = t.task_id
	   inner join clients c on c.client_id = t.client_id
    where
	   [role] in ('Account Manager','Profile Writer','Closer')
	   and u.active = 1
	   and u.name = 'Allison Seib'
	   and c.name = 'Peter Biedak'
    order by t.start
	   
	   select * from tasks

--select *
--    from users u 
--	   inner join roles r on r.role_id = u.role_id
--    where
--	   r.role = 'Profile Writer'
--	   and active = 1