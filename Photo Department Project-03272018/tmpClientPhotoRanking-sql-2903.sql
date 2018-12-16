use master
go

select top  100 *--count(*)
    from PhotoFormResponses1
    order by [Client Name]

-- drop table ['PhotoFormResponses1']

--select distinct [AM/Closer Name (who are you?)]--count(distinct [Client Name])
--    from PhotoFormResponses1
--    where 
--	   J is not null and k is not null and l is not null and m is not null and n is not null and o is not null and p is not null
--	   and q is not null and r is not null and s is not null and t is not null and u is not null 
--	   and v is null and i is null
--    and timeStamp >= '01/01/2017'
--    order by Timestamp desc

--create table #tmpClientPhotoRanking ([Client Name] nvarchar(100), )




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
Select 'Jaclyn' Union 
Select 'Jasmine' Union 
Select 'Jessica' Union 
Select 'Lorena' Union 
Select 'Lynsi' Union 
Select 'Nova' Union 
Select 'Olivia' Union 
Select 'Onawa ' Union 
Select 'Rachel G' Union 
Select 'reBecca' Union 
Select 'reBecca' Union 
Select 'Rebecca T' Union 
Select 'Sara ' Union 
Select 'Sheri'  
  

--SELECT * FROM @tContenders

select c.name as [Provided Contenders List], count(*)
    from @tContenders c	   
	   left join PhotoFormResponses1 u on left(c.name,len(c.name)) like left(u.[AM/Closer Name (who are you?)],len(c.name))
    Group by
	   c.name
	   
	     


