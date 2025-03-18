create database self_joins;
use self_joins;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

INSERT INTO employees (employee_id, name, manager_id) VALUES
(1, 'Alice', NULL),  -- CEO (no manager)
(2, 'Bob', 1),
(3, 'Carol', 1),
(4, 'Dave', 2),
(5, 'Eve', 2);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    referred_by INT,
    FOREIGN KEY (referred_by) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, name, referred_by) VALUES
(1, 'Alice', NULL),  -- No one referred Alice
(2, 'Bob', 1),
(3, 'Carol', 1),
(4, 'Dave', 2),
(5, 'Eve', 3);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(101, 1, '2024-01-05', 200.00),
(102, 1, '2024-01-07', 350.00),
(103, 2, '2024-02-15', 150.00),
(104, 1, '2024-02-20', 500.00),
(105, 3, '2024-02-25', 500.00);

CREATE TABLE salary_history (
    employee_id INT,
    salary DECIMAL(10,2),
    change_date DATE,
    PRIMARY KEY (employee_id, change_date),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO salary_history (employee_id, salary, change_date) VALUES
(1, 50000, '2023-01-01'),
(1, 55000, '2023-06-01'),
(1, 60000, '2024-01-01'),
(2, 40000, '2023-02-01'),
(2, 45000, '2023-09-01');

CREATE TABLE flights (
    flight_id INT PRIMARY KEY,
    departure_city VARCHAR(100),
    arrival_city VARCHAR(100),
    departure_time DATETIME,
    arrival_time DATETIME
);

INSERT INTO flights (flight_id, departure_city, arrival_city, departure_time, arrival_time) VALUES
(1, 'New York', 'Chicago', '2024-03-10 08:00', '2024-03-10 10:00'),
(2, 'Chicago', 'Los Angeles', '2024-03-10 12:00', '2024-03-10 15:00'),
(3, 'New York', 'Miami', '2024-03-10 09:00', '2024-03-10 12:00'),
(4, 'Miami', 'Los Angeles', '2024-03-10 14:00', '2024-03-10 17:00');