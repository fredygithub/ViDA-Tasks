USE vida;
GO
DECLARE @DateFrom DATETIME= (GetDate() - 90);

SELECT PM_YN,
       [Leads],
       [Opportunities],
       CAST((CAST([Opportunities] AS NUMERIC)) / ([Leads] + [Opportunities]) AS NUMERIC(10, 2)) ConversionRatePerc
FROM
(
    SELECT [Source],
           PM_YN,
           [Count]
    FROM
    (
        SELECT 'Opportunities' [Source],
               COUNT(DISTINCT op.[Opportunities ID]) [Count],
               CASE
                   WHEN [Predictive Messaging Template Used] IN('1st Template Used', '2nd Template Used')
                   THEN 'PM'
                   ELSE 'Non PM'
               END PM_YN
        FROM ViDA.dbo.opportunities op
             INNER JOIN ViDA.dbo.accounts acct ON acct.[Clients Id] = op.[Clients Id]
             INNER JOIN ViDA.dbo.opportunities_stages hist ON hist.[Opportunities ID] = op.[Opportunities ID]
             CROSS APPLY
        (
            SELECT [Opportunities ID]
            FROM ViDA.dbo.opportunities_stages
            WHERE [Opportunities ID] = op.[Opportunities ID]
            GROUP BY [Opportunities ID]
            HAVING COUNT(*) >= 1
        ) tcount
        WHERE op.[created time] > @DateFrom
              AND op.[site] IN('Match', 'POF')
             AND ISNULL([Predictive Messaging Template Used], 'Neither Used') IN ('1st Template Used', '2nd Template Used', 'Neither Used')
        GROUP BY CASE
                     WHEN [Predictive Messaging Template Used] IN('1st Template Used', '2nd Template Used')
                   THEN 'PM'
                   ELSE 'Non PM'
                 END
        UNION ALL
        SELECT 'Leads' [Source],
               COUNT(DISTINCT [Lead Id]) [Count],
               CASE
                   WHEN [Predictive Messaging Template Used] IN('1st Template Used', '2nd Template Used')
                   THEN 'PM'
                   ELSE 'Non PM'
               END PM_YN
        FROM ViDA.dbo.leads
        WHERE [created time] > @DateFrom
              AND [site] IN('Match', 'POF')
        AND ISNULL([Predictive Messaging Template Used], 'Neither Used') IN('1st Template Used', '2nd Template Used', 'Neither Used')
        GROUP BY CASE
                     WHEN [Predictive Messaging Template Used] IN('1st Template Used', '2nd Template Used')
                   THEN 'PM'
                   ELSE 'Non PM'
                 END
    ) t
) AS SourceTable PIVOT(SUM([Count]) FOR [Source] IN([Leads],
                                                    [Opportunities])) AS PivotTable;