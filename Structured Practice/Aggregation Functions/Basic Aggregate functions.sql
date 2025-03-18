use leetcode_1581;

-- count how many orders are there
select count(order_id) as count
from orders;

-- get the total amount per customr
select sum(total_amount) as total_orders
from orders
group by customer_id;

-- get customers who spent more than 300
select sum(total_amount) as total_amount
from orders
group by customer_id
having sum(total_amount) > 300