

alter table PhotoFormResponses1 add DiscardFromAnalysis bit default(0)
select *
    from PhotoFormResponses1
    where
	   [Client Name] like '%gus%'

--> 1-Eliminate from analysis - Discard
UPDATE PhotoFormResponses1 set DiscardFromAnalysis = 1 where [Client Name] = 'Allison'
UPDATE PhotoFormResponses1 set DiscardFromAnalysis = 1 where [Client Name] = 'Bonnie'
UPDATE PhotoFormResponses1 set DiscardFromAnalysis = 1 where [Client Name] = 'Konrad Kalkurst'
UPDATE PhotoFormResponses1 set DiscardFromAnalysis = 1 where [Client Name] = 'Kristin Bell?'
UPDATE PhotoFormResponses1 set DiscardFromAnalysis = 1 where [Client Name] = 'KRISTIN HARRIS TEST'
UPDATE PhotoFormResponses1 set DiscardFromAnalysis = 1 where [Client Name] = 'Lynsi Williams'
UPDATE PhotoFormResponses1 set DiscardFromAnalysis = 1 where [Client Name] = 'Meagan'
UPDATE PhotoFormResponses1 set DiscardFromAnalysis = 1 where [Client Name] = 'Meagan Kaufman'
UPDATE PhotoFormResponses1 set DiscardFromAnalysis = 1 where [Client Name] = 'Meagan Project'
UPDATE PhotoFormResponses1 set DiscardFromAnalysis = 1 where [Client Name] = 'Megan Project'
UPDATE PhotoFormResponses1 set DiscardFromAnalysis = 1 where [Client Name] = 'Merrit Quirk'
UPDATE PhotoFormResponses1 set DiscardFromAnalysis = 1 where [Client Name] = 'Merritt Quick'
UPDATE PhotoFormResponses1 set DiscardFromAnalysis = 1 where [Client Name] = 'Merritt Quirk'

--> 3-Clients with dupplicate evaluation record - Need to eliminate one
select [Client Name], [Email of photo analyst who requested ranking],	[AM/Closer Name (who are you?)],	[A],	[B],	[C],	[D],	[E],	[F],	[G],	[H],	[I],	J,	K,	L,	M,	N,	O,	P,	Q,	R,	S,	T,	U,	V,	W,	X,	Y,	Z
	   , count(*) cntRecords, ROW_NUMBER() OVER(PARTITION BY [Client Name], [AM/Closer Name (who are you?)] ORDER BY [Client Name], [AM/Closer Name (who are you?)] ASC)  AS RowNum
    from PhotoFormResponses1
    group by
    [Client Name], [Email of photo analyst who requested ranking],	[AM/Closer Name (who are you?)],	[A],	[B],	[C],	[D],	[E],	[F],	[G],	[H],	[I],	J,	K,	L,	M,	N,	O,	P,	Q,	R,	S,	T,	U,	V,	W,	X,	Y,	Z
    having count(*)>1


alter table PhotoFormResponses1 add RecordNumber tinyint 
;WITH cteDuplicate AS
(
    select [Client Name], [Email of photo analyst who requested ranking],	[AM/Closer Name (who are you?)],	[A],	[B],	[C],	[D],	[E],	[F],	[G],	[H],	[I],	J,	K,	L,	M,	N,	O,	P,	Q,	R,	S,	T,	U,	V,	W,	X,	Y,	Z
	 , ROW_NUMBER() OVER(PARTITION BY [Client Name], [AM/Closer Name (who are you?)] ORDER BY [Client Name], [AM/Closer Name (who are you?)] ASC)  AS RowNum
	 , RecordNumber
    from PhotoFormResponses1
    where 
	   ([Client Name] = 'Gus Jursch' and [AM/Closer Name (who are you?)] = 'Allison')
	   or ([Client Name] = 'Mani Aleyas' and [AM/Closer Name (who are you?)] = 'Arielle Lindsey')
	   or ([Client Name] = 'Paul Hotaling' and [AM/Closer Name (who are you?)] = 'Rebecca Brown')
)

UPDATE cteDuplicate 
SET RecordNumber =2
WHERE RowNum=2
--update PhotoFormResponses1 set RecordNumber = 1
--select * from PhotoFormResponses1 where RecordNumber = 2

--> 4-Clients with dupplicate evaluation record - Need to eliminate one (WILL MARK SECOND ONE TO BE DISMISS)
;WITH cte_Duplicate_OR_PostEvaluation AS
(
    select [Client Name], [AM/Closer Name (who are you?)], Timestamp,	[A],	[B],	[C],	[D],	[E],	[F],	[G],	[H],	[I],	J,	K,	L,	M,	N,	O,	P,	Q,	R,	S,	T,	U,	V,	W,	X,	Y,	Z
	 , ROW_NUMBER() OVER(PARTITION BY [Client Name], [AM/Closer Name (who are you?)] ORDER BY [Client Name], [AM/Closer Name (who are you?)] ASC, TimeStamp ASC)  AS RowNum
	 , RecordNumber
    from PhotoFormResponses1
)

