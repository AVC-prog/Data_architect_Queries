create database indexes_practice;
use indexes_practice;

-- Create a basic `users` table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    registration_date DATE,
    status VARCHAR(20) CHECK(status IN ('active', 'inactive', 'suspended')),
    country VARCHAR(50),
    profile_description TEXT
);

INSERT INTO users (user_id, username, email, registration_date, status, country, profile_description) VALUES
(1, 'alice', 'alice@example.com', '2024-01-10', 'active', 'USA', 'Loves technology and programming'),
(2, 'bob', 'bob@example.com', '2024-02-15', 'inactive', 'Canada', 'Avid gamer and musician'),
(3, 'charlie', 'charlie@example.com', '2024-01-25', 'active', 'UK', 'Working in finance, enjoys reading books'),
(4, 'diana', 'diana@example.com', '2024-03-05', 'suspended', 'Australia', 'Passionate about fitness and sports'),
(5, 'elena', 'elena@example.com', '2024-01-18', 'active', 'Germany', 'A coffee enthusiast and traveler'),
(6, 'frank', 'frank@example.com', '2024-02-22', 'inactive', 'USA', 'Tech geek and foodie'),
(7, 'grace', 'grace@example.com', '2024-01-30', 'active', 'France', 'Loves hiking and outdoor activities'),
(8, 'hannah', 'hannah@example.com', '2024-03-10', 'active', 'Spain', 'Artist and graphic designer'),
(9, 'ian', 'ian@example.com', '2024-01-12', 'suspended', 'Italy', 'Interested in history and archaeology'),
(10, 'jack', 'jack@example.com', '2024-02-05', 'active', 'USA', 'Football enthusiast and programmer');



-- Create a table for `orders` to simulate e-commerce or business transactions
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    amount DECIMAL(10, 2),
    status VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO orders (order_id, user_id, order_date, amount, status) VALUES
(1, 1, '2024-01-11', 150.00, 'completed'),
(2, 2, '2024-02-16', 250.00, 'pending'),
(3, 3, '2024-01-26', 99.99, 'completed'),
(4, 4, '2024-03-06', 500.00, 'cancelled'),
(5, 5, '2024-01-19', 75.50, 'completed'),
(6, 6, '2024-02-23', 200.00, 'pending'),
(7, 7, '2024-01-31', 120.00, 'completed'),
(8, 8, '2024-03-12', 180.00, 'completed'),
(9, 9, '2024-01-13', 60.00, 'completed'),
(10, 10, '2024-02-06', 90.00, 'completed');


-- Create a table for storing `locations` with spatial data
CREATE TABLE locations (
    location_id INT PRIMARY KEY,
    name VARCHAR(100),
    coordinates POINT
);

INSERT INTO locations (location_id, name, coordinates) VALUES
(1, 'New York', ST_GeomFromText('POINT(-74.0060 40.7128)')),
(2, 'Los Angeles', ST_GeomFromText('POINT(-118.2437 34.0522)')),
(3, 'Paris', ST_GeomFromText('POINT(2.3522 48.8566)')),
(4, 'Berlin', ST_GeomFromText('POINT(13.4050 52.5200)')),
(5, 'Tokyo', ST_GeomFromText('POINT(139.6917 35.6762)')),
(6, 'London', ST_GeomFromText('POINT(-0.1276 51.5074)')),
(7, 'Rome', ST_GeomFromText('POINT(12.4964 41.9028)')),
(8, 'Sydney', ST_GeomFromText('POINT(151.2093 -33.8688)')),
(9, 'Madrid', ST_GeomFromText('POINT(-3.7038 40.4168)')),
(10, 'Toronto', ST_GeomFromText('POINT(-79.3832 43.6532)'));


-- Create a `sales` table for testing full-text indexes with text-based queries
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    product_description TEXT,
    sale_date DATE,
    amount DECIMAL(10, 2)
);

INSERT INTO sales (sale_id, product_name, product_description, sale_date, amount) VALUES
(1, 'Laptop', 'High performance laptop for work and gaming', '2024-01-11', 1500.00),
(2, 'Smartphone', 'Latest model with high camera quality', '2024-02-18', 899.99),
(3, 'Headphones', 'Noise-cancelling over-ear headphones', '2024-01-27', 250.00),
(4, 'Smartwatch', 'Wearable device with fitness tracking', '2024-03-07', 200.00),
(5, 'Tablet', 'Portable tablet with 10-inch screen', '2024-01-20', 450.00),
(6, 'Bluetooth Speaker', 'Portable speaker with great sound quality', '2024-02-25', 120.00),
(7, 'Monitor', '27-inch 4K UHD monitor for home office', '2024-01-15', 350.00),
(8, 'Keyboard', 'Mechanical keyboard with RGB lights', '2024-03-14', 120.00),
(9, 'Mouse', 'Wireless mouse with ergonomic design', '2024-02-10', 40.00),
(10, 'Charger', 'Fast charging USB-C charger', '2024-01-30', 25.00);


-- Create a table to store XML data
CREATE TABLE products_xml (
    product_id INT PRIMARY KEY,
    product_info text
);

INSERT INTO products_xml (product_id, product_info) VALUES
(1, '<product><name>Laptop</name><category>Electronics</category><price>1500.00</price><description>High performance laptop for work and gaming</description></product>'),
(2, '<product><name>Smartphone</name><category>Electronics</category><price>899.99</price><description>Latest model with high camera quality</description></product>'),
(3, '<product><name>Headphones</name><category>Electronics</category><price>250.00</price><description>Noise-cancelling over-ear headphones</description></product>'),
(4, '<product><name>Smartwatch</name><category>Electronics</category><price>200.00</price><description>Wearable device with fitness tracking</description></product>'),
(5, '<product><name>Tablet</name><category>Electronics</category><price>450.00</price><description>Portable tablet with 10-inch screen</description></product>'),
(6, '<product><name>Bluetooth Speaker</name><category>Electronics</category><price>120.00</price><description>Portable speaker with great sound quality</description></product>'),
(7, '<product><name>Monitor</name><category>Electronics</category><price>350.00</price><description>27-inch 4K UHD monitor for home office</description></product>'),
(8, '<product><name>Keyboard</name><category>Electronics</category><price>120.00</price><description>Mechanical keyboard with RGB lights</description></product>'),
(9, '<product><name>Mouse</name><category>Electronics</category><price>40.00</price><description>Wireless mouse with ergonomic design</description></product>'),
(10, '<product><name>Charger</name><category>Electronics</category><price>25.00</price><description>Fast charging USB-C charger</description></product>');



