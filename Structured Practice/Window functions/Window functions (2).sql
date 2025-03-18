use sql_invoicing;

-- Create two new columns that have the sale_date in the next and previous rows (return first 3 rows)

select *, lead(sale_date) over (order by sale_date desc) as next_date,
lag(sale_date) over (order by sale_date desc) as previous_date
from sales
limit 3 ; -- returns the first 3

-- Now create those same columns above, but retrive the 3 columns after the first 3

select *, lead(sale_date) over (order by sale_date desc) as next_date,
lag(sale_date) over (order by sale_date desc) as previous_date
from sales
limit 3,3; -- returns 3 columns after the third one

-- Now add the window function that indexes rows by next_date  (something is wrong here)


select *, rank() over (order by next_date desc) as rank_date 
from (select *, 
           lead(sales_date) over (order by sales_date desc) as next_date,
           lag(sales_date) over (order by sales_date desc) as previous_date
    from sales
) as subquery;