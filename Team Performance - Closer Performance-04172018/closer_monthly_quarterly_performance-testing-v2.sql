declare @start varchar(7) = '2015-02'
declare @end varchar(7) = '2018-04'

       SELECT CONVERT( VARCHAR(4), YEAR([Created Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH([Created Time])), 2) AS [Month],
               CONVERT( VARCHAR(4), YEAR([Created Time]))+'-'+CONVERT(VARCHAR(1), DATEPART(q, a.[Created Time]))+'Q' AS [Quarter],
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
            WHERE [Related To] IS NOT NULL
                  AND [Type] LIKE '%Outbound Email%'
            GROUP BY [Related To]
        ) c ON a.[Opportunities Id] = c.[Related To]
             INNER JOIN VIDA.dbo.sites d ON REPLACE(REPLACE(a.[Site], CHAR(13), ''), CHAR(10), '') = d.origin
        WHERE a.Stage IN('Got Phone Number', 'Pursued Date But Got Number', 'Date Completely Scheduled Online', 'Numbers exchanged', 'Client Inactive', 'IC Deleted Profile', 'Closed Lost', 'Negative Response IE - SEND OE')
             AND d.[Site] <> 'eHarmony'
             AND CONVERT(VARCHAR(4), YEAR(a.[Created Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Created Time])), 2) BETWEEN @start AND @end
             AND LTRIM(RTRIM(a.[Opportunities Name])) NOT LIKE 'SALES%'
	   and a.closer = 'Connor Moran'
GROUP BY CONVERT( VARCHAR(4), YEAR([Created Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH([Created Time])), 2),
                 CONVERT( VARCHAR(4), YEAR([Created Time]))+'-'+CONVERT(VARCHAR(1), DATEPART(q, a.[Created Time]))+'Q',
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
                 ISNULL(d.[Site], 'No Site')

declare @dstart datetime = '02/01/2015'
declare @dend datetime = '05/01/2018';

WITH Opportunities_CTE1 ([Month], [Quarter], Closer, Active, Stage, [Mobile App], [Site], [Split With Closer], oes)  
AS  
-- Define the CTE query.  
(
	   SELECT CONVERT( VARCHAR(4), YEAR([Created Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH([Created Time])), 2) AS [Month],
               CONVERT( VARCHAR(4), YEAR([Created Time]))+'-'+CONVERT(VARCHAR(1), DATEPART(q, a.[Created Time]))+'Q' AS [Quarter],
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
)

select [Month], [Quarter], Closer, Active, Stage, [Mobile App], [Site], 
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
from Opportunities_CTE1
group by [Month], [Quarter], Closer, Active, Stage, [Mobile App], [Site]
    