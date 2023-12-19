--ex1
SELECT COUNTRY.Continent,
floor(avg(CITY.Population))
from CITY
inner join COUNTRY
on CITY.CountryCode=COUNTRY.Code
group by COUNTRY.Continent;
--ex2
select
round(cast(sum(case
when b.signup_action = 'Confirmed'  then 1
else 0
end) AS decimal)/count(b.signup_action),2) as confirm_rate
from emails as a
left join texts as b
on a.email_id=b.email_id
---dividing an integer with another integer would sometimes result in '0'. To avoid this, need to cast either the denominator or the numerator to DECIMAL type.
--ex3
select 
b.age_bucket,
round(100.0 *
sum(a.time_spent) filter(where a.activity_type='open')/sum(a.time_spent),2) as open_perc,
round(100.0 *
sum(a.time_spent) filter(where a.activity_type='send')/sum(a.time_spent),2) as send_perc
from activities as a  
left join age_breakdown as b
on a.user_id=b.user_id
where a.activity_type in('send','open')
group by b.age_bucket;
--lưu ý: có thêm mục 'chat', chỉ lấy mỗi 'open' và 'send'
--ex3
with snap as 
(select b.age_bucket,
        sum(case when activity_type = 'open' then time_spent else 0 end) as t_open,
        sum(case when activity_type = 'send' then time_spent else 0 end) as t_send
from activities as a
left join age_breakdown as b 
  on a.user_id = b.user_id
group by b.age_bucket)

select age_bucket, 
       round(t_sned/(t_send + t_open)*100.0,2) as send_perc,
       round(t_open/(t_open + t_send)*100.0,2) as open_perc
from snap;    
--ex4
SELECT
a.customer_id
FROM customer_contracts as a  
left join products as b 
on a.product_id=b.product_id
group by a.customer_id
having count (distinct (b.product_category))=3;
--ex5
select 
emp1.employee_id,emp1.name,
count(emp2.reports_to) as reports_count, 
round (avg(emp2.age)) as average_age
from employees as emp1
inner join employees as emp2
on emp1.employee_id=emp2.reports_to
group by emp1.employee_id, emp1.name
order by emp1.employee_id;
--ex6
select
a.product_name,
sum(b.unit) as unit
from Products as a
left join Orders as b
on a.product_id=b.product_id
where extract (month from order_date)='02'
and extract (year from order_date)='2020'
group by a.product_name
having sum(b.unit)>=100;
--ex7
select 
a.page_id
from pages as a  
left join page_likes as b 
on a.page_id=b.page_id
where liked_date is null
order by page_id;
