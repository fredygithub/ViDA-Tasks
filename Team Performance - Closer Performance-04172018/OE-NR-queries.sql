select [Date / Number Preference], count(*)
from Vida.dbo.accounts
    group by [Date / Number Preference]
   
select Type, COUNT(*) Count
FROM VIDA.dbo.tasks
    WHERE [Related To] IS NOT NULL
          AND Type LIKE '%nr%'
          AND Subject  LIKE '%nr-%'
		group by Type
		order by COUNT(*) desc
select Type, COUNT(*) Count
FROM VIDA.dbo.tasks
    WHERE [Related To] IS NOT NULL
          AND Type LIKE '%nr%'
          --AND Subject  LIKE '%nr-%'
		and REPLACE(Subject,' ','') LIKE '%nr-%'
		and closer <> 'N/A'
		group by Type
		order by COUNT(*) desc

select Type, COUNT(*) Count
FROM VIDA.dbo.tasks
    WHERE [Related To] IS NOT NULL
          AND Type LIKE '%nr%'
          AND Subject  LIKE '%nr-%'
		and closer <> 'N/A'
		group by Type
		order by COUNT(*) desc

Outbound Email-Nonresponsive	23219
Outbound Email-Nonresponsive 2	324

		
select *
FROM VIDA.dbo.tasks
    WHERE [Related To] IS NOT NULL
          AND Type LIKE '%nr%'
          AND Subject not LIKE '%nr-%'
		--and [task id] = 'zcrm_200867000054440015'
		and REPLACE(Subject,' ','') LIKE '%nr-%' --> 'NR - Lady' cases
		and closer <> 'N/A'
		AND TYPE = 'Outbound Email-Dating Site'


select Type, COUNT(*) Count
FROM VIDA.dbo.tasks
    WHERE [Related To] IS NOT NULL
          --AND Type LIKE '%nr%'
          AND Type LIKE '%Outbound Email%'
		--AND Type NOT LIKE '%nr%'
		and REPLACE(Subject,' ','') not LIKE '%nr-%'
		group by Type
		order by COUNT(*) desc

select *
FROM VIDA.dbo.tasks
    WHERE [Related To] IS NOT NULL
		and REPLACE(Subject,' ','') not LIKE '%nr-%'
		AND TYPE = 'Outbound Email-Nonresponsive'




		-- Outbound Email-Asking for the Date  NR-MauiLola


SELECT [Type], COUNT(*) Count
FROM VIDA.dbo.tasks
    WHERE [Related To] IS NOT NULL
          --AND [Type] LIKE '%nr%'
          AND [Type] LIKE '%Outbound Email%'
		AND [Type] NOT LIKE '%nr%'
		--and REPLACE(Subject,' ','') not LIKE '%nr-%'
		group by [Type]
		order by COUNT(*) desc
