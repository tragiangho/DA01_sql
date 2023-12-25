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
order by page_id
