



declare @ClientRank table ([Client Name] nvarchar(50), RankPhoto nchar(1), Median decimal(10,2), Variance decimal(10,2), rank_ int)
insert into @ClientRank
select *
   ,rank()  over(partition by [Client Name] order by Median, Variance desc ) as rank_
FROM (

select distinct [Client Name], photo, --avg(ranking), count(*) cnt
    PERCENTILE_CONT(0.5) 
                   WITHIN GROUP (ORDER BY ranking) 
                   OVER (partition BY [Client Name], photo) AS Median
    ,var(ranking) over(partition by [Client Name], photo) as Variance
from 
(
    select u.[Client Name], [AM/Closer Name (who are you?)], u.photo, u.ranking
    from PhotoFormResponses1 s
    unpivot
    (
	 ranking
	 for photo in (J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z)
    ) u
    --where u.[Client Name] like '%adam%'
    --group by [Client Name], u.[AM/Closer Name (who are you?)]
) t

) t2 

    
    SELECT * FROM @ClientRank WHERE rank_  = 1



DECLARE @tContenders TABLE (name nvarchar(50))
Insert into @tContenders
Select 'Allison' Union 
Select 'Amy' Union 
Select 'Ana' Union 
Select 'Andrea' Union 
Select 'Arielle' Union 
Select 'Bonnie' Union 
Select 'Brianne' Union 
Select 'Ellie' Union 
Select 'Jac' Union 
Select 'Jasmine' Union 
Select 'Jessica' Union 
Select 'Lorena' Union 
Select 'Lynsi' Union 
Select 'Nova' Union 
Select 'Olivia' Union 
Select 'Onawa ' Union 
Select 'Rachel G' Union 
Select 'reBecca' Union 
Select 'Sara ' Union 
Select 'Sheri'  



SELECT --cr.[Client Name], [Contender], Photo, Ranking
    
    [Contender], COUNT(*) [Total Rank1], count_Clients as [Over Total Clients]
FROM
(
    select u.[Client Name], [AM/Closer Name (who are you?)] [Contender], u.Photo, u.Ranking
	   from PhotoFormResponses1 s
	   unpivot
	   (
		ranking
		for photo in (J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z)
	   ) u
	   where 
		  --u.[Client Name] like '%adam%' and 
		  ranking = 1
) tcontenders
INNER JOIN 
    @ClientRank cr on cr.[Client Name] = tcontenders.[Client Name]
    and cr.RankPhoto = tcontenders.photo
    INNER JOIN @tContenders c on c.name = tcontenders.Contender
inner join (
	   select [AM/Closer Name (who are you?)], count(*) count_Clients
	   from PhotoFormResponses1
	   group by [AM/Closer Name (who are you?)]
) b on b.[AM/Closer Name (who are you?)] = tcontenders.Contender
    where rank_ = 1
--ORDER BY [Client Name], Contender
GROUP BY Contender, count_Clients
ORDER BY [Total Rank1] DESC, Contender











