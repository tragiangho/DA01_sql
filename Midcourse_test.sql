--Q1
select 
title,
replacement_cost
from film
order by replacement_cost;
---Chi phí thay thế thấp nhất là: 9.99
--Q2
select 
sum(case when replacement_cost between 9.99 and 19.99 then 1
else 0
end) as low,
sum(case when replacement_cost between 20.00 and 24.99 then 1
else 0
end) as medium,
sum(case when replacement_cost between 25.00 and 29.99 then 1
else 0
end) as high
from film
---Có 514 phim có chi phí thay thế thuộc 'low'
--Q3
select
a.title, a.length, c.name as category_name
from film as a
left join film_category as b
on a.film_id=b.film_id
left join category as c
on b.category_id=c.category_id
where c.name='Drama' 
or c.name ='Sports'
order by a.length DESC
---Phim dài nhất là 184 và thuộc loại Sports
--Q4
select
c.name as category_name,
count(a.title) as number
from film as a
left join film_category as b
on a.film_id=b.film_id
left join category as c
on b.category_id=c.category_id
group by c.name
order by count(a.title) DESC;
--- Danh mục Sports là phổ biến nhất, với 74 titles
--Q5
select
concat (first_name,' ', last_name) as full_name,
count(b.film_id)as number_of_film
from actor as a
left join film_actor as b
on a.actor_id=b.actor_id
group by concat (first_name,' ', last_name)
order by count(b.film_id) DESC;
---Diễn viên đóng nhiều film nhất là Susan Davis, 54 bộ
--Q6
select 
a.address,
concat(first_name,' ',last_name) as full_name
from address as a
left join customer as b
on a.address_id=b.address_id
where concat(first_name,' ',last_name) is null;
---Không có địa chỉ nào là không có tên khách hàng
--Q7
select d.city,
sum(a.amount)as total_amount
from payment as a
inner join customer as b on a.customer_id=b.customer_id
inner join address as c on b.address_id=c.address_id
inner join city as d on c.city_id = d.city_id
group by d.city_id
order by sum(a.amount) DESC
--- Thành phố có doanh thu cao nhất là Cape Coral, khoảng 221.55
--Q8
select 
concat(city,',',' ',country)as city_country,
sum(a.amount)as total_amount
from payment as a
inner join customer as b on a.customer_id=b.customer_id
inner join address as c on b.address_id=c.address_id
inner join city as d on c.city_id = d.city_id
inner join country as e on d.country_id=e.country_id
group by d.city_id, e.country
order by sum(a.amount);
--- Thành phố đạt doanh thu cao nhất là Cape Coral, United States, 221.55
--- Thành phố đạt doanh thu thấp nhất là Tallahassee, United States, 50.85


