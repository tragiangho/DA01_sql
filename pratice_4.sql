--ex1
select
sum(case
when device_type='laptop'then 1
else 0
end )as laptop_reviews,
sum(case
when device_type in ('tablet','phone') then 1
else 0
end) as mobile_views
from viewership;
--ex2
select x,y,z,
case
when X+Y<=Z or X+Z<=Y or Y+Z<=X then 'No'
else 'Yes'
end as triangle
from Triangle;
--ex3
select
round(cast(sum(case
when call_category='n/a'or call_category is null then 1
else 0
end)*100/count(*) AS Ddecimal),1)
AS call_percentage
FROM callers;
--ex4
select name from Customer
where referee_id <>2 or referee_id is null;
--ex5
select 
case
when pclass=1 then 'first_class'
when pclass=2 then 'second_class'
else 'third_class'
end as passenger_class,
sum (case
when survived= 1 then 1
else 0
end )as survivors,
sum(case when survived=0 then 1
else 0
end) as non_survivors
from titanic
group by passenger_class;
