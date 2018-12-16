USE track;
GO

/*
Bronze - Trevor Koverko
Bronze Plus - Reza Hedayati
Silver - Mike Hawk
Silver Plus - Peter Biedak
Gold - Roger Goble
Gold Plus - Jared Raia
Platinum - Sanjay Sahgal
Sapphire - no active client as of the moment
Diamond - Brian Acacio
Diamond Elite - Bryan Ciyou--> Amr Elborai

*/
SELECT *
FROM (
    SELECT Client,	
	   month [Month Period],
	   ROW_NUMBER() OVER (PARTITION BY Client ORDER BY month) [ROW_NUMBER],
	   [MatchMaker],
	   [Last Package Name] [Package Name],
		 [Last Package Hours] [Package Hours],
		 [AM / VA Team Lead Hs]	,[AM / VA Team Lead Amount],
		 [Closer Hours Hs], [Closer Hours Amount],
		 [AM / VA Other Hs], [AM / VA Other Amount],
		 [AM Sales Hs], [AM Sales Amount],
		 [Mobile App Hours Hs], [Mobile App Hours Amount],
		 [SMS/Texting Hs], [SMS/Texting Amount],
		 [Writing Team Lead Hs], [Writing Team Lead Amount],
		 [New Writer Training Hs], [New Writer Training Amount],
		 [Blogging Hs], [Blogging Amount],
		 [Gold+ Profiles Hs], [Gold+ Profiles Amount],
		 [Writing Other Hs], [Writing Other Amount],
		 [Day Off Online Dating Closing Hs], [Day Off Online Dating Closing Amount],
		 [Day Off Mobile App Hs], [Day Off Mobile App Amount],
		 [Profile Editing Hs], [Profile Editing Amount],
		 [SOP Updates Hs], [SOP Updates Amount],
		 [Asked For Date & Got Phone Number Amount], [Date Completely Scheduled Online Amount], [Got Phone Number Amount], [Commission],	[VA Commission Positives Amount], [VA Commission Negatives Amount]
		 ,[Total Hs Paid], [Total Amount Paid to Team Members], [Total Amount Paid by Client], [Balance]

    FROM payroll_client AS a
    WHERE([Last Package Name] NOT IN('Deposit', 'Other', 'Profile', 'Copper'))
    and (
    (Client = 'Trevor Koverko' and [last package name] = 'Bronze') 
    OR (Client = 'Reza Hedayati' and [last package name] = 'Bronze Plus')
    OR (Client = 'Mike Hawk' and [last package name] = 'Silver')
    OR (Client = 'Peter Biedak' and [last package name] = 'Silver Plus')
    OR (Client = 'Roger Goble' and [last package name] = 'Gold')
    OR (Client = 'Jared Raia' and [last package name] = 'Gold Plus')
    OR (Client = 'Sanjay Sahgal' and [last package name] = 'Platinum')
    OR (Client = 'Jorgen Lien' and [last package name] = 'Sapphire')
    OR (Client = 'Brian Acacio' and [last package name] = 'Diamond')
    OR (Client = 'Amr Elborai' and [last package name] = 'Diamond Elite')
    )
) T1
WHERE [ROW_NUMBER] = 1
order by [Package Hours],client, [Month Period]



	  t2.totalMonths,
       Client,
       [Client Active Now],
      -- sum([Total Hs Paid],
       sum([Total Amount Paid to Team Members]) [Total Amount Paid to Team Members],
       sum([Total Amount Paid by Client]) [Total Amount Paid by Client],
       sum(Balance) Balance,
       [Last Package Name],
       [Last Package Color],
       [Last Package Hours]
FROM payroll_client AS a
    cross apply( 
		  SELECT COUNT(*) totalMonths
		  FROM payroll_client 
		  WHERE client = a.client
		  ) t2
WHERE([Last Package Name] NOT IN('Deposit', 'Other', 'Profile', 'Copper'))
and Client = 'Trevor Koverko'
group by  Client,
       [Client Active Now],       
       [Last Package Name],
       [Last Package Color],
       [Last Package Hours] 
	  ,t2.totalMonths
