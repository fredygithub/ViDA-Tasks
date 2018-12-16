USE TRACK;
GO

--drop table [TRACK].[dbo].[REPORT_time_progress_by_client]
--GO

SELECT a.name AS client_name,
       a.active AS client_active,
       CASE
           WHEN b.active = 1
           THEN b.name
           ELSE 'AM Inactive'
       END AS account_manager_name,
       COALESCE(c.[total_hours_paid], 0.) + COALESCE(e.[total_hours_paid], 0.) AS [total_hours_paid],
       COALESCE(e.[total_hours_credited], 0.) AS [total_hours_credited],
       COALESCE(c.[total_hours_logged], 0.) + COALESCE(d.[total_hours_logged], 0.) AS [total_hours_logged],
       (COALESCE(c.[total_hours_paid], 0.) + COALESCE(e.[total_hours_paid], 0.) + COALESCE(e.[total_hours_credited], 0.)) - (COALESCE(c.[total_hours_logged], 0.) + COALESCE(d.[total_hours_logged], 0.)) AS total_over_under,
       CASE
           WHEN COALESCE(c.[month_start_date], CONVERT( DATE, '1900-01-01', 121)) > COALESCE(e.[month_start_date], CONVERT(DATE, '1900-01-01', 121))
           THEN c.[month_start_date]
           ELSE e.[month_start_date]
       END AS [month_start_date],
       CASE
           WHEN a.autobill = 1
           THEN CASE
                    WHEN e.profile_upgrade <> 0
                    THEN DATEADD(dd, 21,
                                     CASE
                                         WHEN COALESCE(c.[month_start_date], CONVERT( DATE, '1900-01-01', 121)) > COALESCE(e.[rebill_date], CONVERT(DATE, '1900-01-01', 121))
                                         THEN c.[month_start_date]
                                         ELSE e.[rebill_date]
                                     END)
                    ELSE DATEADD(mm, 1,
                                     CASE
                                         WHEN COALESCE(c.[month_start_date], CONVERT(DATE, '1900-01-01', 121)) > COALESCE(e.[rebill_date], CONVERT(DATE, '1900-01-01', 121))
                                         THEN c.[month_start_date]
                                         ELSE e.[rebill_date]
                                     END)
                END
           ELSE NULL
       END AS [autobill_date],
       CASE
           WHEN COALESCE(c.[month_start_date], CONVERT( DATE, '1900-01-01', 121)) > COALESCE(e.[month_start_date], CONVERT(DATE, '1900-01-01', 121))
           THEN c.[hours_purchased]
           WHEN COALESCE(c.[month_start_date], CONVERT(DATE, '1900-01-01', 121)) < COALESCE(e.[month_start_date], CONVERT(DATE, '1900-01-01', 121))
           THEN f.[hours_purchased]
           ELSE COALESCE(c.[hours_purchased], 0.) + COALESCE(f.[hours_purchased], 0.)
       END AS [hours_purchased],
       COALESCE(f.[hours_deducted], 0.) AS [hours_deducted],
       CASE
           WHEN COALESCE(c.[month_start_date], CONVERT( DATE, '1900-01-01', 121)) > COALESCE(e.[month_start_date], CONVERT(DATE, '1900-01-01', 121))
           THEN c.[hours_purchased] - COALESCE(g.total_hours_logged, 0.) - c.total_hours_logged + c.hours_logged_at_start
           WHEN COALESCE(c.[month_start_date], CONVERT(DATE, '1900-01-01', 121)) < COALESCE(e.[month_start_date], CONVERT(DATE, '1900-01-01', 121))
           THEN COALESCE(f.[hours_purchased], 0.) + COALESCE(f.hours_credited, 0.) - COALESCE(f.hours_deducted, 0.) - COALESCE(g.total_hours_logged, 0.)
           ELSE COALESCE(c.[hours_purchased], 0.) + COALESCE(f.[hours_purchased], 0.) + COALESCE(f.hours_credited, 0.) - COALESCE(f.hours_deducted, 0.) - COALESCE(g.total_hours_logged, 0.) - c.total_hours_logged + c.hours_logged_at_start
       END AS current_hours_remaining,
       CASE
           WHEN COALESCE(c.[month_start_date], CONVERT( DATE, '1900-01-01', 121)) > COALESCE(e.[month_start_date], CONVERT(DATE, '1900-01-01', 121))
           THEN c.[hours_purchased]
           WHEN COALESCE(c.[month_start_date], CONVERT(DATE, '1900-01-01', 121)) < COALESCE(e.[month_start_date], CONVERT(DATE, '1900-01-01', 121))
           THEN f.[package_hours]
           ELSE COALESCE(c.[hours_purchased], 0.) + COALESCE(f.[package_hours], 0.)
       END AS [package_hours],
       ISNULL(e.months, 0) AS number_of_months,
       ISNULL(phone_dates_hist.phones_hist, 0) AS phones_hist,
       ISNULL(phone_dates_hist.dates_hist, 0) AS dates_hist,
       ISNULL(phone_dates_curr.phones, 0) AS phones_curr,
       ISNULL(phone_dates_curr.dates, 0) AS dates_curr,
       ISNULL(acc.[Date / Number Preference], 'No Data') AS [Date / Number Preference],
       ISNULL(open_convos.open_convos, 0) AS open_convos,
       ISNULL(open_convos.setting_date_phone, 0) AS setting_date_phone,
       CASE
           WHEN ISNULL(rrate.TOTAL, 0.) = 0.
           THEN NULL
           ELSE ISNULL(rrate.OPP, 0.) / rrate.TOTAL
       END AS rrate,
       ISNULL(REPLACE(REPLACE(acc.[Running Out of ICs], CHAR(10), ''), CHAR(13), ''), '') AS [Running Out of ICs],
       ISNULL(acc.[Active?], 'No Data') AS [Active?]

