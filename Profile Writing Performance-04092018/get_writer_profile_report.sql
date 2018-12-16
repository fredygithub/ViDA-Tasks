USE TRACK
GO

--create procedure dbo.get_writer_profile_report
--AS

DECLARE
  @user         NVARCHAR(25)='Allison Seib',
  @package_name NVARCHAR(25),
  @MonthDate    DATETIME    ='04/01/2018',
  @LastTreeMonth DATETIME = DATEADD( DAY, -90, GETDATE( ) );

DECLARE @tmp_Roles TABLE 
(
  id             INT IDENTITY,
  roleName           NVARCHAR(100),
  isCreationTask		bit);

INSERT INTO @tmp_Roles(roleName, isCreationTask)
    SELECT 'Daily Profile Edits',0 isCreationTask UNION
    SELECT 'Profile Creation',1 isCreationTask UNION
    SELECT 'Profile Editing',0 isCreationTask UNION
    SELECT 'Profile Writing',1 isCreationTask UNION
    SELECT 'Simple Profile Creation',1 isCreationTask UNION
    SELECT 'Simple Profile Editing',0 isCreationTask


SELECT writer,
       role,
       FORMAT( @MonthDate, 'MM/yyyy' )                                                                                                                                                                                                                   DatePeriod,
       -- task,
       sum( CreationTasksCount )                                                                                                                                                                                                                         CreationTasksCount,
       RIGHT( '0'+CONVERT( VARCHAR(5), SUM( CreationTasksTime )/60/60 ), 2 )+':'+RIGHT( '0'+CONVERT( VARCHAR(2), SUM( CreationTasksTime )/60%60 ), 2 )+':'+RIGHT( '0'+CONVERT( VARCHAR(2), SUM( CreationTasksTime )%60 ), 2 )                            TotalCreationTasksTime,
       RIGHT( '0'+CONVERT( VARCHAR(5), SUM( CreationTasksTime )/Profiles/60/60 ), 2 )+':'+RIGHT( '0'+CONVERT( VARCHAR(2), SUM( CreationTasksTime )/Profiles/60%60 ), 2 )+':'+RIGHT( '0'+CONVERT( VARCHAR(2), SUM( CreationTasksTime )/Profiles%60 ), 2 ) AvgCreationTasksTime,
       SUM( EditionTasksCount )                                                                                                                                                                                                                          EditionTasksCount,
       RIGHT( '0'+CONVERT( VARCHAR(5), SUM( EditionTasksTime )/60/60 ), 2 )+':'+RIGHT( '0'+CONVERT( VARCHAR(2), SUM( EditionTasksTime )/60%60 ), 2 )+':'+RIGHT( '0'+CONVERT( VARCHAR(2), SUM( EditionTasksTime )%60 ), 2 )                               TotalEditionTasksTime,
       RIGHT( '0'+CONVERT( VARCHAR(5), SUM( EditionTasksTime )/Profiles/60/60 ), 2 )+':'+RIGHT( '0'+CONVERT( VARCHAR(2), SUM( EditionTasksTime )/Profiles/60%60 ), 2 )+':'+RIGHT( '0'+CONVERT( VARCHAR(2), SUM( EditionTasksTime )/Profiles%60 ), 2 )    AvgEditionTasksTime,
       Profiles,
       RIGHT( '0'+CONVERT( VARCHAR(5), SUM( SumTotalTime )/60/60 ), 2 )+':'+RIGHT( '0'+CONVERT( VARCHAR(2), SUM( SumTotalTime )/60%60 ), 2 )+':'+RIGHT( '0'+CONVERT( VARCHAR(2), SUM( SumTotalTime )%60 ), 2 )                                           TotalHoursTime
FROM
(
  SELECT u.name                                      writer,
         r.role,
         SUM( CASE
                WHEN isCreationTask=1--tasks.task LIKE '%Profile%Creat%'
                THEN 1
                ELSE 0
              END )                                  CreationTasksCount,
         SUM( CASE
                WHEN isCreationTask=0--tasks.task LIKE '%Profile%Edit%'
                THEN 1
                ELSE 0
              END )                                  EditionTasksCount,
         SUM( CASE
                WHEN isCreationTask=1--tasks.task LIKE '%Profile%Creat%'
                THEN DATEDIFF( second, t.start, t.[end] )
                ELSE 0
              END )                                  CreationTasksTime,
         SUM( CASE
                WHEN isCreationTask=0--tasks.task LIKE '%Profile%Edit%'
                THEN DATEDIFF( second, t.start, t.[end] )
                ELSE 0
              END )                                  EditionTasksTime,
         SUM( DATEDIFF( second, t.start, t.[end] ) ) SumTotalTime,
         COUNT( DISTINCT c.name )                    Profiles
  FROM users u
  INNER JOIN
  roles r
  ON r.role_id=u.role_id
      INNER JOIN
      tasks
      ON r.role_id=tasks.role_id
          INNER JOIN
          trackings t
          ON t.user_id=u.user_id
             AND t.task_id=tasks.task_id
              INNER JOIN
              clients c
              ON c.client_id=t.client_id
                  INNER JOIN
                  sites
                  ON sites.site_id=t.site_id
			   INNER JOIN @tmp_Roles roles on roles.roleName = tasks.task
  WHERE --(tasks.task LIKE '%Profile%Creat%' OR tasks.task LIKE '%Profile%Edit%') AND 
	   u.active=1
       --AND u.name = @user
       --AND MONTH( t.created_time )=MONTH( @MonthDate )
       --AND YEAR( t.created_time )=YEAR( @MonthDate )
	  AND t.created_time>=@LastTreeMonth
  GROUP BY u.name,
           r.role
) LogApp
GROUP BY writer,
         role,
         Profiles
ORDER BY writer;