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