--into [TRACK].[dbo].[REPORT_time_progress_by_client]
into ##tmp_new_REPORT_time_progress_by_client
FROM [TRACK].[dbo].[clients] a
     LEFT JOIN [TRACK].[dbo].[users] b ON a.[user_id] = b.[user_id]
     LEFT JOIN [TRACK].[dbo].[history] c ON a.client_id = c.client_id
     LEFT JOIN
(
    SELECT [client_id],
           SUM(DATEDIFF(mi, [start], [end])) / 60. AS [total_hours_logged]
    FROM [TRACK].[dbo].[trackings]
    GROUP BY [client_id]
) d ON a.client_id = d.client_id
     LEFT JOIN
(
    SELECT a.[client_id],
           a.[month_start_date],
           a.[total_hours_paid],
           a.[total_hours_credited],
           b.profile_upgrade,
           b.rebill_date,
           a.[months]
    FROM
    (
        SELECT [client_id],
               MAX([bill_date]) AS [month_start_date],
               SUM([hours] + hours_upsell) AS [total_hours_paid],
               SUM(hours_credited) AS [total_hours_credited],
               COUNT(*) AS [months]
        FROM [TRACK].[dbo].[bills]
        GROUP BY [client_id]
    ) a
    INNER JOIN [TRACK].[dbo].[bills] b ON a.client_id = b.client_id
                                          AND a.month_start_date = b.bill_date
) e ON a.client_id = e.client_id
     LEFT JOIN
(
    SELECT a.[client_id],
           SUM(a.[hours] + hours_upsell) AS [hours_purchased],
           SUM([hours]) AS [package_hours],
           SUM(a.hours_credited) AS [hours_credited],
           SUM(a.hours_deducted) AS [hours_deducted]
    FROM [TRACK].[dbo].[bills] a
         INNER JOIN
    (

	   SELECT client_id,
			bill_date [max_bill_date]
	   FROM
	   (
		  SELECT [client_id],
			    bills.bill_Date,
			    RANK() OVER(PARTITION BY [client_id],
								    PROFILE_UPGRADE ORDER BY [client_id],
													    [bill_date] DESC) AS xRank
		  FROM [TRACK].[dbo].[bills]
	   ) ti
	   WHERE xrank = 1

        --SELECT [client_id],
        --       MAX([bill_date]) AS [max_bill_date]
        --FROM [TRACK].[dbo].[bills]
        --GROUP BY [client_id]

    ) b ON a.client_id = b.client_id
           AND a.bill_date = b.max_bill_date
    GROUP BY a.[client_id]
) f ON a.client_id = f.client_id
     LEFT JOIN
(
    SELECT a.[client_id],
           SUM(DATEDIFF(mi, a.[start], a.[end])) / 60. AS [total_hours_logged]
    FROM [TRACK].[dbo].[trackings] a
         LEFT JOIN [TRACK].[dbo].history b ON a.client_id = b.client_id
         LEFT JOIN
    (
        SELECT [client_id],
               MAX([bill_date]) AS [max_bill_date]
        FROM [TRACK].[dbo].[bills]
        GROUP BY [client_id]
    ) c ON a.client_id = c.client_id
    WHERE a.[start] >= COALESCE(CASE
                                    WHEN COALESCE(b.[month_start_date], CONVERT( DATE, '1900-01-01', 121)) > COALESCE(c.[max_bill_date], CONVERT(DATE, '1900-01-01', 121))
                                    THEN b.[month_start_date]
                                    ELSE c.[max_bill_date]
                                END, CONVERT(DATE, '1900-01-01', 121))
    GROUP BY a.[client_id]
) g ON a.client_id = g.client_id
     LEFT JOIN
(
    SELECT [Client],
           SUM(CASE
                   WHEN [Stage] IN('Pursued Date But Got Number', 'Got Phone Number')
                   THEN [Quant]
                   ELSE 0
               END) AS [phones_hist],
           SUM(CASE
                   WHEN [Stage] = 'Date Completely Scheduled Online'
                   THEN [Quant]
                   ELSE 0
               END) AS [dates_hist]
    FROM [VIDA].[dbo].[closer_commission_client_view_include_null_comm_dates]
    GROUP BY [Client]
) AS phone_dates_hist ON a.name = phone_dates_hist.Client
     OUTER APPLY
