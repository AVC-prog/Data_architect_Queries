use leetcode_1581;

-- total sales

select sum(sale_amount)
from employee_sales;

-- total sales by department

select department, sum(sale_amount) as total_sales
from employee_sales
group by department;

-- average sales amount per employee
select employee_id, employee_name, avg(sale_amount)
from employee_sales
group by employee_id, employee_name;   -- if they have the same id, group by name

-- find the employee who made the 2nd and 3rd highest sales
select employee_name, max(sale_amount) as max_money
from employee_sales
group by employee_name
order by max_money desc
limit 1,2;

-- count the sales per region

select region, count(region) as sales_per_region
from employee_sales
group by region;

-- calculate the cumulative sales per employee
select employee_name, sum(sale_amount) over (partition by employee_name order by sale_date) as cumulative_sales
from employee_sales