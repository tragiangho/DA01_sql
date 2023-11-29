--ex1
select
Name
from STUDENTS
where Marks>75
order by right(Name,3), ID;
--ex2
select user_id,
concat(upper(left(name,1)), lower(substring(name from 2 for length(name)-1))) as name
from Users
order by user_id;
--ex3
select manufacturer,
concat('$',ROUND (SUM(total_sales)/1000000),' ','million')as sales_mil
from pharmacy_sales
group by manufacturer
order by ceiling(sum(total_sales)) DESC, manufacturer ASC;
--ex4
select extract (month from submit_date)as mth,
product_id as product,
round(cast(avg(stars)as decimal),2) as avg_stars
from reviews
group by product_id, extract (month from submit_date)
order by extract (month from submit_date), product_id;
--ex5
select 
sender_id, 
count(message_id) as count_messages
from messages
where extract(month from sent_date)= '8'
and extract(year from sent_date)='2022'
group by sender_id
order by COUNT(message_id) DESC
limit 2;
--ex6
select
tweet_id
from Tweets
where length(content)>15;
--ex7
select
activity_date as day,
count(distinct user_id)as active_users
from Activity
where activity_date between '2019-06-27'and '2019-07-27'
group by activity_date;
--ex8
select 
count(id) as number_employees
from employees
where (extract (month from joining_date) between 1 and 7
and extract (year from joining_date)=2022
  --ex9
select 
first_name,
position('a'in first_name )as position
from worker
where first_name='Amitah';
--ex10
select 
title,
substring(title from length(winery)+2 for 4) as year
from winemag_p2
where country='Macedonia'
