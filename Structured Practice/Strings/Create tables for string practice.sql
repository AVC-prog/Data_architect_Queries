create database string_practice;
use string_practice;

create table users (
    user_id int primary key,
    username varchar(100) not null,
    email varchar(255) not null,
    password varchar(255) not null,  
    profile_description text,
    registration_date date
);


insert into users (user_id, username, email, password, profile_description, registration_date) values
(1, 'alice', 'alice@example.com', 'password123', 'developer and tech enthusiast', '2024-01-10'),
(2, 'bob', 'bob@example.com', 'securepassword456', 'gamer and musician', '2024-02-15'),
(3, 'charlie', 'charlie@example.com', 'charlie789secure', 'finance and books', '2024-01-25'),
(4, 'diana', 'diana@example.com', 'fitnesspass2023', 'fitness fanatic', '2024-03-05'),
(5, 'elena', 'elena@example.com', 'traveler999', 'coffee lover and traveler', '2024-01-18');


create table orders (
    order_id int primary key,
    user_id int,
    order_date date,
    amount decimal(10, 2),
    status varchar(50),
    foreign key (user_id) references users(user_id)
);


insert into orders (order_id, user_id, order_date, amount, status) values
(1, 1, '2024-01-11', 150.00, 'completed'),
(2, 2, '2024-02-16', 250.00, 'pending'),
(3, 3, '2024-01-26', 99.99, 'completed'),
(4, 4, '2024-03-06', 500.00, 'cancelled'),
(5, 5, '2024-01-19', 75.50, 'completed');
