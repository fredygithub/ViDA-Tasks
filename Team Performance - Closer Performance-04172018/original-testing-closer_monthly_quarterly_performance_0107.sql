--DECLARE @start VARCHAR(7)= '2015-02';
--DECLARE @end VARCHAR(7)= '2018-04';
DECLARE @start VARCHAR(7)= '2018-04';
DECLARE @end VARCHAR(7)= '2018-06';
DECLARE @Closer VARCHAR(50) = 'Arielle Lindsey';
IF OBJECT_ID('tempdb..#tmp_closer_monthly_quarterly_performance') IS NOT NULL
    DROP TABLE #tmp_closer_monthly_quarterly_performance

--DROP TABLE [VIDA].[dbo].[closer_monthly_quarterly_performance];
SELECT a.[Month],
       a.[Quarter],
       a.Closer,
       a.Active,
       CASE
           WHEN a.Stage = 'Numbers exchanged'
           THEN 'Got Phone Number'
           ELSE a.Stage
       END AS Stage,
       a.[Mobile App],
       a.[Site],
       a.Quant,
       CASE
           WHEN b.[Hours] IS NULL
           THEN 0.
           ELSE b.[Hours]
       END AS [Hours],
       a.[OEs],
       CASE
           WHEN c.oes_hours IS NULL
           THEN 0.
           ELSE c.oes_hours
       END AS [OEs_Hours]
	  into #tmp_closer_monthly_quarterly_performance
--INTO [VIDA].[dbo].[closer_monthly_quarterly_performance]
FROM
(
    SELECT z.[Month],
           z.[Quarter],
           z.Closer,
           z.Active,
           z.Stage,
           z.[Mobile App],
           z.[Site],
           SUM(z.Quant) AS Quant,
           SUM(z.OEs) AS OEs
    FROM
    (
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
			a.Stage,
               --CASE
               --    WHEN a.Stage IN('Client Inactive', 'IC Deleted Profile')
               --    THEN 'Inactive + Deleted Profile'
               --    WHEN a.Stage = 'Negative Response IE - SEND OE'
               --    THEN 'Negative Response'
               --    ELSE a.Stage
               --END AS Stage,
               ISNULL(a.[Mobile App], 'No') AS [Mobile App],
               ISNULL(d.[Site], 'No Site') AS [Site],
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
                                                  WHEN a.Closer IS NULL
                                                  THEN 'Missing'
                                                  ELSE a.Closer
                                              END = b.name
           LEFT JOIN
        (
            SELECT [Related To],
                   COUNT(*) AS oes
            FROM [VIDA].[dbo].[tasks]
		  		  INNER JOIN [VIDA].[dbo].[opportunities] o ON [tasks].[Related To] = o.[Opportunities Id]
		  INNER JOIN VIDA.dbo.sites ON REPLACE(REPLACE(o.[Site], CHAR(13), ''), CHAR(10), '') = sites.origin
            WHERE [Related To] IS NOT NULL
                  AND [tasks].[Type] LIKE '%Outbound Email%'
			   			   AND [tasks].Closer IS NOT NULL
						   and o.Closer = @Closer
			   AND REPLACE(REPLACE([tasks].Closer, CHAR(13), ''), CHAR(10), '') <> ''
            GROUP BY [Related To]
        ) c ON a.[Opportunities Id] = c.[Related To]
             INNER JOIN VIDA.dbo.sites d ON REPLACE(REPLACE(a.[Site], CHAR(13), ''), CHAR(10), '') = d.origin
		  -- inner join VIDA.dbo.accounts acc on acc.[Clients Id] = a.[Clients Id]
        WHERE a.Stage IN('Got Phone Number', 'Pursued Date But Got Number', 'Date Completely Scheduled Online', 'Numbers exchanged', 'Client Inactive', 'IC Deleted Profile', 'Closed Lost', 'Negative Response IE - SEND OE')
             AND d.[Site] <> 'eHarmony'
             AND CONVERT(VARCHAR(4), YEAR(a.[Created Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Created Time])), 2) BETWEEN @start AND @end
             AND LTRIM(RTRIM(a.[Opportunities Name])) NOT LIKE 'SALES%'
		   --and acc.[Clients Name] = 'Anthony Dominguez'
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
			  a.Stage,
                 --CASE
                 --    WHEN a.Stage IN('Client Inactive', 'IC Deleted Profile')
                 --    THEN 'Inactive + Deleted Profile'
                 --    WHEN a.Stage = 'Negative Response IE - SEND OE'
                 --    THEN 'Negative Response'
                 --    ELSE a.Stage
                 --END,
                 ISNULL(a.[Mobile App], 'No'),
                 ISNULL(d.[Site], 'No Site')
       /* UNION ALL
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
			a.Stage,
               --CASE
               --    WHEN a.Stage IN('Client Inactive', 'IC Deleted Profile')
               --    THEN 'Inactive + Deleted Profile'
               --    WHEN a.Stage = 'Negative Response IE - SEND OE'
               --    THEN 'Negative Response'
               --    ELSE a.Stage
               --END AS Stage,
               ISNULL(a.[Mobile App], 'No') AS [Mobile App],
               ISNULL(d.[Site], 'No Site') AS [Site],
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
		  INNER JOIN [VIDA].[dbo].[opportunities] o ON [tasks].[Related To] = o.[Opportunities Id]
		  INNER JOIN VIDA.dbo.sites ON REPLACE(REPLACE(o.[Site], CHAR(13), ''), CHAR(10), '') = sites.origin
            WHERE [Related To] IS NOT NULL
                  AND [tasks].[Type] LIKE '%Outbound Email%'
			   AND [tasks].Closer IS NOT NULL
			   AND REPLACE(REPLACE([tasks].Closer, CHAR(13), ''), CHAR(10), '') <> ''
            GROUP BY [Related To]
        ) c ON a.[Opportunities Id] = c.[Related To]
             INNER JOIN VIDA.dbo.sites d ON REPLACE(REPLACE(a.[Site], CHAR(13), ''), CHAR(10), '') = d.origin
		   --inner join VIDA.dbo.accounts acc on acc.[Clients Id] = a.[Clients Id]
        WHERE a.Stage IN('Got Phone Number', 'Pursued Date But Got Number', 'Date Completely Scheduled Online', 'Numbers exchanged', 'Client Inactive', 'IC Deleted Profile', 'Closed Lost', 'Negative Response IE - SEND OE')
             AND d.[Site] <> 'eHarmony'
             AND CONVERT(VARCHAR(4), YEAR(a.[Created Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Created Time])), 2) BETWEEN @start AND @end
             AND LTRIM(RTRIM(a.[Opportunities Name])) NOT LIKE 'SALES%'
		   --and acc.[Clients Name] = 'Anthony Dominguez'
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
			  a.Stage,
                 --CASE
                 --    WHEN a.Stage IN('Client Inactive', 'IC Deleted Profile')
                 --    THEN 'Inactive + Deleted Profile'
                 --    WHEN a.Stage = 'Negative Response IE - SEND OE'
                 --    THEN 'Negative Response'
                 --    ELSE a.Stage
                 --END,
                 ISNULL(a.[Mobile App], 'No'),
                 ISNULL(d.[Site], 'No Site')*/
    ) z
    GROUP BY z.[Month],
             z.[Quarter],
             z.Closer,
             z.Active,
             z.Stage,
             z.[Mobile App],
             z.[Site]
) a
LEFT JOIN
(
    SELECT CONVERT( VARCHAR(4), YEAR(a.[created_time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[created_time])), 2) AS [Month],
           b.name AS Closer,
           SUM(DATEDIFF(mi, a.start, a.[end]) / 60.) AS [Hours]
    FROM [TRACK].[dbo].[trackings] a
         INNER JOIN [TRACK].[dbo].[users] b ON a.[user_id] = b.[user_id]
    WHERE a.task_id IN(60, 103, 131, 263)
         AND a.site_id <> 17 -- Outbound Emails
    GROUP BY CONVERT( VARCHAR(4), YEAR(a.[created_time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[created_time])), 2),
             CONVERT( VARCHAR(4), YEAR(a.[created_time]))+'-'+CONVERT(VARCHAR(1), DATEPART(q, a.[created_time]))+'Q',
             b.name
) b ON a.[Month] = b.[Month]
       AND a.Closer = b.Closer
