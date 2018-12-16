  DECLARE @StartMonth DATETIME = DATEADD(DAY,1,EOMONTH(GETDATE(),-3))


SELECT [Writer], [Client], sum([Creation]) [CreationTimeSec], sum([Edition]) [EditionTimeSec]
FROM
(
	   SELECT ROW_NUMBER() OVER(
			 PARTITION BY users.[First Name] + ' '+ users.[Last Name] 
			 , acc.[Clients Name]
			 , case when ([subject] like '%creation%' OR tasks.Type ='Profile creation') then 'Creation' else 'Edition' end
			 ORDER BY users.[First Name] + ' '+ users.[Last Name], acc.[Clients Name], case when [subject] like '%creation%' then 'Creation' else 'Edition' end) AS Row#,
		  case when ([subject] like '%creation%' OR tasks.Type ='Profile creation') then 'Creation' else 'Edition' end tasktype,
		  [Task Id],
		  tasks.[Subject],
           tasks.[Created Time],
           [Task Owner Id],
		 users.[First Name] + ' '+ users.[Last Name] [Writer],
           [Related To],
		 acc.[Clients Name] [Client],
           tasks.Type,
           [Closed Time]
		 ,DATEDIFF(second, tasks.[Created Time], tasks.[Closed Time]) taskTime
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
		    and users.[First Name] + ' '+ users.[Last Name]= 'Michelle Johnson'--'Alex Stacey'
) AS SourceTable PIVOT(AVG(taskTime) FOR [TaskType] IN([Creation], [Edition])) AS PivotTable
WHERE 
     Row# = 1
	GROUP BY [Writer], [Client]




   SELECT [Writer], [Client], [MonthPeriod], sum(case when tasktype = 'Creation' then taskTime else 0 end) CreationTaskTime
	   , sum(case when tasktype = 'Edition' then taskTime else 0 end) EditionTaskTime
    FROM (
    SELECT ROW_NUMBER() OVER(
			 PARTITION BY users.[First Name] + ' '+ users.[Last Name] 
			 , acc.[Clients Name]
			 , case when ([subject] like '%creation%' OR tasks.Type ='Profile creation') then 'Creation' else 'Edition' end
			 ORDER BY users.[First Name] + ' '+ users.[Last Name], acc.[Clients Name], case when [subject] like '%creation%' then 'Creation' else 'Edition' end) AS Row#,
		  case when ([subject] like '%creation%' OR tasks.Type ='Profile creation') then 'Creation' else 'Edition' end tasktype,
           CONVERT(NCHAR(7),tasks.[Created Time],120) [MonthPeriod],
		 users.[First Name] + ' '+ users.[Last Name] [Writer],
		 acc.[Clients Name] [Client],
 		 DATEDIFF(second, tasks.[Created Time], tasks.[Closed Time]) taskTime
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
		    and users.[First Name] + ' '+ users.[Last Name]= 'Michelle Johnson'--'Alex Stacey'
	   ) t where Row# = 1
	   group by [Writer], [Client], [MonthPeriod]