use sql_invoicing;

CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    sale_amount DECIMAL(10,2),
    sale_date DATE
);

INSERT INTO sales (employee_name, department, sale_amount, sale_date) VALUES
('Alice', 'Electronics', 500.00, '2024-01-01'),
('Bob', 'Electronics', 700.00, '2024-01-02'),
('Charlie', 'Electronics', 400.00, '2024-01-03'),
('David', 'Furniture', 900.00, '2024-01-01'),
('Eve', 'Furniture', 1100.00, '2024-01-02'),
('Mah Boi','Clothing', 1100.00, '2025-01-01'),
('Frank', 'Furniture', 800.00, '2024-01-03'),
('Grace', 'Clothing', 300.00, '2024-01-01'),
('Hank', 'Clothing', 600.00, '2024-01-02'),
('Ivy', 'Clothing', 200.00, '2024-01-03');