LEFT JOIN
(
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
    GROUP BY CONVERT( VARCHAR(4), YEAR(a.[Modified Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Modified Time])), 2),
             a.Closer
) c ON a.[Month] = c.[Month]
       AND a.Closer = c.Closer
	  where a.Closer = @Closer;
--GO
select * from #tmp_closer_monthly_quarterly_performance
WHERE --Stage IN('Got Phone Number', 'Pursued Date But Got Number', 'Date Completely Scheduled Online', 'Numbers exchanged')
    [mobile app]='No'
--UPDATE a
--  SET
select 
      a.[Hours] , a.[Hours] / b.div,
      a.[OEs_Hours] , a.[OEs_Hours] / b.div
FROM [VIDA].[dbo].[closer_monthly_quarterly_performance] a
     INNER JOIN
(
    SELECT [Month],
           [Quarter],
           [Closer],
           [Active],
           COUNT(*) AS div
    FROM #tmp_closer_monthly_quarterly_performance--[VIDA].[dbo].[closer_monthly_quarterly_performance]
    GROUP BY [Month],
             [Quarter],
             [Closer],
             [Active]
) b ON a.[Month] = b.[Month]
       AND a.Closer = b.Closer
	  where a.Closer = @Closer;
--GO
--INSERT INTO [VIDA].[dbo].[closer_monthly_quarterly_performance]
       SELECT [Month],
              [Quarter],
              Closer,
              Active,
              '# or Date % SUM' AS Stage,
              [Mobile App],
              [Site],
              SUM(Quant) AS Quant,
              0 AS [Hours],
              0 AS [OEs],
              0 AS [OEs_Hours]
       FROM #tmp_closer_monthly_quarterly_performance--[VIDA].[dbo].[closer_monthly_quarterly_performance]
       WHERE Stage IN('Got Phone Number', 'Pursued Date But Got Number', 'Date Completely Scheduled Online', 'Numbers exchanged')
	  and Closer = @Closer
       GROUP BY [Month],
                [Quarter],
                Closer,
                Active,
                [Mobile App],
                [Site]

GO