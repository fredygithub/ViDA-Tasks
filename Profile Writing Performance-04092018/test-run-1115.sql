    select [lead status], response, count(*)
    from leads 
    where
	   [created time]>'2018-05-20 11:36:37.000'--'01-01-2018'
	   and [site] in ('Match','POF')
	   and [Predictive Messaging Template Used] in ('1st Template Used','2nd Template Used')	
    group by [lead status], response


    select *
    from leads 
    where
	   [created time]>'2018-05-20 11:36:37.000'--'01-01-2018'
	   and [site] in ('Match','POF')
	   and [Predictive Messaging Template Used] in ('1st Template Used','2nd Template Used')	
	   --and Response in ('Positive-M1', 'Positive-M2')
	   and Response in ('Negative-M1', 'Negative-M2')

    select count(*)
    from leads 
    where
	   [created time]>'2018-05-20 11:36:37.000'--'01-01-2018'
	   and [site] in ('Match','POF')
	   and [Predictive Messaging Template Used] in ('1st Template Used','2nd Template Used')	
	   and (
		   (Response is null and [lead status] ='M2 Sent - Unresponsive')
		   OR (Response in ('Negative-M1', 'Negative-M2'))
		   )

    select *
    from leads 
    where
	   [created time]>'2018-05-20 11:36:37.000'--'01-01-2018'
	   and [site] in ('Match','POF')
	   and [Predictive Messaging Template Used] in ('2nd Template Used')	
	   and Response = 'Negative-M1'



    select top 100 *
    from leads 
    where
	   [created time]>'2018-05-20 11:36:37.000'--'01-01-2018'
	   and [site] in ('Match','POF')
	   and [Predictive Messaging Template Used] = '2nd Template Used'
	   and Response is null
