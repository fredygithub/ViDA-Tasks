USE VIDA
GO

ALTER PROCEDURE get_closer_oes_report
AS
/*
Setting on ChallengeLevel

--> VIDA.dbo.Account --> Gender field


-->1- Male/Female /*select Gender, count(*) cnt from Vida.dbo.Accounts group by Gender -- select [active?], count(*) from Vida.dbo.Accounts where Gender is null group by [active?] */
    Male- 4
    Female- 2

-->2- Profile Tone (only considering avg of 1st)
    1- Strong Attn Grabber
    2- Over the Top
    3- Humorous
    4- Down to Earth
    5- Warm and Friendly

-->3- Age (opposite for male and female in terms of difficulty) Is it [Min Age], [Max Age]? What about nulls?
    Male
    5- 18-25
    4- 25-35
    3- 35-45
    2- 45-55
    1- 55+
    Female
    1- 18-25
    2- 25-35
    3- 35-45
    4- 45-55
    5- 55+

--> 4- Client Difficulty:
1- Easy
3- Normal
5- Particular

--> 5- Package Level
    1- Bronze
    Bronze Plus
    2- Silver
    Silver Plus
    3- Gold
    Gold Plus
    4- Platinum
    5- Sapphire
    Diamond
    Sapphire Elite
    Diamond Elite

*/
DECLARE
  @MobileApp VARCHAR(5)='NO';

DECLARE
  @LastTreeMonth DATETIME=DATEADD( DAY, -90, GETDATE( ) );

DECLARE
  @tmp_Stages TABLE
(
  id             INT IDENTITY,
  Name           NVARCHAR(100),
  CloseDate      BIT,
  GotPhoneNumber BIT,
  GotDate        BIT);

INSERT INTO @tmp_Stages
(Name,
 CloseDate,
 GotPhoneNumber,
 GotDate)
       SELECT 'Got Phone Number',
              1 CloseDate,
              1 GotPhoneNumber,
              0 GotDate
       UNION
       SELECT 'Pursued Date But Got Number',
              1 CloseDate,
              1 GotPhoneNumber,
              0 GotDate
       UNION
       SELECT 'Date Completely Scheduled Online',
              1 CloseDate,
              0 GotPhoneNumber,
              1 GotDate
       UNION
       SELECT 'Numbers exchanged',
              0 CloseDate,
              0 GotPhoneNumber,
              0 GotDate
       UNION
       SELECT 'Client Inactive',
              0 CloseDate,
              0 GotPhoneNumber,
              0 GotDate
       UNION
       SELECT 'IC Deleted Profile',
              0 CloseDate,
              0 GotPhoneNumber,
              0 GotDate
       UNION
       SELECT 'Closed Lost',
              0 CloseDate,
              0 GotPhoneNumber,
              0 GotDate
       UNION
       SELECT 'Negative Response IE - SEND OE',
              0 CloseDate,
              0 GotPhoneNumber,
              0 GotDate;

SELECT Closer,
       RIGHT( '0'+CONVERT( VARCHAR(5), SUM( SumForOE_CRM )/SUM( OES_CRM )/60/60 ), 2 )+':'+RIGHT( '0'+CONVERT( VARCHAR(2), SUM( SumForOE_CRM )/SUM( OES_CRM )/60%60 ), 2 )+':'+RIGHT( '0'+CONVERT( VARCHAR(2), SUM( SumForOE_CRM )/SUM( OES_CRM )%60 ), 2 ) [AvgHsForOE CRM],
       SUM( OES_CRM )                                                                                                                                                                                                                                       [OES CRM],
	  CAST( CAST( SUM( NR_CRM ) AS  DECIMAL(10, 2) )/CAST( SUM( OppCount ) AS DECIMAL(10, 2) ) AS DECIMAL(10, 2) ) [NR AVG/OPP],
       SUM( CloseDateOpp )                                                                                                                                                                                                                                  [CloseDate Count],
       SUM( CASE
              WHEN CloseDateOpp=0
              THEN 1
              ELSE 0
            END )                                                                                                                                                                                                                                           [NON CloseDate Count],
	  SUM(OppCount) [Total_OppCount],
       CAST( CAST( SUM( CloseDateOpp ) AS  DECIMAL(10, 2) )/CAST( SUM( OppCount ) AS DECIMAL(10, 2) ) AS DECIMAL(10, 2) )                                                                                                                                   [ConversionRate %],
       CASE
         WHEN SUM( CloseDateOpp )>0
         THEN CAST( CAST( SUM( DaysToCloseDate_CRM ) AS  DECIMAL(10, 2) )/CAST( SUM( CloseDateOpp ) AS DECIMAL(10, 2) ) AS DECIMAL(10, 2) )
         ELSE 0
       END                                                                                                                                                                                                                                                  [DaysToCloseDate CRM],
       CASE
         WHEN SUM( CloseDateOpp )>0
         THEN CAST( CAST( SUM( OESonCloseDate_CRM ) AS  DECIMAL(10, 2) )/CAST( SUM( CloseDateOpp ) AS DECIMAL(10, 2) ) AS DECIMAL(10, 2) )
         ELSE 0
       END                                                                                                                                                                                                                                                  [OESonCloseDate CRM],
       CASE
         WHEN SUM( CloseDateOpp )>0
         THEN CAST( CAST( SUM( NRonCloseDate_CRM ) AS  DECIMAL(10, 2) )/CAST( SUM( CloseDateOpp ) AS DECIMAL(10, 2) ) AS DECIMAL(10, 2) )
         ELSE 0
       END                                                                                                                                                                                                                                                  [NRonnCloseDate CRM],
       CASE
         WHEN SUM( CloseDateOpp )>0
         THEN CAST( CAST( SUM( AchievingClients_Pref ) AS  DECIMAL(10, 2) )/CAST( SUM( CloseDateOpp ) AS DECIMAL(10, 2) ) AS DECIMAL(10, 2) )
         ELSE 0
       END                                                                                                                                                                                                                                                  [AchievingClients Pref %]
