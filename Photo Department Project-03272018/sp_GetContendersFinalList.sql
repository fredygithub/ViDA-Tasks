CREATE PROCEDURE sp_GetContendersFinalList
AS
/*
30/03/2018
Update Contenders to unify names.

08/04/2018
Updated contenders list Changed reBecca to "reBecca B"
Updated contenders list Changed Sara to "Sara G"
Added
	   where u.DiscardFromAnalysis is null
			 and u.RecordNumber = 1
			 and u.LessEvaluationPhotosThanExpected is null
*/


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
Select 'Jessica C' Union 
Select 'Lorena' Union 
Select 'Lynsi' Union 
Select 'Nova' Union 
Select 'Olivia' Union 
Select 'Onawa ' Union 
Select 'Rachel G' Union 
Select 'reBecca B' Union 
Select 'Sara G' Union 
Select 'Sheri'  


select DISTINCT [AM/Closer Name (who are you?)] ContendersList, count([AM/Closer Name (who are you?)])
    from @tContenders c
    left join PhotoFormResponses1 u on left(c.name,len(c.name)) like left(u.[AM/Closer Name (who are you?)],len(c.name))
	   where u.DiscardFromAnalysis is null
	   and u.RecordNumber = 1
	   and u.LessEvaluationPhotosThanExpected is null
    group by c.name, [AM/Closer Name (who are you?)]
    having count([AM/Closer Name (who are you?)])>20
    order by [AM/Closer Name (who are you?)]

