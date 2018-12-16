use vida 
go

-- Pivot table with one row and five columns  
SELECT PM_YN,  [Leads], [Opportunities]
    , cast((cast([Opportunities] as numeric)*100)/([Leads]+ [Opportunities]) as numeric(10,2)) ConversionRatePerc
FROM  
(SELECT [Source], PM_YN, [Count]
from(
select 'Opportunities' [Source], count(distinct op.[Opportunities ID]) [Count],
	   case when [Predictive Messaging Template Used] in ('1st Template Used','2nd Template Used')	 then 'PM_Y'
	   else 'PM_N' end PM_YN
    from opportunities op
    inner join accounts acct on acct.[Clients Id] = op.[Clients Id]
    inner join opportunities_stages hist on hist.[Opportunities ID] = op.[Opportunities ID]
    cross apply (select [Opportunities ID] from opportunities_stages
			  where [Opportunities ID] = op.[Opportunities ID] 
			  group by [Opportunities ID] having count(*)>=1) tcount
    where
	   op.[created time]>'2018-05-20 11:36:37.000'--'01-01-2018'
	   and op.[site] in ('Match','POF')
    group by
	   case when [Predictive Messaging Template Used] in ('1st Template Used','2nd Template Used')	 then 'PM_Y'
	   else 'PM_N' end 

union all
select 'Leads' [Source], count(distinct [Lead Id]) [Count],
	   case when [Predictive Messaging Template Used] in ('1st Template Used','2nd Template Used')	 then 'PM_Y'
	   else 'PM_N' end PM_YN
    from leads 
    where
	   [created time]>'2018-05-20 11:36:37.000'--'01-01-2018'
	   and [site] in ('Match','POF')
    group by
	   case when [Predictive Messaging Template Used] in ('1st Template Used','2nd Template Used')	 then 'PM_Y'
	   else 'PM_N' end 
	   ) t
) AS SourceTable  
PIVOT  
(  
SUM([Count])  
FOR [Source] IN ([Leads],[Opportunities])  
) AS PivotTable;  