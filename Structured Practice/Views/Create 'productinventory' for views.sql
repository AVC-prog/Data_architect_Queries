use sql_hr;

CREATE TABLE ProductInventory (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    stock_quantity INT
);

INSERT INTO ProductInventory (product_id, product_name, price, stock_quantity)
VALUES
(1, 'Laptop', 1000.00, 50),
(2, 'Smartphone', 700.00, 150),
(3, 'Headphones', 100.00, 200),
(4, 'Monitor', 300.00, 75),
(5, 'Mouse', 20.00, 300);