CREATE TABLE Employee_Sales (
    sale_id INT PRIMARY KEY,
    employee_id INT,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    sale_date DATE,
    sale_amount DECIMAL(10, 2),
    commission DECIMAL(10, 2),
    region VARCHAR(50)
);

INSERT INTO Employee_Sales (sale_id, employee_id, employee_name, department, sale_date, sale_amount, commission, region)
VALUES
(1, 101, 'John Doe', 'Sales', '2025-01-01', 1200.00, 120.00, 'East'),
(2, 102, 'Jane Smith', 'Sales', '2025-01-02', 2000.00, 200.00, 'West'),
(3, 103, 'Samuel Green', 'Marketing', '2025-01-03', 1500.00, 150.00, 'East'),
(4, 101, 'John Doe', 'Sales', '2025-01-04', 1800.00, 180.00, 'East'),
(5, 104, 'Emma Brown', 'HR', '2025-01-05', 500.00, 50.00, 'North'),
(6, 101, 'John Doe', 'Sales', '2025-01-06', 1100.00, 110.00, 'East'),
(7, 102, 'Jane Smith', 'Sales', '2025-01-07', 2300.00, 230.00, 'West'),
(8, 105, 'Michael White', 'Finance', '2025-01-08', 800.00, 80.00, 'South'),
(9, 103, 'Samuel Green', 'Marketing', '2025-01-09', 900.00, 90.00, 'East'),
(10, 104, 'Emma Brown', 'HR', '2025-01-10', 600.00, 60.00, 'North'),
(11, 105, 'Michael White', 'Finance', '2025-01-11', 1200.00, 120.00, 'South'),
(12, 101, 'John Doe', 'Sales', '2025-01-12', 2500.00, 250.00, 'East'),
(13, 102, 'Jane Smith', 'Sales', '2025-01-13', 1400.00, 140.00, 'West'),
(14, 103, 'Samuel Green', 'Marketing', '2025-01-14', 1800.00, 180.00, 'East'),
(15, 104, 'Emma Brown', 'HR', '2025-01-15', 750.00, 75.00, 'North'),
(16, 105, 'Michael White', 'Finance', '2025-01-16', 900.00, 90.00, 'South');
