use sql_hr;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    join_date DATE
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE Order_Details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Customers (customer_name, email, join_date) VALUES
('Alice Johnson', 'alice@example.com', '2023-01-10'),
('Bob Smith', 'bob@example.com', '2023-02-15'),
('Charlie Brown', 'charlie@example.com', '2023-03-20');

INSERT INTO Products (product_name, price) VALUES
('Laptop', 1200.00),
('Phone', 800.00),
('Headphones', 150.00);

INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
(1, '2024-01-05', 1350.00),
(2, '2024-01-10', 800.00),
(3, '2024-02-01', 150.00);

INSERT INTO Order_Details (order_id, product_id, quantity) VALUES
(1, 1, 1),  -- Alice buys 1 Laptop
(1, 3, 1),  -- Alice buys 1 Headphones
(2, 2, 1),  -- Bob buys 1 Phone
(3, 3, 1);  -- Charlie buys 1 Headphones