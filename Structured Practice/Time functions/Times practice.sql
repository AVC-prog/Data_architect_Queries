-- Add 10 days to the `registration_date` of all users. 

select username, registration_date, date_add(registration_date, interval 10 day) as new_registration_date
from users;

-- Find the number of days between the `registration_date` and `account_expiry` for each user. 

select username, registration_date, account_expiry,
       datediff(account_expiry, registration_date) as days_until_expiry
from users;

-- Extract only the year and month from the `last_login` timestamp of all users. 

select username, last_login, date_format(last_login, '%y-%m') as last_login_month
from users;

-- Add a custom interval (3 months) to the `last_login` timestamp of all users. 

select username, last_login, date_add(last_login, interval 3 month) as new_last_login
from users;

-- Retrieve all users whose `account_expiry` is after today's date.

select username, account_expiry
from users
where account_expiry > curdate();

-- Display the current date and time along with the difference in days between the current date and `registration_date` for each user.

select username, registration_date, now() as current_datetime,
       datediff(now(), registration_date) as days_since_registration
from users;

-- Calculate the difference in hours between the `order_date` and the current timestamp for each order.

select order_id, order_date, now() as current_datetime,
       timestampdiff(hour, order_date, now()) as hours_since_order
from orders;

-- Add 1 hour to each `order_date` in the `orders` table and display the result.

select order_id, order_date, timestampadd(hour, 1, order_date) as new_order_date
from orders;

-- Find the total number of orders each user has made in the past 30 days.

select user_id, count(*) as orders_in_last_30_days
from orders
where order_date > curdate() - interval 30 day
group by user_id;

-- Find the average number of days between a user's registration and their first order.

select u.username, avg(datediff(o.order_date, u.registration_date)) as avg_days_to_order
from users u
join orders o on u.user_id = o.user_id
group by u.user_id;

-- Find users who haven't logged in for over 60 days.

select username, last_login
from users
where datediff(curdate(), last_login) > 60;

-- Calculate the total sales amount for all products ordered in the past month.

select sum(amount) as total_sales_last_month
from orders
where order_date > curdate() - interval 1 month;

-- Use cast and coalesce to calculate the number of days between registration date and last login for each user

select 
    user_id, 
    username, 
    coalesce(cast(datediff(last_login, registration_date) as signed), 0) as days_active
from users;

-- Use union and union all to combine data from orders and event logs
select user_id, 'order' as source, order_date as timestamp
from orders
where order_date between '2024-01-01' and '2024-03-01'
union
select user_id, 'event' as source, event_timestamp as timestamp
from event_logs
where event_timestamp between '2024-01-01' and '2024-03-01';

-- Use union all to combine order and event logs with duplicates

select user_id, 'order' as source, order_date as timestamp
from orders
where order_date between '2024-01-01' and '2024-03-01'
union all
select user_id, 'event' as source, event_timestamp as timestamp
from event_logs
where event_timestamp between '2024-01-01' and '2024-03-01';

-- Recursive cte to calculate total days active for each user

with recursive login_days(user_id, total_days, last_login) as (
    -- anchor member: start with the first login for each user
    select user_id,
           datediff(last_login, registration_date) as total_days,
           last_login
    from users
    where last_login between '2024-01-01' and '2024-03-01'
    union all
    -- recursive member: add subsequent logins for the same user
    select ul.user_id,
           datediff(ul.last_login, u.registration_date) + ld.total_days,
           ul.last_login
    from users ul
    join login_days ld on ul.user_id = ld.user_id
    where ul.last_login > ld.last_login
)
select user_id, max(total_days) as total_days_active
from login_days
group by user_id;
