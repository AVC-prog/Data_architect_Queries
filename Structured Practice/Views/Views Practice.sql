use sql_hr;

-- Create a view that shows the name of the products that have more than 150 in stock

create view view_all_products as
select product_name
from inventory
where stock_quantity > 150;

-- Create a view that shows product names and their total stock value

create view total_stock_value as
select product_name, (price*stock_quantity) as total_value
from inventory;

-- Create a view to categorize products into price ranges

create view view_product_categories as
select product_name,
 case
 when price <= 500 then "Affordable"
 when price > 500 then "Expensive"
 end as price_category
 from inventory

