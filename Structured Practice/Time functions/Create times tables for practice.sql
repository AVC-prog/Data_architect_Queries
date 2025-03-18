CREATE DATABASE time_functions_practice;
USE time_functions_practice;

-- Create a table to store user information with dates
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL,
    registration_date DATE,
    last_login TIMESTAMP,
    account_expiry DATE
);

-- Insert sample data into the users table
INSERT INTO users (username, registration_date, last_login, account_expiry)
VALUES
('alice', '2024-01-10', '2024-03-01 12:00:00', '2025-01-10'),
('bob', '2024-02-15', '2024-03-05 10:00:00', '2025-02-15'),
('charlie', '2023-12-25', '2024-03-07 15:30:00', '2025-12-25'),
('diana', '2024-01-05', '2024-03-10 08:00:00', '2025-01-05'),
('elena', '2024-01-18', '2024-03-15 18:00:00', '2025-01-18');

-- Create a table for orders with timestamps to track time of purchase
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2),
    status VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Insert sample data into the orders table
INSERT INTO orders (user_id, order_date, amount, status)
VALUES
(1, '2024-01-15 14:30:00', 150.00, 'completed'),
(2, '2024-02-20 11:00:00', 250.00, 'pending'),
(3, '2024-01-30 17:15:00', 99.99, 'completed'),
(4, '2024-03-03 13:00:00', 500.00, 'cancelled'),
(5, '2024-02-25 10:45:00', 75.50, 'completed');

-- Create a table for event logs with timestamps
CREATE TABLE event_logs (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_type VARCHAR(100),
    event_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Insert sample data into the event_logs table
INSERT INTO event_logs (user_id, event_type, event_timestamp)
VALUES
(1, 'login', '2024-03-01 08:30:00'),
(2, 'logout', '2024-03-05 12:00:00'),
(3, 'purchase', '2024-02-15 09:00:00'),
(4, 'login', '2024-03-02 10:00:00'),
(5, 'logout', '2024-03-03 16:00:00');