FROM
(
  SELECT a.Closer,
         Stages.Name,
         a.[Opportunities Name],
         SUM( DATEDIFF( second, c.[Created Time], c.[Closed Time] ) ) SumForOE_CRM,
         ISNULL( COUNT( DISTINCT c.[Task Id] ), 0 )                   OES_CRM,
         ISNULL( COUNT( DISTINCT nr.[Task Id] ), 0 )                  NR_CRM,
         CASE
           WHEN Stages.CloseDate=1
           THEN DATEDIFF( day, MIN( c.[Closed Time] ), [Closing Date] )
           ELSE 0
         END                                                          DaysToCloseDate_CRM,
         SUM( CASE
                WHEN Stages.CloseDate=1
                     AND c.[Closed Time]<[Closing Date]
                THEN 1
                ELSE 0
              END )                                                   OESonCloseDate_CRM,
         SUM( CASE
                WHEN Stages.CloseDate=1
                     AND nr.[Closed Time]<[Closing Date]
                THEN 1
                ELSE 0
              END )                                                   NRonCloseDate_CRM,
         ISNULL( COUNT( DISTINCT a.[Opportunities Id] ), 0 )          OppCount,
         CASE
           WHEN Stages.CloseDate=1
           THEN 1
           ELSE 0
         END                                                          CloseDateOpp,
         CASE
           WHEN Stages.GotPhoneNumber=1
                AND acc.[Date / Number Preference] LIKE '%phone%'
           THEN 1
           WHEN Stages.GotDate=1
                AND acc.[Date / Number Preference] LIKE '%Date%'
           THEN 1
           WHEN Stages.CloseDate=1
                AND (acc.[Date / Number Preference] LIKE '%No%Preference%'
                     OR acc.[Date / Number Preference] IS NULL)
           THEN 1
           ELSE 0
         END                                                          AchievingClients_Pref
  FROM VIDA.dbo.opportunities a
  LEFT JOIN
  TRACK.dbo.users b
  ON a.Closer=b.name
      INNER JOIN
      VIDA.dbo.sites d
      ON REPLACE( REPLACE( a.Site, CHAR( 13 ), '' ), CHAR( 10 ), '' )=d.origin
          INNER JOIN
          VIDA.dbo.accounts acc
          ON acc.[Clients Id]=a.[Clients Id]
              INNER JOIN
  (
    SELECT [Task Id],
           [Created Time],
           Closer,
           [Related To],
           Type,
           [Closed Time]
    FROM VIDA.dbo.tasks
    WHERE [Related To] IS NOT NULL
          AND Type LIKE '%Outbound Email%'
          AND Type NOT LIKE '%nr%'
          AND [Closed Time]>=@LastTreeMonth
  ) c
              ON a.[Opportunities Id]=c.[Related To]
                 AND c.Closer=a.closer
                  LEFT JOIN
  (
    SELECT [Task Id],
           Closer,
           [Related To],
           Type,
           [Closed Time]
    FROM VIDA.dbo.tasks
    WHERE [Related To] IS NOT NULL
          AND Type LIKE '%nr%'
		AND REPLACE(Subject,' ','') LIKE '%nr-%'
          AND [Closed Time]>=@LastTreeMonth
  ) nr
                  ON a.[Opportunities Id]=nr.[Related To]
                     AND nr.Closer=a.closer
                      INNER JOIN
                      @tmp_Stages Stages
                      ON Stages.Name=a.Stage
  WHERE d.Site<>'eHarmony'
        AND LTRIM( RTRIM( a.[Opportunities Name] ) ) NOT LIKE 'SALES%'
        AND UPPER( ISNULL( a.[Mobile App], 'NO' ) )=@MobileApp
  GROUP BY a.Closer,
           acc.[Date / Number Preference],
           a.[Opportunities Name],
           a.[Closing Date],
           Stages.Name,
           Stages.CloseDate,
           Stages.GotPhoneNumber,
           Stages.GotDate
) t1
GROUP BY Closer
ORDER BY [OES CRM] DESC,
	   [ConversionRate %] DESC,
         --[NR CRM],
         [DaysToCloseDate CRM];