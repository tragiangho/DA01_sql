--ex1
select NAME from CITY
where COUNTRYCODE='USA'
and POPULATION>120000;
--ex2
select * from CITY
where COUNTRYCODE='JPN';
--ex3
select CITY, STATE from STATION;
--ex4
select CITY from STATION
where CITY like 'A%'or CITY like 'E%'or CITY like 'I%'or CITY like 'O%'or CITY like 'U%';
--ex5
select distinct CITY from STATION
where CITY like '%a'or CITY like '%e'or CITY like '%i'or CITY like '%o'or CITY like '%u';
--ex6
select distinct CITY from STATION
where CITY like '%a'or CITY like '%e'or CITY like '%i'or CITY like '%o'or CITY like '%u';
--ex7
select name from Employee
order by name ASC;
--ex8
select name from Employee
where salary>2000 and months<10
order by employee_id ASC;
--ex9
select product_id from Products
where low_fats='Y'and recyclable='Y'; 
--ex10
select name from Customer
where referee_id <>2 or referee_id is null;
--ex11
select name, population, area from World
where area>=3000000 or population>=25000000;
--ex12
select name, population, area from World
where area>=3000000 or population>=25000000;
--ex13
select part, assembly_step from parts_assembly
where finish_date is null and assembly_step is not null;
--ex14
select * from lyft_drivers
where yearly_salary <=30000 or yearly_salary >=70000;
--ex15
select advertising_channel from uber_advertising
where year=2019 and money_spent>100000;
