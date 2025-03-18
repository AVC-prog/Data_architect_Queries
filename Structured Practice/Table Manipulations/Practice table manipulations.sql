-- Practice table manipulation

create database table_manipulations_practice;
use table_manipulations_practice;

-- Create a `users` table with columns for user data
create table users (
    user_id int primary key auto_increment,
    username varchar(100) not null,
    email varchar(255) not null unique,
    registration_date date,
    status enum('active', 'inactive', 'suspended') default 'active',
    country varchar(50)
);

-- Insert sample values into `users` table
insert into users (username, email, registration_date, status, country)
values 
('alice', 'alice@example.com', '2024-01-10', 'active', 'usa'),
('bob', 'bob@example.com', '2024-02-15', 'inactive', 'canada'),
('charlie', 'charlie@example.com', '2024-01-25', 'active', 'uk'),
('diana', 'diana@example.com', '2024-03-05', 'suspended', 'australia');

-- Insert a new user with on duplicate key update clause (for handling duplicate emails)
insert into users (username, email, registration_date, status, country)
values 
('elena', 'elena@example.com', '2024-01-18', 'active', 'germany')
on duplicate key update 
    username = values(username), 
    registration_date = values(registration_date), 
    status = values(status), 
    country = values(country);

-- Modify a column in the `users` table - change `status` to allow 'pending' as a valid value
alter table users modify column status enum('active', 'inactive', 'suspended', 'pending') default 'active';

-- Create a `products` table with references to `users` (foreign key)
create table products (
    product_id int primary key auto_increment,
    user_id int,
    product_name varchar(255),
    price decimal(10, 2),
    foreign key (user_id) references users(user_id) on delete cascade
);

-- Insert sample data into `products` table
insert into products (user_id, product_name, price)
values 
(1, 'laptop', 1500.00),
(2, 'smartphone', 899.99),
(3, 'headphones', 250.00);

-- Modify the `products` table to add a `description` column
alter table products add column description text;

-- Update product description after adding the new column
update products
set description = 'high performance laptop for work and gaming'
where product_name = 'laptop';

-- Drop the `products` table
drop table products;

-- Drop the `table_manipulations_practice` database
drop database table_manipulations_practice;

-- Create a new database for further practice (you can practice here without worrying about the previous database)
create database table_manipulations_practice_v2;

-- Create a `orders` table with a primary key and foreign key reference to `users`
create table orders (
    order_id int primary key auto_increment,
    user_id int,
    order_date timestamp default current_timestamp,
    amount decimal(10, 2),
    status varchar(50),
    foreign key (user_id) references users(user_id)
);

-- Insert sample data into `orders` table
insert into orders (user_id, amount, status)
values 
(1, 150.00, 'completed'),
(2, 250.00, 'pending'),
(3, 99.99, 'completed');

-- Insert values into `orders` with `on duplicate key update` (we are using order_id as the unique key)
insert into orders (order_id, user_id, amount, status)
values 
(1, 1, 180.00, 'completed')
on duplicate key update 
    amount = values(amount), 
    status = values(status);

-- Modify the `orders` table to change the `amount` column to a higher precision
alter table orders modify column amount decimal(15, 2);

-- Create a `payment_logs` table with foreign key reference to `orders`
create table payment_logs (
    log_id int primary key auto_increment,
    order_id int,
    payment_date timestamp default current_timestamp,
    amount_paid decimal(10, 2),
    foreign key (order_id) references orders(order_id)
);

-- Insert sample data into `payment_logs`
insert into payment_logs (order_id, amount_paid)
values 
(1, 150.00),
(2, 250.00);

-- Drop the `payment_logs` table
drop table payment_logs;

-- Use `TRUNCATE` to remove all data from the `orders` table

truncate table orders;   -- remove all rows from the table without deleting the table itself

-- Verify that `orders` table is empty after truncating
select * from orders;