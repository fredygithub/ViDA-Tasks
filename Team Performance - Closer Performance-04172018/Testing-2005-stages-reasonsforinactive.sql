USE TRACK
GO
/*
SELECT 
[Closer],
[Stage],
[Site],
convert(float, [Quant]) as Quant,
[Hours],
[OEs],
[OEs_Hours]
FROM [VIDA].[dbo].[closer_monthly_quarterly_performance]
where active ='YES'--(active = @ACTIVE or @ACTIVE = 'ALL') 
and [quarter] = @QUARTER
and [Mobile App] in (@mobile)


SELECT Stage, count(*) FROM VIDA.DBO.closer_monthly_quarterly_performance 
    group by Stage
    WHERE Stage = 'Client Inactive'--closer = 'Connor Moran'
	   
select top 100 *
from [VIDA].[dbo].[opportunities] 
where stage = 'Client Inactive'
    order by [closing date] desc

select top 10 *
from vida.dbo.accounts 
where [clients id] = 'zcrm_200867000042571326'

select [reason for cancellation], count(*)
from vida.dbo.accounts 
    group by [reason for cancellation]

select top 50 [reason for cancellation], *
from vida.dbo.accounts 
    where [reason for cancellation] is not null
	   and active = 'no'

where [clients id] = 'zcrm_200867000042571326'
*/

    SELECT a.[Created Time], a.[Closed Time] 
		  , DATEDIFF(minute,a.[Created Time], a.[Closed Time]) [MinutesToClose]--/60 [HoursTime]
		  --,DATEDIFF(minute,a.[Created Time], a.[Closed Time])%60 [mod]
		  --,DATEDIFF(minute,a.[Created Time], a.[Closed Time])/60 + DATEDIFF(minute,a.[Created Time], a.[Closed Time])%60 
		  , a.*
    --, b.* --CONVERT( VARCHAR(4), YEAR(a.[Modified Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Modified Time])), 2) AS [Month],
           --REPLACE(REPLACE(a.Closer, CHAR(13), ''), CHAR(10), '') AS Closer,
           --COUNT(*) * 1. AS oes_hours
		 
    FROM [VIDA].[dbo].[tasks] a
         INNER JOIN [VIDA].[dbo].[opportunities] b ON a.[Related To] = b.[Opportunities Id]
         INNER JOIN VIDA.dbo.sites c ON REPLACE(REPLACE(b.[Site], CHAR(13), ''), CHAR(10), '') = c.origin
    WHERE a.[Related To] IS NOT NULL
          AND a.Closer IS NOT NULL
          AND REPLACE(REPLACE(a.Closer, CHAR(13), ''), CHAR(10), '') <> ''
          AND a.[Type] LIKE '%Outbound Email%'
          AND c.[Site] <> 'eHarmony'
	     AND CONVERT( VARCHAR(4), YEAR(a.[Modified Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Modified Time])), 2) = '2018-04'
		AND a.closer = 'Alberto Orozco'
		AND a.[Site] is not null--[Date Sent] is null
		AND a.[created time] between '03/01/2018' and '04/01/2018'
		--AND a.[Modified Time] between '03/01/2018' and '04/01/2018'
    --GROUP BY CONVERT( VARCHAR(4), YEAR(a.[Modified Time]))+'-'+RIGHT('0'+CONVERT(VARCHAR, MONTH(a.[Modified Time])), 2),a.Closer


