



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
Select 'reBecca B' Union 
Select 'Sara G' Union 
Select 'Sheri'    

DECLARE @tQualifiedContenders TABLE (name nvarchar(50))
Insert into @tQualifiedContenders
select DISTINCT [AM/Closer Name (who are you?)] ContendersList
    from PhotoFormResponses1 u
    right join @tContenders c on left(c.name,len(c.name)) like left(u.[AM/Closer Name (who are you?)],len(c.name))
	   where u.DiscardFromAnalysis is null
	   and u.RecordNumber = 1
	   and u.LessEvaluationPhotosThanExpected is null
    group by c.name, [AM/Closer Name (who are you?)]
    having count([AM/Closer Name (who are you?)])>20
    order by [AM/Closer Name (who are you?)]


--select * from PhotoFormResponses1 where DiscardFromAnalysis is null
--	   and RecordNumber = 1
--	   and LessEvaluationPhotosThanExpected is null
--	   order by [Client Name], [AM/Closer Name (who are you?)]


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
    from (select * from PhotoFormResponses1 t_int where t_int.DiscardFromAnalysis is null
			 and t_int.RecordNumber = 1
			 and t_int.LessEvaluationPhotosThanExpected is null 
		 ) s
	unpivot
    (
	 ranking
	 for photo in (J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z)
    ) u
    --where u.[Client Name] like '%adam%'
    --group by [Client Name], u.[AM/Closer Name (who are you?)]
) t
) t2 
--    SELECT * FROM @ClientRank WHERE rank_  = 1


declare @ClientRank1 table ([Client Name] nvarchar(50), RankPhoto nchar(1), Median decimal(10,2), Variance decimal(10,2), rank_ int)
insert into @ClientRank1
SELECT * FROM @ClientRank WHERE rank_  = 1

--select * from @ClientRank1

--SELECT *
--FROM
--(
--    select u.[Client Name], [AM/Closer Name (who are you?)] [Contender], u.Photo, u.Ranking
--	   from (select * from PhotoFormResponses1 t_int where t_int.DiscardFromAnalysis is null
--			 and t_int.RecordNumber = 1
--			 and t_int.LessEvaluationPhotosThanExpected is null 
--		 ) s
--	   unpivot
--	   (
--		ranking
--		for photo in (J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z)
--	   ) u
--	   --where u.[AM/Closer Name (who are you?)] in ('Nova Johnstone','Jasmine Vo')
--) tcontenders
--INNER JOIN 
--    @ClientRank1 cr on cr.[Client Name] = tcontenders.[Client Name]
--    and cr.RankPhoto = tcontenders.photo
--    INNER JOIN @tQualifiedContenders c on c.name = tcontenders.Contender
--ORDER BY cr.[Client Name] , Contender


SELECT tcontenders.Contender, count(*) EvaluationsCount 
    , sum( abs(tcontenders.ranking-cr.rank_)) SumError
    , round(sum( abs(tcontenders.ranking-cr.rank_)) /count(*) ,2)  [Mean Absolute Deviation]
    , sum(case when tcontenders.ranking=cr.rank_ then 1 else 0 end) Rank1Matches
FROM
(
    select u.[Client Name], [AM/Closer Name (who are you?)] [Contender], u.Photo, u.Ranking
	   from (select * from PhotoFormResponses1 t_int where t_int.DiscardFromAnalysis is null
			 and t_int.RecordNumber = 1
			 and t_int.LessEvaluationPhotosThanExpected is null 
		 ) s
	   unpivot
	   (
		ranking
		for photo in (J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z)
	   ) u
	   --where u.[AM/Closer Name (who are you?)] = 'Allison'
) tcontenders
INNER JOIN 
    @ClientRank1 cr on cr.[Client Name] = tcontenders.[Client Name]
    and cr.RankPhoto = tcontenders.photo
    INNER JOIN @tQualifiedContenders c on c.name = tcontenders.Contender
group by tcontenders.Contender
ORDER BY sum( abs(tcontenders.ranking-cr.rank_)) /count(*)  asc