UPDATE cte_Duplicate_OR_PostEvaluation 
SET RecordNumber =2
WHERE RowNum=2

select * from PhotoFormResponses1 where RecordNumber = 2 order by [Client Name], [AM/Closer Name (who are you?)]

select * from PhotoFormResponses1 where [Client Name] like '%Anthony Navarini%'

--> 5-Contenders with less evaluation photos than expected
-->   

alter table PhotoFormResponses1 add LessEvaluationPhotosThanExpected bit 

create table PhotoFormResponses1_Client_FirstEvaluationPhotoNumber([Client Name] nvarchar(100), FirstEvaluation datetime, FirstEvaluationPhotoNumber tinyint)
--drop table PhotoFormResponses1_Client_FirstEvaluationPhotoNumber

Insert into PhotoFormResponses1_Client_FirstEvaluationPhotoNumber
 select  DISTINCT t1.[Client Name], t_inside.FirstEvaluation, TotalEvaluatedPhotos--, t2.newcolumn, min(t2.newcolumn), max(t2.newcolumn)--min(t1.Timestamp) FirstEvaluation --max(t2.newcolumn ) TotalEvaluatedPhotos
	   from PhotoFormResponses1 t1
		  cross apply(select t_in.[Client Name], min(Timestamp) FirstEvaluation 
				    from PhotoFormResponses1 t_in 
				    where t_in.[Client Name] =  t1.[Client Name]
				    group by t_in.[Client Name]
				    ) t_inside	   
    inner join 
	   (
	   select  t.*,    
		  (
		  select count(*)
		  from (values (T.a), (T.b), (T.c), (T.d), (T.e), (T.f), (T.g), (T.h), (T.i), (T.j), (T.k), (T.l), (T.m), (T.n), (T.o)
			 , (T.p), (T.q), (T.r), (T.s), (T.t), (T.u), (T.v), (T.w), (T.x), (T.y), (T.z)) as v(col)
		  where v.col is not null
		  ) as TotalEvaluatedPhotos
		  from PhotoFormResponses1 t
		  where RecordNumber = 1
	   		  --and [Client Name] = 'Paul Hotaling'
			  and t.DiscardFromAnalysis is null
	   		  --where [Client Name] = 'Brian Acacio'
	   ) t2 
	   on t2.[Client Name] = t1.[Client Name] 
	   and t1.[AM/Closer Name (who are you?)] = t2.[AM/Closer Name (who are you?)]
	   and t2.timestamp = t_inside.FirstEvaluation
	   and t1.DiscardFromAnalysis is null
	   and t1.RecordNumber = 1


--select * from PhotoFormResponses1_Client_FirstEvaluationPhotoNumber

--create table PhotoFormResponses1_Evaluator_FirstEvaluationPhotoNumber([Client Name] nvarchar(100), [AM/Closer Name (who are you?)] nvarchar(100), FirstEvaluation datetime, FirstEvaluationPhotoNumber tinyint)
----drop table PhotoFormResponses1_Evaluator_FirstEvaluationPhotoNumber

--insert into PhotoFormResponses1_Evaluator_FirstEvaluationPhotoNumber
  select  t1.[Client Name], t1.[AM/Closer Name (who are you?)], t1.timestamp , t2.contenderEvaluatedPhotos 
  --update t1
	 --  set t1.LessEvaluationPhotosThanExpected = 1
	   from PhotoFormResponses1 t1
	   inner join PhotoFormResponses1_Client_FirstEvaluationPhotoNumber cc on cc.[Client Name] = t1.[Client Name] 
    inner join 
	   (
	   select  t.*,    
		  (
		  select count(*)
		  from (values (T.a), (T.b), (T.c), (T.d), (T.e), (T.f), (T.g), (T.h), (T.i), (T.j), (T.k), (T.l), (T.m), (T.n), (T.o)
			 , (T.p), (T.q), (T.r), (T.s), (T.t), (T.u), (T.v), (T.w), (T.x), (T.y), (T.z)) as v(col)
		  where v.col is not null
		  ) as contenderEvaluatedPhotos
		  from PhotoFormResponses1 t
		  where RecordNumber = 1
	   		  --and [Client Name] = 'Paul Hotaling'
			  and t.DiscardFromAnalysis is null
	   ) t2 on t2.timestamp = t1.timestamp 
	   and t2.[Client Name] = t1.[Client Name] 
	   and t1.[AM/Closer Name (who are you?)] = t2.[AM/Closer Name (who are you?)]
	   and t1.RecordNumber = 1
	   and t1.DiscardFromAnalysis is null

	   where cc.FirstEvaluationPhotoNumber <> t2.contenderEvaluatedPhotos

--select * from PhotoFormResponses1_Evaluator_FirstEvaluationPhotoNumber order by [Client Name], [AM/Closer Name (who are you?)], FirstEvaluation



