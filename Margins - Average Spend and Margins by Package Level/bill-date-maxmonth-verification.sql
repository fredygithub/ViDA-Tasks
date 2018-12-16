declare @t1_month table (_id int identity, _month varchar(23), _date datetime)
insert into @t1_month(_date)
select '01/01/2017' union
select '02/01/2017' union
select '03/01/2017' union
select '04/01/2017' union
select '05/01/2017' union
select '06/01/2017' union
select '07/01/2017' union
select '08/01/2017' union
select '09/01/2017' union
select '10/01/2017' union
select '11/01/2017' union
select '12/01/2017' union
select '01/01/2018' union
select '02/01/2018' union
select '03/01/2018'

update @t1_month set _month = format(_date, 'MM/yyyy')

select t1._id, t1._month [bill_month], t2._month [payroll_month], case when t1._month <= t2._month then 'bill minor than payroll' else '' end _format_check
	   , t1._date [bill_date], t2._date [payroll_date] , case when t1._date <= t2._date then 'bill minor than payroll' else '' end _date_check
from @t1_month t1
    cross join 
	   (select * 
	   from @t1_month
	   ) t2 
    where 
	   t1._month <= t2._month
	   or t1._date <= t2._date
    order by t1._date, t2._date