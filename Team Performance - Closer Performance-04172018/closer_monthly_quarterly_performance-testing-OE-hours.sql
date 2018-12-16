--DECLARE @start VARCHAR(7)= '2015-02';
--DECLARE @end VARCHAR(7)= '2018-04';
/*
DECLARE @start VARCHAR(7)= '2018-03';
DECLARE @end VARCHAR(7)= '2018-03';
    --SELECT z.[Month],
    --       z.[Quarter],
    --       z.Closer,
    --       z.Active,
    --       z.Stage,
    --       z.[Mobile App],
    --       z.[Site],
    --       SUM(z.Quant) AS Quant,
    --       SUM(z.OEs) AS OEs
    --FROM
    --(
SELECT CONVERT( VARCHAR(4), YEAR(a.[Created Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Created Time])), 2) AS [Month],
       CONVERT( VARCHAR(4), YEAR(a.[Created Time]))+'-'+CONVERT(VARCHAR(1), DATEPART(q, a.[Created Time]))+'Q' AS [Quarter],
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
       END AS Stage,
       ISNULL(a.[Mobile App], 'No') AS [Mobile App],
       ISNULL(d.[Site], 'No Site') AS [Site], acc.[Clients Name],
       SUM(CASE
               WHEN a.[Split With Closer] IS NULL
               THEN 1
               ELSE 0.5
           END) AS Quant,
       SUM(CASE
               WHEN c.oes IS NULL
               THEN 0
               ELSE c.oes
           END) AS [Oes]
FROM [VIDA].[dbo].[opportunities] a
     LEFT JOIN [TRACK].dbo.users b ON CASE
                                          WHEN a.Closer IS NULL
                                          THEN 'Missing'
                                          ELSE a.Closer
                                      END = b.name
     LEFT JOIN
(
    SELECT [Related To],
           COUNT(*) AS oes
    FROM [VIDA].[dbo].[tasks]
    WHERE [Related To] IS NOT NULL
          AND [Type] LIKE '%Outbound Email%'
    GROUP BY [Related To]

) c ON a.[Opportunities Id] = c.[Related To]
     INNER JOIN VIDA.dbo.sites d ON REPLACE(REPLACE(a.[Site], CHAR(13), ''), CHAR(10), '') = d.origin
	inner join VIDA.dbo.accounts acc on acc.[Clients Id] = a.[Clients Id]
WHERE a.Stage IN('Got Phone Number'
	   , 'Pursued Date But Got Number'
	   , 'Date Completely Scheduled Online'
	   , 'Numbers exchanged', 'Client Inactive'
	   , 'IC Deleted Profile'
	   , 'Closed Lost'
	   , 'Negative Response IE - SEND OE')
     AND d.[Site] <> 'eHarmony'
     AND CONVERT(VARCHAR(4), YEAR(a.[Created Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Created Time])), 2) BETWEEN @start AND @end
     AND LTRIM(RTRIM(a.[Opportunities Name])) NOT LIKE 'SALES%'
     AND a.closer = 'Connor Moran'
	and acc.[Clients Name] = 'Anthony Dominguez'
GROUP BY CONVERT( VARCHAR(4), YEAR(a.[Created Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Created Time])), 2),
         CONVERT( VARCHAR(4), YEAR(a.[Created Time]))+'-'+CONVERT(VARCHAR(1), DATEPART(q, a.[Created Time]))+'Q',
         CASE
             WHEN a.Closer IS NULL
             THEN 'Missing'
             ELSE a.Closer
         END,
         CASE
             WHEN b.active IS NULL
             THEN 'NO'
             ELSE CASE
                      WHEN b.active = 0
                      THEN 'NO'
                      ELSE 'YES'
                  END
         END,
         CASE
             WHEN a.Stage IN('Client Inactive', 'IC Deleted Profile')
             THEN 'Inactive + Deleted Profile'
             WHEN a.Stage = 'Negative Response IE - SEND OE'
             THEN 'Negative Response'
             ELSE a.Stage
         END,
         ISNULL(a.[Mobile App], 'No'),
         ISNULL(d.[Site], 'No Site'), acc.[Clients Name]


UNION ALL
SELECT CONVERT( VARCHAR(4), YEAR(a.[Created Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Created Time])), 2) AS [Month],
       CONVERT( VARCHAR(4), YEAR(a.[Created Time]))+'-'+CONVERT(VARCHAR(1), DATEPART(q, a.[Created Time]))+'Q' AS [Quarter],
       CASE
           WHEN a.[Split With Closer] IS NULL
           THEN 'Missing'
           ELSE a.[Split With Closer]
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
       END AS Stage,
       ISNULL(a.[Mobile App], 'No') AS [Mobile App],
       ISNULL(d.[Site], 'No Site') AS [Site], acc.[Clients Name],
       SUM(CASE
               WHEN a.[Split With Closer] IS NULL
               THEN 1
               ELSE 0.5
           END) AS Quant,
       SUM(CASE
               WHEN c.oes IS NULL
               THEN 0
               ELSE c.oes
           END) AS [OEs]
FROM [VIDA].[dbo].[opportunities] a
     LEFT JOIN [TRACK].dbo.users b ON CASE
                                          WHEN a.[Split With Closer] IS NULL
                                          THEN 'Missing'
                                          ELSE a.[Split With Closer]
                                      END = b.name
     LEFT JOIN
(
    SELECT [Related To],
           COUNT(*) AS oes
    FROM [VIDA].[dbo].[tasks]
    WHERE [Related To] IS NOT NULL
          AND [Type] LIKE '%Outbound Email%'
    GROUP BY [Related To]
) c ON a.[Opportunities Id] = c.[Related To]
     INNER JOIN VIDA.dbo.sites d ON REPLACE(REPLACE(a.[Site], CHAR(13), ''), CHAR(10), '') = d.origin
	inner join VIDA.dbo.accounts acc on acc.[Clients Id] = a.[Clients Id] 
WHERE a.Stage IN('Got Phone Number', 'Pursued Date But Got Number', 'Date Completely Scheduled Online', 'Numbers exchanged', 'Client Inactive', 'IC Deleted Profile', 'Closed Lost', 'Negative Response IE - SEND OE')
     AND d.[Site] <> 'eHarmony'
     AND CONVERT(VARCHAR(4), YEAR(a.[Created Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Created Time])), 2) BETWEEN @start AND @end
     AND LTRIM(RTRIM(a.[Opportunities Name])) NOT LIKE 'SALES%'
     AND a.closer = 'Connor Moran'
	and acc.[Clients Name] = 'Anthony Dominguez'
     AND a.[Split With Closer] IS NOT NULL
GROUP BY CONVERT( VARCHAR(4), YEAR(a.[Created Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Created Time])), 2),
         CONVERT( VARCHAR(4), YEAR(a.[Created Time]))+'-'+CONVERT(VARCHAR(1), DATEPART(q, a.[Created Time]))+'Q',
         CASE
             WHEN a.[Split With Closer] IS NULL
             THEN 'Missing'
             ELSE a.[Split With Closer]
         END,
         CASE
             WHEN b.active IS NULL
             THEN 'NO'
             ELSE CASE
                      WHEN b.active = 0
                      THEN 'NO'
                      ELSE 'YES'
                  END
         END,
         CASE
             WHEN a.Stage IN('Client Inactive', 'IC Deleted Profile')
             THEN 'Inactive + Deleted Profile'
             WHEN a.Stage = 'Negative Response IE - SEND OE'
             THEN 'Negative Response'
             ELSE a.Stage
         END,
         ISNULL(a.[Mobile App], 'No'),
         ISNULL(d.[Site], 'No Site'), acc.[Clients Name]
    --) z
    --GROUP BY z.[Month],
    --         z.[Quarter],
    --         z.Closer,
    --         z.Active,
    --         z.Stage,
    --         z.[Mobile App],
    --         z.[Site]

        SELECT CONVERT( VARCHAR(4), YEAR(a.[Modified Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Modified Time])), 2) AS [Month],
           REPLACE(REPLACE(a.Closer, CHAR(13), ''), CHAR(10), '') AS Closer,
           COUNT(*) * 1. AS oes_hours
    FROM [VIDA].[dbo].[tasks] a
         INNER JOIN [VIDA].[dbo].[opportunities] b ON a.[Related To] = b.[Opportunities Id]
         INNER JOIN VIDA.dbo.sites c ON REPLACE(REPLACE(b.[Site], CHAR(13), ''), CHAR(10), '') = c.origin
    WHERE a.[Related To] IS NOT NULL
          AND a.Closer IS NOT NULL
          AND REPLACE(REPLACE(a.Closer, CHAR(13), ''), CHAR(10), '') <> ''
          AND a.[Type] LIKE '%Outbound Email%'
          AND c.[Site] <> 'eHarmony'
		AND a.closer = 'Connor Moran'
    GROUP BY CONVERT( VARCHAR(4), YEAR(a.[Modified Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Modified Time])), 2),
             a.Closer*/

 SELECT CONVERT( VARCHAR(4), YEAR([tasks].[Modified Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH([tasks].[Modified Time])), 2),
 o.Stage,
                 COUNT(*) AS oes
            FROM [VIDA].[dbo].[tasks]
		  		  INNER JOIN [VIDA].[dbo].[opportunities] o ON [tasks].[Related To] = o.[Opportunities Id]
		  INNER JOIN VIDA.dbo.sites ON REPLACE(REPLACE(o.[Site], CHAR(13), ''), CHAR(10), '') = sites.origin
            WHERE [Related To] IS NOT NULL
                  AND [tasks].[Type] LIKE '%Outbound Email%'
			   AND o.closer = 'Connor Moran'
			  -- and o.Stage IN('Got Phone Number', 'Pursued Date But Got Number', 'Date Completely Scheduled Online', 'Numbers exchanged', 'Client Inactive', 'IC Deleted Profile', 'Closed Lost', 'Negative Response IE - SEND OE')
             AND sites.[Site] <> 'eHarmony'
		   
             AND LTRIM(RTRIM(o.[Opportunities Name])) NOT LIKE 'SALES%'
            GROUP BY CONVERT( VARCHAR(4), YEAR([tasks].[Modified Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH([tasks].[Modified Time])), 2)--,[Related To]
		  , o.Stage
		  having CONVERT( VARCHAR(4), YEAR([tasks].[Modified Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH([tasks].[Modified Time])), 2) = '2018-03'
		  
		   SELECT CONVERT( VARCHAR(4), YEAR([tasks].[Modified Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH([tasks].[Modified Time])), 2)--, [Related To],
                 , COUNT(*) AS oes
            FROM [VIDA].[dbo].[tasks]
		  		  INNER JOIN [VIDA].[dbo].[opportunities] o ON [tasks].[Related To] = o.[Opportunities Id]
		  INNER JOIN VIDA.dbo.sites ON REPLACE(REPLACE(o.[Site], CHAR(13), ''), CHAR(10), '') = sites.origin
            WHERE [Related To] IS NOT NULL
                  AND [tasks].[Type] LIKE '%Outbound Email%'
			   			   AND [tasks].Closer IS NOT NULL
						   AND o.closer = 'Connor Moran'
			   --AND REPLACE(REPLACE([tasks].Closer, CHAR(13), ''), CHAR(10), '') <> ''
			   AND LTRIM(RTRIM(o.[Opportunities Name])) NOT LIKE 'SALES%'
			   AND sites.[Site] <> 'eHarmony'
			   --and CONVERT( VARCHAR(4), YEAR([tasks].[Modified Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH([tasks].[Modified Time])), 2) = '2018-03'
            GROUP BY CONVERT( VARCHAR(4), YEAR([tasks].[Modified Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH([tasks].[Modified Time])), 2)--,[Related To]
		  having CONVERT( VARCHAR(4), YEAR([tasks].[Modified Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH([tasks].[Modified Time])), 2) = '2018-03'

		  /*
declare @dstart datetime = '03/01/2018'
declare @dend datetime = '03/31/2018 23:59';

    /*SELECT CONVERT( VARCHAR(4), YEAR(a.[created_time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[created_time])), 2) AS [Month],
           b.name AS Closer,
           SUM(DATEDIFF(mi, a.start, a.[end]) / 60.) AS [Hours]		 
		 ,CONVERT(VARCHAR(5), SUM(DATEDIFF(second, a.start, a.[end]))/60/60)
		+ ':' + RIGHT('0' + CONVERT(VARCHAR(2), SUM(DATEDIFF(second, a.start, a.[end]))/60%60), 2)
		+ ':' + RIGHT('0' + CONVERT(VARCHAR(2), SUM(DATEDIFF(second, a.start, a.[end])) % 60), 2) AS [Hours_new]
    FROM [TRACK].[dbo].[trackings] a
         INNER JOIN [TRACK].[dbo].[users] b ON a.[user_id] = b.[user_id]
	    inner join track.dbo.clients on clients.client_id = a.client_id
    WHERE a.task_id IN(60, 103, 131, 263)
         AND a.site_id <> 17 -- Outbound Emails
	    AND b.name = 'Connor Moran'
	    --and clients.name = 'Anthony Dominguez'
	    and a.[created_time] between @dstart and @dend
    GROUP BY CONVERT( VARCHAR(4), YEAR(a.[created_time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[created_time])), 2),
             CONVERT( VARCHAR(4), YEAR(a.[created_time]))+'-'+CONVERT(VARCHAR(1), DATEPART(q, a.[created_time]))+'Q',
             b.name

    SELECT a.[created_time],
           b.name AS Closer,
          a.start, a.[end], t.*, a.*
    FROM [TRACK].[dbo].[trackings] a
		 inner join track.dbo.tasks t on t.task_id = a.task_id
         INNER JOIN [TRACK].[dbo].[users] b ON a.[user_id] = b.[user_id]
	    inner join track.dbo.clients on clients.client_id = a.client_id
    WHERE a.task_id IN(60, 103, 131, 263)
         AND a.site_id <> 17 -- Outbound Emails
	    AND b.name = 'Connor Moran'
	    --and clients.name = 'Anthony Dominguez'
	    and a.[created_time] between @dstart and @dend*/


    --select * from track.dbo.users inner join track.dbo.roles on users.role_id = roles.role_id where users.name = 'Connor Moran'
  --  select top 10 * from track.[dbo].[tasks] inner join track.[dbo].roles on roles.role_id = tasks.role_id where task like '%outbound%email%' 
  --  select top 10 * from track.[dbo].[tasks] inner join track.[dbo].roles on roles.role_id = tasks.role_id where task_id IN(60, 103, 131, 263)

  --  SELECT CONVERT( VARCHAR(4), YEAR(a.[Modified Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Modified Time])), 2) AS [Month],
  --         REPLACE(REPLACE(a.Closer, CHAR(13), ''), CHAR(10), '') AS Closer,
  --         COUNT(*) * 1. AS oes_hours
  --  FROM [VIDA].[dbo].[tasks] a
  --       INNER JOIN [VIDA].[dbo].[opportunities] b ON a.[Related To] = b.[Opportunities Id]
  --       INNER JOIN VIDA.dbo.sites c ON REPLACE(REPLACE(b.[Site], CHAR(13), ''), CHAR(10), '') = c.origin
  --  WHERE a.[Related To] IS NOT NULL
  --        AND a.Closer IS NOT NULL
  --        AND REPLACE(REPLACE(a.Closer, CHAR(13), ''), CHAR(10), '') <> ''
  --        AND a.[Type] LIKE '%Outbound Email%'
  --        AND c.[Site] <> 'eHarmony'
		--and a.[Modified Time] between @dstart and @dend
  --  GROUP BY CONVERT( VARCHAR(4), YEAR(a.[Modified Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Modified Time])), 2),
  --           a.Closer

 -->part1
WITH CloserOpportunities_CTE ([Month], [Quarter], Closer, Active, Stage, [Mobile App], [Site], [Split With Closer], oes)  
AS  
(
	   SELECT CONVERT( VARCHAR(4), YEAR(a.[Created Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH([Created Time])), 2) AS [Month],
               CONVERT( VARCHAR(4), YEAR(a.[Created Time]))+'-'+CONVERT(VARCHAR(1), DATEPART(q, a.[Created Time]))+'Q' AS [Quarter],
			ISNULL(a.Closer, 'Missing') AS Closer,
               CASE
                   WHEN b.active = 1 THEN 'YES'
                   ELSE 'NO'
                   END AS Active,
               CASE
                   WHEN a.Stage IN('Client Inactive', 'IC Deleted Profile')
                   THEN 'Inactive + Deleted Profile'
                   WHEN a.Stage = 'Negative Response IE - SEND OE'
                   THEN 'Negative Response'
                   ELSE a.Stage
               END AS Stage,
               ISNULL(a.[Mobile App], 'No') AS [Mobile App],
               ISNULL(d.[Site], 'No Site') AS [Site],
			a.[Split With Closer],
			c.oes
        FROM [VIDA].[dbo].[opportunities] a
        LEFT JOIN [TRACK].dbo.users b ON a.Closer = b.name	   
	   LEFT JOIN
        (
            SELECT [Related To],
                   COUNT(*) AS oes
            FROM [VIDA].[dbo].[tasks]
            WHERE [Related To] IS NOT NULL
                  AND [Type] LIKE '%Outbound Email%'
            GROUP BY [Related To]
        ) c ON a.[Opportunities Id] = c.[Related To]
	   INNER JOIN VIDA.dbo.sites d ON a.[Site] = d.origin--REPLACE(REPLACE(a.[Site], CHAR(13), ''), CHAR(10), '') = d.origin
		  
		   WHERE 
			 a.Stage IN('Got Phone Number', 'Pursued Date But Got Number', 'Date Completely Scheduled Online', 'Numbers exchanged', 'Client Inactive', 'IC Deleted Profile', 'Closed Lost', 'Negative Response IE - SEND OE')
             AND d.[Site] <> 'eHarmony'
             AND a.[Created Time] between @dstart and @dend--CONVERT(VARCHAR(4), YEAR(a.[Created Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Created Time])), 2) BETWEEN @start AND @end
		   --AND CONVERT(VARCHAR(4), YEAR(a.[Created Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Created Time])), 2) BETWEEN @start AND @end
             AND LTRIM(RTRIM(a.[Opportunities Name])) NOT LIKE 'SALES%'
		   AND a.closer = 'Connor Moran'
),



 -->part2
SplitCloserOpportunities_CTE ([Month], [Quarter], Closer, Active, Stage, [Mobile App], [Site], [Split With Closer], oes)  
AS  
(
SELECT CONVERT( VARCHAR(4), YEAR([Created Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH([Created Time])), 2) AS [Month],
               CONVERT( VARCHAR(4), YEAR([Created Time]))+'-'+CONVERT(VARCHAR(1), DATEPART(q, a.[Created Time]))+'Q' AS [Quarter],
               CASE
                   WHEN a.[Split With Closer] IS NULL
                   THEN 'Missing'
                   ELSE a.[Split With Closer]
               END AS Closer,
               CASE
                   WHEN b.active = 1 THEN 'YES'
                   ELSE 'NO'
                   END AS Active,
               CASE
                   WHEN a.Stage IN('Client Inactive', 'IC Deleted Profile')
                   THEN 'Inactive + Deleted Profile'
                   WHEN a.Stage = 'Negative Response IE - SEND OE'
                   THEN 'Negative Response'
                   ELSE a.Stage
               END AS Stage,
               ISNULL(a.[Mobile App], 'No') AS [Mobile App],
               ISNULL(d.[Site], 'No Site') AS [Site],
			a.[Split With Closer],
			c.oes
        FROM [VIDA].[dbo].[opportunities] a
             LEFT JOIN [TRACK].dbo.users b ON a.[Split With Closer] = b.name
             LEFT JOIN
        (
            SELECT [Related To],
                   COUNT(*) AS oes
            FROM [VIDA].[dbo].[tasks]
            WHERE [Related To] IS NOT NULL
                  AND [Type] LIKE '%Outbound Email%'
            GROUP BY [Related To]
        ) c ON a.[Opportunities Id] = c.[Related To]
             INNER JOIN VIDA.dbo.sites d ON a.[Site] = d.origin--REPLACE(REPLACE(a.[Site], CHAR(13), ''), CHAR(10), '') = d.origin
        WHERE a.Stage IN('Got Phone Number', 'Pursued Date But Got Number', 'Date Completely Scheduled Online', 'Numbers exchanged', 'Client Inactive', 'IC Deleted Profile', 'Closed Lost', 'Negative Response IE - SEND OE')
             AND d.[Site] <> 'eHarmony'
             AND a.[Created Time] between @dstart and @dend--AND CONVERT(VARCHAR(4), YEAR(a.[Created Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Created Time])), 2) BETWEEN @start AND @end
             AND LTRIM(RTRIM(a.[Opportunities Name])) NOT LIKE 'SALES%'
		   and a.closer = 'Connor Moran'
             AND a.[Split With Closer] IS NOT NULL
)

SELECT [Month], [Quarter], Closer, Active, Stage, [Mobile App], [Site],
	   SUM(CASE
                WHEN [Split With Closer] IS NULL
                THEN 1
                ELSE 0.5
            END) AS Quant,
        SUM(CASE
                WHEN oes IS NULL
                THEN 0
                ELSE oes
            END) AS [OEs]
FROM (
    SELECT [Month], [Quarter], Closer, Active, Stage, [Mobile App], [Site], [Split With Closer], [OEs]
    FROM CloserOpportunities_CTE
    UNION ALL
    SELECT [Month], [Quarter], Closer, Active, Stage, [Mobile App], [Site], [Split With Closer], [OEs]
    FROM SplitCloserOpportunities_CTE
) GrouppingTable
GROUP BY
    [Month], [Quarter], Closer, Active, Stage, [Mobile App], [Site]
    
    */