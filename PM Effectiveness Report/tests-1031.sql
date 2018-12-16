use vida 
go

select count(distinct op.[Opportunities ID]),
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
    group by
	   case when [Predictive Messaging Template Used] in ('1st Template Used','2nd Template Used')	 then 'PM_Y'
	   else 'PM_N' end 


select count(distinct [Lead Id]),
	   case when [Predictive Messaging Template Used] in ('1st Template Used','2nd Template Used')	 then 'PM_Y'
	   else 'PM_N' end PM_YN
    from leads 
    where
	   [created time]>'2018-05-20 11:36:37.000'--'01-01-2018'
    group by
	   case when [Predictive Messaging Template Used] in ('1st Template Used','2nd Template Used')	 then 'PM_Y'
	   else 'PM_N' end 


select top 100 * from opportunities
    where 
	   [Predictive Messaging Template Used] in ('1st Template Used','2nd Template Used')	   
	   and op.[stage] = 'Closed - Negative Response IE'

select top 100 *--count(distinct op.[Opportunities ID])--top 100 *
    from opportunities op
    inner join accounts acct on acct.[Clients Id] = op.[Clients Id]
    where 
	   [Predictive Messaging Template Used] in ('1st Template Used','2nd Template Used')	
	   order by op.[Created Time] desc   
	   and op.[stage] = 'Closed - Negative Response IE'

select count(distinct op.[Opportunities ID])--top 100 *
    from opportunities op
    inner join accounts acct on acct.[Clients Id] = op.[Clients Id]
    where 
	   op.[stage] = 'Closed - Negative Response IE'


select op.[stage], count(*) cnt
    from opportunities op
    inner join accounts acct on acct.[Clients Id] = op.[Clients Id]
    where 
	   op.[stage] not like '%sales%'
	 --  [Predictive Messaging Template Used] in ('1st Template Used','2nd Template Used')	   
    group by op.[stage]
    order by op.[stage]

select [lead status], [response], count(*) cnt
    from leads
--    inner join accounts acct on acct.[Clients Id] = leads.[Clients Id]
    where 
    [Predictive Messaging Template Used]  in ('1st Template Used','2nd Template Used')	   
    group by [lead status], [response]
    order by [lead status], [response]

select [response], count(*) cnt
    from leads
--    inner join accounts acct on acct.[Clients Id] = leads.[Clients Id]
    where 
    [Predictive Messaging Template Used]  in ('1st Template Used','2nd Template Used')	   
    group by [response]
    order by [response]

    select top 100 *
    from leads
     where 
    --[Predictive Messaging Template Used]  in ('1st Template Used','2nd Template Used') and
    [lead status] = 'M2 Sent'
