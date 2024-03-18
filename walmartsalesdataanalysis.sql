SELECT * FROM walmartsalesdata.sales;
select branch ,count(branch) from sales
group by branch;
select city,count(city) 
from sales
group by city;
select payment_method,count(payment_method)
from sales
group by payment_method;
select product_line,count(product_line)
from sales
group by product_line;

--- time_of_day---

select time,
(case
    when time between "00:00:00" and "12:00:00" then "Morning"
    when time between "12:01:00" and "16:00:00" then "Afternoon"
    else "Evening"
 end) as time_of_day
from sales;
alter table sales add column time_of_day varchar(20);
update sales
set time_of_day = (case
    when time between "00:00:00" and "12:00:00" then "Morning"
    when time between "12:01:00" and "16:00:00" then "Afternoon"
    else "Evening"
 end);
 
 --- day_name---
 select date,
 dayname(date) as day_name
 from sales;
 
 alter table sales add column day_name varchar(20);
 update sales
 set day_name = dayname(date) ;
 
 --- month_name---
 select date,
 monthname(date)
 from sales;
 alter table sales add column month_name varchar(20);
 update sales 
 set month_name = monthname(date) ;
 
 --- EDA ---
 --- 1. how many unique city does data have ? --- 
 select distinct(city)
 from sales;
 --- 2.which city in each branch? ---
 select city,branch,count(branch)
 from sales
 group by city,branch
 order by branch ;
 
 ---- PRODUCT QUESTIONS ----
 
 --- 3.how many unique product lines does data have?---
 select count(distinct(product_line)) as total_no_of_product
 from sales;
 --- 4.most common payment method?---
 select distinct(payment_method)
 from sales;
 --- 5.most selling product?---
 select product_line,sum(quantity) as quantity_count
 from sales
 group by product_line
 order by quantity_count desc;
 select * from sales;
--- 6.total branch revenue by month?---
select branch,city,month_name,sum(total) as total_revenue
from sales
group by branch,city,month_name
order by month_name,total_revenue desc;

--- 7.total revenue by month?---
select month_name,sum(total) as total_revenue
from sales
group by month_name
order by total_revenue desc;

--- 8.which month had the largest COGS?---
select month_name,sum(cogs) as large_cogs
from sales
group by month_name
order by large_cogs desc;

--- 9.which product line had the largest revenue?---
select product_line,sum(total) as Total
from sales
group by product_line
order by Total desc;
--- 10.city with largest revenue?--- 
 select city,sum(total) as largest_revenue
 from sales
 group by city
 order by largest_revenue desc;
--- 11.which product line had the largest VAT?---
select product_line,max(VAT) as VAT
from sales
group by product_line
order by VAT desc;
--- 12.add column and find product---
alter table sales add column review varchar(20);
select * from sales;
update sales 
set review = (case
                  when rating between "0.0" and "3.0" then "Bad"
                  when rating between "3.1" and "5.0" then "Better"
                  when rating between "5.1" and "8.0" then "Good"
                  else "Best" end);
select city,product_line,rating
from sales where review ="Best";
--- 13.most common product by gender?---
select product_line,gender,count(gender) as total_count
from sales
group by product_line,gender
order by total_count desc;


 
 
 
 
 