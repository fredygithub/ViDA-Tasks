/*
30/03/2018
Update Contenders to unify names.

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

--select *
--    from PhotoFormResponses1 
--    where [AM/Closer Name (who are you?)] like '%jac%'

select c.name as [Provided Contenders List], isnull([AM/Closer Name (who are you?)],'No PhotoRanking form'), count([AM/Closer Name (who are you?)])
    from PhotoFormResponses1 u
    right join @tContenders c on left(c.name,len(c.name)) like left(u.[AM/Closer Name (who are you?)],len(c.name))
    group by c.name, [AM/Closer Name (who are you?)]
    having count([AM/Closer Name (who are you?)])>20
    order by [AM/Closer Name (who are you?)]

--update PhotoFormResponses1 set [AM/Closer Name (who are you?)] = 'Amy Mooney' where [AM/Closer Name (who are you?)] in ('Amy','Amy Mooney')
--update PhotoFormResponses1 set [AM/Closer Name (who are you?)] = 'Andrea Hounsell' where [AM/Closer Name (who are you?)] in ('Andrea Hounsell','Andrea Hounsell1')
--update PhotoFormResponses1 set [AM/Closer Name (who are you?)] = 'Bonnie Lamer' where [AM/Closer Name (who are you?)] in ('Bonnie','Bonnie L','Bonnie Lamer')
--update PhotoFormResponses1 set [AM/Closer Name (who are you?)] = 'Brianne Castro' where [AM/Closer Name (who are you?)] in ('Brianne','Brianne Castro')
--update PhotoFormResponses1 set [AM/Closer Name (who are you?)] = 'Rebecca Brown' where [AM/Closer Name (who are you?)] in ('Rebecca','Rebecca Brown')
--update PhotoFormResponses1 set [AM/Closer Name (who are you?)] = 'Jaclyn Higgins' where [AM/Closer Name (who are you?)] in ('Jacki','Jacki Higgins')

--update PhotoFormResponses1 set [AM/Closer Name (who are you?)] = Ltrim(Rtrim([AM/Closer Name (who are you?)]))
--update PhotoFormResponses1 set [Client Name] = Ltrim(Rtrim([Client Name]))

