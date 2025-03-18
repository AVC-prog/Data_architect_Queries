use sql_invoicing;

-- Show the ranking for the males and females by the sale_amount

select employee_name, sale_amount, gender,
row_number() over(partition by gender order by sale_amount desc)  as row_numb
from sales;

-- Top 3 people with greatest sale_amount (defines their popularity)
-- Using a CTE (common table expression):

with popularity_table as ( select employee_name, sale_amount, gender,
 row_number() over(partition by gender order by sale_amount desc, employee_name desc) as popularity
from sales)
select employee_name, popularity, sale_amount
from popularity_table
where popularity <= 3;

-- The same can be achieved with a subquery

select employee_name, popularity, sale_amount
from (select employee_name, sale_amount, gender,
row_number() over(partition by gender order by sale_amount desc, employee_name desc) as popularity
from sales) as popularity_table
where popularity <= 3;

-- Now add a status column (Gold, Silver, and Bronze, and No status)

with popularity_table as ( select employee_name, sale_amount, gender,
 row_number() over(partition by gender order by sale_amount desc,
 employee_name desc) as popularity
from sales)
select employee_name, popularity, sale_amount,
case when  sale_amount > 1000 then "Gold Status" 
when sale_amount between 801 and 1000 then "Silver Status" 
when sale_amount between 500 and 800 then "Bronze Status"
else "No Status"
end as Status
from popularity_table
where popularity <= 3;


-- Now, perform a rolling average of sale_amount, as the boys will compete with the girls


with popularity_table as (
    select employee_name, sale_amount, gender,
        row_number() over (partition by gender order by sale_amount desc,
        employee_name desc) as popularity
    from sales
),
vip as (
    select employee_name, popularity, sale_amount, gender,
        case 
            when sale_amount > 1000 then 'gold status' 
            when sale_amount between 801 and 1000 then 'silver status' 
            when sale_amount between 500 and 800 then 'bronze status'
            else 'no status'
        end as status
    from popularity_table
    where popularity <= 3
)
select employee_name, popularity, gender,
    avg(sale_amount) over (partition by gender order by sale_amount desc) as roll_avg
from vip
where sale_amount > 1000;
