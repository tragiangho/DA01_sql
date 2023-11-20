--ex1
SELECT DISTINCT CITY FROM STATION
WHERE ID%2=0;
--ex2
SELECT COUNT(CITY)-COUNT(DISTINCT CITY)FROM STATION;
--ex4
SELECT 
ROUND(CAST(SUM(item_count*order_occurrences)/SUM(order_occurrences)AS DECIMAL),1)
FROM items_per_order;
--ex5
SELECT candidate_id
FROM candidates
WHERE skill in('Python','Tableau','PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill)=3
ORDER BY candidate_id;
--ex6
SELECT user_id,
DATE(max(post_date))-DATE(min(post_date)) as days_between
FROM posts
WHERE post_date>'2021-01-01'AND post_date<'2022-01-01'
GROUP BY user_id
HAVING COUNT (post_id)>=2;
--ex7
SELECT card_name,
max(issued_amount)-min(issued_amount) as number_disparity
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY (max(issued_amount)-min(issued_amount)) DESC;
--ex8
SELECT manufacturer,
ABS(SUM(total_sales - cogs)) as total_loss,
count(drug) as drug_count
FROM pharmacy_sales
WHERE total_sales-cogs<=0
group by manufacturer
order by ABS(SUM(total_sales - cogs)) DESC;
--ex9
select id, 
movie, 
description,
rating 
from cinema
where id%2=1
and description<>'boring'
order by rating DESC
--ex10
SELECT 
teacher_id, 
COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id;
--ex11
SELECT user_id ,
COUNT(follower_id)as followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id;
--ex12
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student)>=5;
