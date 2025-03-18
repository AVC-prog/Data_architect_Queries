-- Step 1: Create a new database for practicing joins
create database join_practice;
use join_practice;

-- Step 2: Create `users` table to store user information
create table users (
    user_id int primary key auto_increment,
    username varchar(100) not null,
    email varchar(255) not null unique
);

-- Step 3: Insert sample data into `users` table
insert into users (username, email)
values 
('alice', 'alice@example.com'),
('bob', 'bob@example.com'),
('charlie', 'charlie@example.com'),
('diana', 'diana@example.com');

-- Step 4: Create `orders` table to store order information
create table orders (
    order_id int primary key auto_increment,
    user_id int,
    order_date date,
    total_amount decimal(10, 2),
    foreign key (user_id) references users(user_id)
);

-- Step 5: Insert sample data into `orders` table
insert into orders (user_id, order_date, total_amount)
values 
(1, '2024-01-15', 150.00),
(2, '2024-02-20', 250.00),
(3, '2024-01-30', 99.99),
(4, '2024-03-03', 500.00);

-- Step 6: Create `products` table to store product information
create table products (
    product_id int primary key auto_increment,
    order_id int,
    product_name varchar(255),
    price decimal(10, 2),
    foreign key (order_id) references orders(order_id)
);

-- Step 7: Insert sample data into `products` table
insert into products (order_id, product_name, price)
values 
(1, 'laptop', 1500.00),
(1, 'mouse', 25.50),
(2, 'smartphone', 899.99),
(3, 'headphones', 250.00);

-- Exercises: Progressive difficulty join exercises

-- Exercise 1: Use INNER JOIN to list all users who have placed an order
-- We want to get the `user_id`, `username`, and `order_date` for users who have placed an order.
select 
    users.user_id, 
    users.username, 
    orders.order_date 
from users
inner join orders on users.user_id = orders.user_id;

-- Exercise 2: Use LEFT JOIN to list all users and their orders
-- This query should return all users and any orders they have placed. 
-- If a user has no orders, it should still list them with NULL for the `order_date`.
select 
    users.user_id, 
    users.username, 
    orders.order_date 
from users
left join orders on users.user_id = orders.user_id;

-- Exercise 3: Use RIGHT JOIN to list all orders and their corresponding users
-- This query should return all orders, including those without an associated user (if possible).
select 
    orders.order_id, 
    users.username, 
    orders.order_date 
from orders
right join users on orders.user_id = users.user_id;

-- Exercise 4: Use FULL OUTER JOIN to list all users and all orders
-- This query should list all users and all orders, showing NULL where there is no matching user or order.
-- Note: MySQL does not support FULL OUTER JOIN directly, but we can achieve the same result with a UNION of LEFT JOIN and RIGHT JOIN.
select 
    users.user_id, 
    users.username, 
    orders.order_date 
from users
left join orders on users.user_id = orders.user_id
union
select 
    users.user_id, 
    users.username, 
    orders.order_date 
from orders
right join users on orders.user_id = users.user_id;

-- Exercise 5: Use CROSS JOIN to get all combinations of users and products
-- This query should return all possible combinations of users and products (note: this will create a Cartesian product).
select 
    users.username, 
    products.product_name 
from users
cross join products;

-- Exercise 6: Use a JOIN with a WHERE clause to find users who have ordered a specific product
-- This query should list all users who have ordered the 'laptop' product.
select 
    users.username, 
    products.product_name 
from users
inner join orders on users.user_id = orders.user_id
inner join products on orders.order_id = products.order_id
where products.product_name = 'laptop';

-- Exercise 7: Use LEFT JOIN and COALESCE to list all users and the total value of their orders
-- This query should list all users and the total value of their orders, showing NULL for users with no orders.
select 
    users.username, 
    coalesce(sum(products.price), 0) as total_order_value
from users
left join orders on users.user_id = orders.user_id
left join products on orders.order_id = products.order_id
group by users.user_id;

-- Exercise 8: Use JOIN and aggregate functions to find the most expensive product ordered by each user
-- This query should list each user and the name of the most expensive product they ordered.
select 
    users.username, 
    products.product_name
from users
inner join orders on users.user_id = orders.user_id
inner join products on orders.order_id = products.order_id
where products.price = (
    select max(price) from products where order_id = orders.order_id
);