select *
from PhotoFormResponses1_Client_FirstEvaluationPhotoNumber cc
inner join PhotoFormResponses1_Evaluator_FirstEvaluationPhotoNumber tt on tt.[Client Name] = cc.[Client Name]    
	   where tt.FirstEvaluationPhotoNumber <> cc.FirstEvaluationPhotoNumber

	   order by tt.[Client Name], tt.[AM/Closer Name (who are you?)]

--	   select [Client Name], [AM/Closer Name (who are you?)], COUNT(*) from  PhotoFormResponses1
--		  group by [Client Name], [AM/Closer Name (who are you?)]		  
--		  having count(*)>1
--		  order by [Client Name], [AM/Closer Name (who are you?)]





--> 2-Update client names - Unify
UPDATE PhotoFormResponses1 set [Client Name] = 'Andy Bose' where [Client Name] = 'Andrew Bose'
UPDATE PhotoFormResponses1 set [Client Name] = 'Brian Prout' where [Client Name] = 'Biran Prout'
UPDATE PhotoFormResponses1 set [Client Name] = 'Brett Maugeri' where [Client Name] = 'Brett Maugari'
UPDATE PhotoFormResponses1 set [Client Name] = 'Chandra Shaker' where [Client Name] = 'Chandra Shaker (Maddula)'
UPDATE PhotoFormResponses1 set [Client Name] = 'Chandra Shaker' where [Client Name] = 'Chandra Shakermi'
UPDATE PhotoFormResponses1 set [Client Name] = 'Chris Jackson' where [Client Name] = 'Chris Jacksin'
UPDATE PhotoFormResponses1 set [Client Name] = 'Daniel Kushkuley' where [Client Name] = 'Dan Kushkuley'
UPDATE PhotoFormResponses1 set [Client Name] = 'Fred Heeren' where [Client Name] = 'Fred Heeran'
UPDATE PhotoFormResponses1 set [Client Name] = 'James Spence' where [Client Name] = 'James Spencer'
UPDATE PhotoFormResponses1 set [Client Name] = 'Katie Shepherd' where [Client Name] = 'Katie Shephard'
UPDATE PhotoFormResponses1 set [Client Name] = 'Kiplagat Birgen' where [Client Name] = 'Kip Birgen'
UPDATE PhotoFormResponses1 set [Client Name] = 'Kurt Mueller' where [Client Name] = 	'Kurt Mueller k'
UPDATE PhotoFormResponses1 set [Client Name] = 'Lara Koslow' where [Client Name] = 	'Laura Koslow'
UPDATE PhotoFormResponses1 set [Client Name] = 'Mark Rubinshtein' where [Client Name] = 	'Mark Rubenstein'
UPDATE PhotoFormResponses1 set [Client Name] = 'Marko Strinic' where [Client Name] = 	'Mark Strinic'
UPDATE PhotoFormResponses1 set [Client Name] = 'Matt Terlop' where [Client Name] = 	'Matt Terlp'
UPDATE PhotoFormResponses1 set [Client Name] = 'Michael Talbot' where [Client Name] = 	'Michaek Talbot'
UPDATE PhotoFormResponses1 set [Client Name] = 'Mike Housman' where [Client Name] = 	'Michael Housman'
UPDATE PhotoFormResponses1 set [Client Name] = 'Michael Schiff' where [Client Name] = 	'Micheal Schiff'
UPDATE PhotoFormResponses1 set [Client Name] = 'Mouni Reddy' where [Client Name] = 	'Mouni Reddi'
UPDATE PhotoFormResponses1 set [Client Name] = 'Paul Herrmann' where [Client Name] = 	'Paul Hermann'
UPDATE PhotoFormResponses1 set [Client Name] = 'Rochelle Weinstock' where [Client Name] = 	'Rachel Weinstock'
UPDATE PhotoFormResponses1 set [Client Name] = 'Robert Ronchi' where [Client Name] = 	'Robert Rinchi'
UPDATE PhotoFormResponses1 set [Client Name] = 'Ryan Hendrix' where [Client Name] = 	'Ryan Hendix'
UPDATE PhotoFormResponses1 set [Client Name] = 'Steve Holliday' where [Client Name] = 	'Steve Halliday'
UPDATE PhotoFormResponses1 set [Client Name] = 'Tallal Mirza' where [Client Name] = 	'Talia Mirza'
UPDATE PhotoFormResponses1 set [Client Name] = 'Tanmay Rajpathak' where [Client Name] = 	'Tanmay Rajpathank'
UPDATE PhotoFormResponses1 set [Client Name] = 'Teddy Woodward' where [Client Name] = 	'Theodore (Teddy) Woodward'
UPDATE PhotoFormResponses1 set [Client Name] = 'Teddy Woodward' where [Client Name] = 	'Theodore Woodward'
UPDATE PhotoFormResponses1 set [Client Name] = 'Vince Campbell' where [Client Name] = 	'Vance Campbell'



