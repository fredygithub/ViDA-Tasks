select *
    from [closer_monthly_quarterly_performance]
    where
	   closer = 'Arielle Lindsey'
	   and [Quarter] = '2018-2Q'
	   and [mobile app] = 'No'
	   order by 
		  [Month], [Site], [Stage]
