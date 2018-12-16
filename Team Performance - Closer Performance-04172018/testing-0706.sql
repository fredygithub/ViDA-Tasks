use track
go

--select top 10 *
--    from users 
--    where [name] = 'Alberto Orozco'

--    user_id	user	pass	name	role_id	active	email	day_off
--179	aorozco	K099y037	Alberto Orozco	4	1	alberto@clickmagnetdating.com	Wednesday

--select *
--    from clients where [name] = 'Dan Graham'

--client_id	name	user_id	autobill	active
--2382	Dan Graham	30	0	0
SELECT Track_DB.*, VIDA_DB.*
 FROM
 (
    select datediff(minute,[start],[end]) MinTime, T.*, USERS.[name] taskusername, clients.[name] clientName
    , users.*, clients.*
	   from trackings t
		  inner join tasks on tasks.task_id = t.task_id
		  inner join sites on sites.site_id = t.site_id
		  inner join users on users.user_id = t.user_id
		  inner join clients on clients.client_id = t.client_id
		  --inner join VIDA.dbo.tasks vtasks on vtasks.[Task Id] = t.task_id
	   where
		 -- t.user_id = 179 and
		  users.role_id = 4 AND 
		  tasks.task like '%outbound%Em%' AND
		  t.client_id = 2382
		  AND t.site_id <> 17 --eHarmony
		  AND tasks.role_id = 4 -- Closer
		  AND users.[name] = 'Alberto Orozco'
    --	   and [end]>'03/28/2018'
		  --order by [end]
	   ) Track_DB	   	
    LEFT JOIN
(
    SELECT     a.[Opportunities Id],
			 c.[Closed Time],
			--a.[Created Time],
               CASE
                   WHEN a.Closer IS NULL
                   THEN 'Missing'
                   ELSE a.Closer
               END AS Closer,
               CASE
                   WHEN b.active IS NULL
                   THEN 'NO'
                   ELSE CASE
                            WHEN b.active = 0
                            THEN 'NO'
                            ELSE 'YES'
                        END
               END AS Active,
               CASE
                   WHEN a.Stage IN('Client Inactive', 'IC Deleted Profile')
                   THEN 'Inactive + Deleted Profile'
                   WHEN a.Stage = 'Negative Response IE - SEND OE'
                   THEN 'Negative Response'
                   ELSE a.Stage
               END AS Stage--,
               --ISNULL(a.[Mobile App], 'No') AS [Mobile App],
              -- ISNULL(d.[Site], 'No Site') AS [Site]
			--,[Split With Closer]
			--, c.*
			,acc.[Clients Name] 
			, c.[Modified Time]
			,c.Closer
			, tr.units
			,datediff(minute,tr.[start],tr.[end]) MinuteTime
        FROM [VIDA].[dbo].[opportunities] a
             LEFT JOIN [TRACK].dbo.users b ON CASE
                                                  WHEN a.Closer IS NULL
                                                  THEN 'Missing'
                                                  ELSE a.Closer
                                              END = b.name
             INNER JOIN VIDA.dbo.sites d ON REPLACE(REPLACE(a.[Site], CHAR(13), ''), CHAR(10), '') = d.origin
		   inner join VIDA.dbo.accounts acc on acc.[Clients Id] = a.[Clients Id]
             inner JOIN
        (
            SELECT *--, COUNT(*) AS oes
            FROM [VIDA].[dbo].[tasks]
            WHERE [Related To] IS NOT NULL
                  AND [Type] LIKE '%Outbound Email%'
        ) c ON a.[Opportunities Id] = c.[Related To] and c.Closer = a.closer
	   left JOIN 
	   (
		  select t.[start],t.[end], USERS.[name] taskusername, clients.[name] clientName, t.units
		  from TRACK.dbo.trackings t
		  inner join TRACK.dbo.tasks on tasks.task_id = t.task_id
		  inner join TRACK.dbo.sites on sites.site_id = t.site_id
		  inner join TRACK.dbo.users on users.user_id = t.user_id
		  inner join TRACK.dbo.clients on clients.client_id = t.client_id	   
	   ) tr on tr.taskusername = a.closer and tr.clientName = acc.[Clients Name] 
		  and  convert( varchar, tr.[end],101 ) = convert( varchar, c.[Closed Time],101 )

        WHERE 
		  a.Stage IN('Got Phone Number', 'Pursued Date But Got Number', 'Date Completely Scheduled Online', 'Numbers exchanged', 'Client Inactive', 'IC Deleted Profile', 'Closed Lost', 'Negative Response IE - SEND OE')
             AND d.[Site] <> 'eHarmony'
           --  AND CONVERT(VARCHAR(4), YEAR(a.[Created Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Created Time])), 2) BETWEEN @start AND @end
             AND LTRIM(RTRIM(a.[Opportunities Name])) NOT LIKE 'SALES%'
		  AND a.[Opportunities Id] = 'zcrm_200867000042736631'--'zcrm_200867000047330009'
		  AND a.closer = 'Alberto Orozco'
		  --AND a.closer = 'Ben Gebler'
		  --and acc.[Clients Name] = 'Dan Graham' 
		 -- order by c.[Modified Time]
) VIDA_DB 
    ON VIDA_DB.Closer = Track_DB.taskusername
    and VIDA_DB.[Clients Name] = Track_DB.clientName
    and VIDA_DB.[Modified Time] = Track_DB.[end]

--SELECT top 100 *
--            FROM [VIDA].[dbo].[tasks]
--            WHERE [Related To] IS NOT NULL
--                  AND [Type] LIKE '%Outbound Email%'
--			   and closer = 'Ben Gebler'
--			   and [modified time] > '03/28/2018'
--			   and [subject] like '%S_Anne%'
--select top 10 * 
--FROM [VIDA].[dbo].[opportunities]

select *
    from vida.dbo.opportunities
    where [Opportunities Id] = 'zcrm_200867000043630444'

    SELECT *--, COUNT(*) AS oes
            FROM [VIDA].[dbo].[tasks]
            WHERE [Related To] IS NOT NULL
                  AND [Type] LIKE '%Outbound Email%'
        and [Related To] = 'zcrm_200867000042736631' and Closer = 'Alberto Orozco'

    select t.[start],t.[end], USERS.[name] taskusername, clients.[name] clientName, t.units
		  from TRACK.dbo.trackings t
		  inner join TRACK.dbo.tasks on tasks.task_id = t.task_id
		  inner join TRACK.dbo.sites on sites.site_id = t.site_id
		  inner join TRACK.dbo.users on users.user_id = t.user_id
		  inner join TRACK.dbo.clients on clients.client_id = t.client_id	   
	   WHERE USERS.[name] = 'Alberto Orozco' and clients.[name] = 'Phu Vu'
		  AND UNITS != 0
		  ORDER BY t.[start]
		  