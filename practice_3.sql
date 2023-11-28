--ex1
--ex2
select user_id,
concat(upper(left(name,1)), lower(substring(name from 2 for length(name)-1))) as name
from Users
order by user_id
--ex3
select manufacturer,
concat('$',ROUND (SUM(total_sales)/1000000),' ','million')as sales_mil
from pharmacy_sales
group by manufacturer
order by ceiling(sum(total_sales)) DESC, manufacturer ASC
--ex4
select extract (month from submit_date)as mth,
product_id as product,
round(cast(avg(stars)as decimal),2) as avg_stars
from reviews
group by product_id, extract (month from submit_date)
order by extract (month from submit_date), product_id
