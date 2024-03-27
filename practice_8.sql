--ex1
with cte_1 as (select * from (select customer_id, order_date, customer_pref_delivery_date,
row_number() over(partition by customer_id order by order_date asc) as stt
from Delivery)
where stt=1)
select distinct
round ((select count (customer_id) from cte_1 where order_date=customer_pref_delivery_date)*100/(select count (customer_id) from cte_1),2) as immediate_percentage
from cte_1
--ex2
with cte_1 as
(select player_id, event_date,
lead(event_date,1) over (partition by player_id) as the_next_day
from Activity)
select distinct
round ((select count (player_id) from cte_1 where the_next_day=event_date+1)*1.0/(select count(distinct player_id) from cte_1),2) as fraction
from cte_1
--ex3
select case 
when id%2 = 0 then ID-1
when id%2 <> 0 and ID <> (select Max(ID) from Seat) then ID+1
else ID
end as ID, STUDENT
from Seat
order by id
--ex4
with total_cte as
(select distinct visited_on, 
sum(amount) over (order by visited_on
range between interval '6' day preceding and current row) as amount
from Customer)
select visited_on, amount, round(amount/7.0, 2) as average_amount
from total_cte as a
INNER JOIN
(SELECT MIN(visited_on) AS min_visited_on FROM total_cte) AS b
ON DATE_PART('day',visited_on) - DATE_PART('day', min_visited_on) >= 6
order by visited_on asc
--ex5
with cte_1 as
(select pid, tiv_2015, tiv_2016,
concat (lat,' ', lon) as lat_lon
from Insurance)
select sum (tiv_2016) as tiv_2016
from cte_1
where tiv_2015 in (select tiv_2015 from cte_1 group by tiv_2015 having count (*)>1 )
and lat_lon in (select lat_lon from cte_1 group by lat_lon having count (*)=1 )
--ex6
with cte_1 as
(select a.name as Employee, a.Salary, b.name as Department
from Employee as a
inner join Department as b on a.departmentId=b.id)
select Department,Employee, Salary from 
(select Department,Employee, Salary,
dense_rank() over (partition by department order by salary desc) as rk
from cte_1) as cte_2
where rk<=3
--ex7
with Queue_table as 
(select turn, person_id, person_name, weight,
sum(weight)over(order by turn) as total_weight
from Queue
order by turn)
select person_name from 
Queue_table
where total_weight=1000
--ex8
select distinct product_id, 10 as price from Products where product_id not in 
(select distinct product_id from Products where change_date <='2019-08-16' )
union
select product_id, new_price as price from Products 
where (product_id,change_date) in (select product_id , max (change_date) as date from Products where change_date <='2019-08-16' 
group by product_id)
