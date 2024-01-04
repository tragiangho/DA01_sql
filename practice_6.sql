--ex1
With double_job_listings
as(
select company_id,
title,
description,
count(job_id) as job_count
from job_listings
group by company_id, title, description)

SELECT 
count(distinct company_id) as duplicate_comany
from double_job_listings
where job_count>=2;
--ex2
with cte_1 
as (select category, product,
sum(spend) as total_spend
from product_spend
where extract(year from transaction_date)=2022
group by product, category),
cte_2 as(
select *, rank() over(PARTITION BY category order by total_spend DESC) as rk
from cte_1)
select 
category, product, total_spend
from cte_2
where rk<=2
--ex3
With cte_callers
as(
SELECT policy_holder_id,
count(case_id) as number_of_calls
FROM callers
group by policy_holder_id)

SELECT
count (distinct policy_holder_id) as member_count
from cte_callers
where number_of_calls>=3
--ex4
SELECT 
a.page_id
FROM pages as a  
left join page_likes as b 
on a.page_id=b.page_id
where liked_date is null
order by page_id;
--ex5
select 
7 as month,
count(distinct user_id) as monthly_active_user
from user_actions
where exists(
select distinct user_id as active_users
from user_actions
where event_id is not null
and (extract(year from event_date)='2022'
and extract (month from event_date)='7'))
and extract (month from event_date)='6'
and extract (year from event_date)='2022'
group by extract (month from event_date)='7';
--ex6
select
to_char(trans_date, 'YYYY-MM') as month,
country,
count(id) as trans_count,
sum (case when state= 'approved'then 1 else 0 end) as approved_count,
sum(amount) as trans_total_amount,
sum(case when state='approved' then amount else 0 end) as approved_total_amount
from Transactions 
group by to_char(trans_date, 'YYYY-MM'), country;
--ex7
with cte as
(select product_id,
min(year) as year_1
from Sales
group by product_id)

select
a.product_id, year as first_year,
b.quantity, b.price
from cte as a
inner join Sales as b
on a.product_id=b.product_id
and a. year_1=b.year
---hoặc
select 
product_id, year as first_year,
quantity, price
from Sales
where (product_id, year) in ((select product_id,
min(year) 
from Sales
group by product_id))
--ex8
select customer_id
from Customer
group by customer_id
having count(distinct product_key)=(Select count(product_key) from Product)
--ex9
select e.employee_id
from employees as e
left join employees as mng
on e.manager_id=mng.employee_id
where e.salary<30000
and mng.employee_id is null
and e.manager_id is not null
order by e.employee_id
--ex10
With double_job_listings
as(
select company_id,
title,
description,
count(job_id) as job_count
from job_listings
group by company_id, title, description)

SELECT 
count(distinct company_id) as duplicate_comany
from double_job_listings
where job_count>=2
--ex11
with cte_1 
as (select user_id, count(rating) as count
from MovieRating
group by user_id),

cte_2
as(select movie_id, avg(rating)as avg
from MovieRating
where extract (year from created_at)=2020 and extract (month from created_at)=2
group by movie_id)

(select name as results
from Users
join cte_1 on cte_1.user_id=Users.user_id
where cte_1.count=(select max(count) from cte_1)
order by name
limit 1)

union all

(select title as results
from Movies
join cte_2 on Movies.movie_id=cte_2.movie_id
where cte_2.AVG=(select max(avg) from cte_2)
order by title 
limit 1);
--ex12
select id, COUNT(*) as num 
from (
    select requester_id as id from RequestAccepted
    union all
    select accepter_id from RequestAccepted
) as friends_count
group by id
order by num DESC
limit 1;


