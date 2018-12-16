DECLARE @start VARCHAR(7)= '2018-03';
DECLARE @end VARCHAR(7)= '2018-03';
declare @dstart datetime = '03/01/2018'
declare @dend datetime = '03/31/2018 23:59';

select *
            FROM [VIDA].[dbo].[tasks]
		  		  INNER JOIN [VIDA].[dbo].[opportunities] o ON [tasks].[Related To] = o.[Opportunities Id]
		  INNER JOIN VIDA.dbo.sites ON REPLACE(REPLACE(o.[Site], CHAR(13), ''), CHAR(10), '') = sites.origin
            WHERE [Related To] = 'zcrm_200867000045556278'

--select * from track.dbo.users
--    inner join track.dbo.roles on users.role_id = roles.role_id where name = 'Josh Grapes'
		    SELECT *
  from
  ( 

  select [Related To], COUNT(*) AS oes
            FROM [VIDA].[dbo].[tasks]
		  		  INNER JOIN [VIDA].[dbo].[opportunities] o ON [tasks].[Related To] = o.[Opportunities Id]
		  INNER JOIN VIDA.dbo.sites ON REPLACE(REPLACE(o.[Site], CHAR(13), ''), CHAR(10), '') = sites.origin
            WHERE [Related To] IS NOT NULL
                  AND [tasks].[Type] LIKE '%Outbound Email%'
			   			   --AND [tasks].Closer IS NOT NULL
						   AND o.closer = 'Connor Moran'
			   --AND REPLACE(REPLACE([tasks].Closer, CHAR(13), ''), CHAR(10), '') <> ''
			   AND LTRIM(RTRIM(o.[Opportunities Name])) NOT LIKE 'SALES%'
			   AND sites.[Site] <> 'eHarmony'
			   --AND [tasks].[Created Time] between @dstart and @dend
			   AND [tasks].[Closed Time] between @dstart and @dend
			  --and CONVERT( VARCHAR(4), YEAR([tasks].[Modified Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH([tasks].[Modified Time])), 2) = '2018-03'
           -- GROUP BY CONVERT( VARCHAR(4), YEAR([tasks].[Modified Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH([tasks].[Modified Time])), 2),[Related To]
		 group by [Related To]


) t1   left join
( 
DECLARE @start VARCHAR(7)= '2018-03';
DECLARE @end VARCHAR(7)= '2018-03';
SELECT	  --CONVERT( VARCHAR(4), YEAR(a.[Created Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Created Time])), 2) AS [Month],
               --CONVERT( VARCHAR(4), YEAR(a.[Created Time]))+'-'+CONVERT(VARCHAR(1), DATEPART(q, a.[Created Time]))+'Q' AS [Quarter],
			 a.[Opportunities Id],
			 count(*) OES_2
   --            CASE
   --                WHEN a.Closer IS NULL
   --                THEN 'Missing'
   --                ELSE a.Closer
   --            END AS Closer,
   --            CASE
   --                WHEN b.active IS NULL
   --                THEN 'NO'
   --                ELSE CASE
   --                         WHEN b.active = 0
   --                         THEN 'NO'
   --                         ELSE 'YES'
   --                     END
   --            END AS Active,
			--a.Stage,
   --            ISNULL(a.[Mobile App], 'No') AS [Mobile App],
   --            ISNULL(d.[Site], 'No Site') AS [Site]--,
			
        FROM [VIDA].[dbo].[opportunities] a
		   INNER JOIN [VIDA].[dbo].[tasks] t on t.[Related To] = a.[Opportunities Id]
             LEFT JOIN [TRACK].dbo.users b ON CASE
                                                  WHEN a.Closer IS NULL
                                                  THEN 'Missing'
                                                  ELSE a.Closer
                                              END = b.name
               INNER JOIN VIDA.dbo.sites d ON REPLACE(REPLACE(a.[Site], CHAR(13), ''), CHAR(10), '') = d.origin
		  -- inner join VIDA.dbo.accounts acc on acc.[Clients Id] = a.[Clients Id]
        WHERE 
	   --a.Stage IN('Got Phone Number', 'Pursued Date But Got Number', 'Date Completely Scheduled Online', 'Numbers exchanged', 'Client Inactive', 'IC Deleted Profile', 'Closed Lost', 'Negative Response IE - SEND OE')
             --AND 
		   d.[Site] <> 'eHarmony'		   
             AND CONVERT(VARCHAR(4), YEAR(t.[Closed Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(t.[Closed Time])), 2) BETWEEN @start AND @end
             AND LTRIM(RTRIM(a.[Opportunities Name])) NOT LIKE 'SALES%'
		   AND a.closer = 'Connor Moran'
		   AND a.[Opportunities Id] = 'zcrm_200867000045556278'
		   group by a.[Opportunities Id]

) t2 on t1.[Related To] = t2.[Opportunities Id]