DECLARE @start VARCHAR(7)= '2018-04';
DECLARE @end VARCHAR(7)= '2018-06';
DECLARE @Closer VARCHAR(50) = 'Arielle Lindsey';

SELECT a.[Opportunities Name],
CONVERT( VARCHAR(4), YEAR(a.[Created Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Created Time])), 2) AS [Month],
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
               CASE
                       WHEN a.[Split With Closer] IS NULL
                       THEN 1
                       ELSE 0.5
                   END AS Quant,
               CASE
                       WHEN c.oes IS NULL
                       THEN 0
                       ELSE c.oes
                   END AS [OEs],
			    a.[Split With Closer] 
			    ,c.[Type]
			    ,[Closed Time]
        FROM [VIDA].[dbo].[opportunities] a
             LEFT JOIN [TRACK].dbo.users b ON CASE
                                                  WHEN a.Closer IS NULL
                                                  THEN 'Missing'
                                                  ELSE a.Closer
                                              END = b.name
           LEFT JOIN
        (
            SELECT [Related To],
		  [tasks].[Type],
		  [Closed Time],
                   COUNT(*) AS oes
            FROM [VIDA].[dbo].[tasks]
		  		  INNER JOIN [VIDA].[dbo].[opportunities] o ON [tasks].[Related To] = o.[Opportunities Id]
		  INNER JOIN VIDA.dbo.sites ON REPLACE(REPLACE(o.[Site], CHAR(13), ''), CHAR(10), '') = sites.origin
            WHERE [Related To] IS NOT NULL
                  AND [tasks].[Type] LIKE '%Outbound Email%'
			   --AND [tasks].[Type] NOT LIKE '%NR%'
			   			   AND [tasks].Closer IS NOT NULL
						   and o.Closer = @Closer
			   AND REPLACE(REPLACE([tasks].Closer, CHAR(13), ''), CHAR(10), '') <> ''
            GROUP BY [Related To]
		  ,[Closed Time]
		  ,[tasks].[Type]
        ) c ON a.[Opportunities Id] = c.[Related To]
             INNER JOIN VIDA.dbo.sites d ON REPLACE(REPLACE(a.[Site], CHAR(13), ''), CHAR(10), '') = d.origin
		  -- inner join VIDA.dbo.accounts acc on acc.[Clients Id] = a.[Clients Id]
        WHERE a.Stage IN('Got Phone Number', 'Pursued Date But Got Number', 'Date Completely Scheduled Online', 'Numbers exchanged', 'Client Inactive', 'IC Deleted Profile', 'Closed Lost', 'Negative Response IE - SEND OE')
             AND d.[Site] <> 'eHarmony'
             AND CONVERT(VARCHAR(4), YEAR(a.[Created Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Created Time])), 2) BETWEEN @start AND @end
             AND LTRIM(RTRIM(a.[Opportunities Name])) NOT LIKE 'SALES%'
		   --and acc.[Clients Name] = 'Anthony Dominguez'
		   and a.closer = @Closer
		   AND UPPER(ISNULL(a.[Mobile App], 'NO')) = 'NO'

		   order by-- [Closed Time]       
		  CONVERT( VARCHAR(4), YEAR(a.[Created Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Created Time])), 2) ,
             CONVERT( VARCHAR(4), YEAR(a.[Created Time]))+'-'+CONVERT(VARCHAR(1), DATEPART(q, a.[Created Time]))+'Q',
             a.Closer,
             b.active,
             a.Stage,
             ISNULL(a.[Mobile App], 'No'),
               ISNULL(d.[Site], 'No Site')