(
    SELECT SUM(CASE
                   WHEN [Stage] IN('Pursued Date But Got Number', 'Got Phone Number')
                   THEN [Quant]
                   ELSE 0
               END) AS [phones],
           SUM(CASE
                   WHEN [Stage] = 'Date Completely Scheduled Online'
                   THEN [Quant]
                   ELSE 0
               END) AS [dates]
    FROM [VIDA].[dbo].[closer_commission_client_view_include_null_comm_dates]
    WHERE [Client] = a.name
          AND [Commission Date] >= e.month_start_date
) phone_dates_curr LEFT JOIN
(
    SELECT [Clients Name],
           MAX([Date / Number Preference]) AS [Date / Number Preference],
           MAX([Running Out of ICs]) AS [Running Out of ICs],
           MAX([Active?]) AS [Active?]
    FROM [VIDA].[dbo].[accounts]
    GROUP BY [Clients Name]
) acc ON a.name = acc.[Clients Name]
                   LEFT JOIN
(
    SELECT CASE
               WHEN CHARINDEX('#', accounts.[Clients Name]) = 0
               THEN UPPER(accounts.[Clients Name])
               ELSE UPPER(LEFT(accounts.[Clients Name], CHARINDEX('#', accounts.[Clients Name])-1))
           END AS [Client],
           SUM(CASE
                   WHEN opp.Stage = 'Email Received'
                   THEN 1
                   ELSE 0
               END) AS open_convos,
           SUM(CASE
                   WHEN opp.Stage = 'Currently Setting Date or Phone'
                   THEN 1
                   ELSE 0
               END) AS [setting_date_phone]
    FROM [VIDA].[dbo].[opportunities] opp
         INNER JOIN [VIDA].[dbo].[accounts] accounts ON opp.[Clients Id] = accounts.[Clients Id]
    WHERE opp.Stage IN('Email Received', 'Currently Setting Date or Phone')
    GROUP BY CASE
                 WHEN CHARINDEX('#', accounts.[Clients Name]) = 0
                 THEN UPPER(accounts.[Clients Name])
                 ELSE UPPER(LEFT(accounts.[Clients Name], CHARINDEX('#', accounts.[Clients Name])-1))
             END
) open_convos ON a.name = open_convos.Client
                   LEFT JOIN
(
    SELECT a.[Client],
           SUM(CASE
                   WHEN [Category] LIKE 'Opportunity'
                   THEN 1.
                   ELSE 0.
               END) AS OPP,
           SUM(a.QUANT) AS TOTAL
    FROM [VIDA].[dbo].[BASE] a
    WHERE a.[M1 Template] <> 'Missing'
          AND a.[M1 Date Sent] BETWEEN DATEADD(dd, -90,
                                              (
                                                  SELECT MAX([date])
                                                  FROM [VIDA].[dbo].[last_update]
                                              )) AND
    (
        SELECT MAX([date])
        FROM [VIDA].[dbo].[last_update]
    )
          AND (a.[mobile app] <> 'Yes'
               OR a.[mobile app] IS NULL)
    GROUP BY a.[Client]
) rrate ON a.name = rrate.Client
WHERE a.name <> 'None'
      --AND a.name LIKE '%amol%';
GO

/*
select *
from [REPORT_time_progress_by_client]    
    where client_name in ('Cedric Hurst','Amol Khade','John McNally')

select * from clients where client_id = 3028
 SELECT *
        FROM [TRACK].[dbo].[bills]
	   where client_id = 3028--2614--2968--2804--3028
--        GROUP BY [client_id]

select *
    from [history]
    where client_id = 3028

select top 100 *	
        FROM [TRACK].[dbo].[bills]
	   where
		  bill_date > '01/01/2018' 
		  and profile_upgrade = 1

    SELECT a.[client_id],
           SUM(a.[hours] + hours_upsell) AS [hours_purchased],
           SUM([hours]) AS [package_hours],
           SUM(a.hours_credited) AS [hours_credited],
           SUM(a.hours_deducted) AS [hours_deducted]
    FROM [TRACK].[dbo].[bills] a
         INNER JOIN
    (
	   SELECT client_id,
			bill_date [max_bill_date]
	   FROM
	   (
		  SELECT [client_id],
			    bills.bill_Date,
			    RANK() OVER(PARTITION BY [client_id],
								    PROFILE_UPGRADE ORDER BY [client_id],
													    [bill_date] DESC) AS xRank
		  FROM [TRACK].[dbo].[bills]
		  WHERE client_id IN(2614, 16, 2968)
	   ) ti
	   WHERE xrank = 1

	    --SELECT [client_id],
     --          MAX([bill_date]) AS [max_bill_date]
     --   FROM [TRACK].[dbo].[bills]
     --   GROUP BY [client_id]



    ) b ON a.client_id = b.client_id
           AND a.bill_date = b.max_bill_date
		 where a.client_id IN (2614,16, 2968)
    GROUP BY a.[client_id]
*/