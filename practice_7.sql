--ex1
with cte_1 as
(select 
extract (year from transaction_date) as year,
product_id,
sum(spend)as curr_year_spend
from user_transactions
group by product_id,extract (year from transaction_date))
select *,
lag(curr_year_spend)over(partition by product_id order by year) as prev_year_spend,
round((((curr_year_spend - lag(curr_year_spend)over(partition by product_id order by year))/lag(curr_year_spend)over(partition by product_id order by year))*100),2) as yoy_rate
from cte_1;
--ex2
SELECT distinct
card_name,
first_value(issued_amount) over (partition by card_name order by issue_year,issue_month) as issued_amount
FROM monthly_cards_issued
order by issued_amount DESC;
hoặc
with cte_1 as 
(SELECT
  card_name,
  issued_amount,
  RANK() OVER(PARTITION BY card_name ORDER BY issue_year, issue_month) AS ranker
FROM monthly_cards_issued)
select card_name,
issued_amount
from cte_1
where ranker=1
order by issued_amount DESC;
--ex3
with cte_1 as(
SELECT
user_id,spend, transaction_date,
rank() over (partition by user_id order by transaction_date) as rk
FROM transactions)
select user_id, spend, transaction_date from cte_1
where rk=3;
--ex4
with cte_1 
as (SELECT user_id,transaction_date,
count(product_id) over (partition by user_id order by transaction_date DESC) as number_of_product,
rank()over(partition by user_id order by transaction_date DESC) as rk
FROM user_transactions)
select distinct user_id,transaction_date,
number_of_product
from cte_1
where rk=1
order by transaction_date ASC;
--ex6
with cte_1 as (
SELECT 
transaction_id, merchant_id, credit_card_id, amount, transaction_timestamp,
lag(transaction_timestamp) over (partition by merchant_id, credit_card_id,amount order by transaction_timestamp) as prev_timestamp,
extract(epoch from transaction_timestamp-lag(transaction_timestamp) over (partition by merchant_id, credit_card_id,amount order by transaction_timestamp))/60 as minute_difference
FROM transactions)
select 
count(merchant_id) as payment_count
from cte_1
where minute_difference <=10;
--ex7
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
--ex8
with top_10_global_song_rank
as (SELECT day, song_id, rank
FROM global_song_rank
where rank<=10),
cte_2 as
(select a.artist_id, a.artist_name, b.song_id,
count(b.song_id) over (partition by a.artist_id) as number_of_song
from artists as a
inner join songs as b on a.artist_id=b.artist_id
inner join top_10_global_song_rank as c on b.song_id=c.song_id)

select * from
(select distinct artist_name,
dense_rank() over (order by number_of_song DESC) as artist_rank
from cte_2) as cte_3
where artist_rank<=5
order by artist_rank
