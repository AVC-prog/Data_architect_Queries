-- Create a database for practice
CREATE DATABASE cte_practice;
USE cte_practice;

-- Create a table to store employee data
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    manager_id INT,  -- This references the employee's manager (self-referencing relationship)
    hire_date DATE,
    salary DECIMAL(10, 2),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

-- Insert sample data into the employees table
INSERT INTO employees (first_name, last_name, manager_id, hire_date, salary) VALUES
('Alice', 'Smith', NULL, '2020-01-15', 90000.00),
('Bob', 'Johnson', 1, '2021-02-20', 70000.00),
('Charlie', 'Williams', 1, '2021-03-10', 80000.00),
('Diana', 'Jones', 2, '2022-06-30', 60000.00),
('Elena', 'Brown', 2, '2022-07-01', 62000.00),
('Frank', 'Taylor', 3, '2023-01-25', 55000.00);
