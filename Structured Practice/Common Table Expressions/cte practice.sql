-- use a cte to filter employees based on salary
with high_salary_employees as (
    select first_name, last_name, salary
    from employees
    where salary > 60000
)
select * from high_salary_employees;

-- use a cte to calculate the average salary and select employees with higher salary
with average_salary as (
    select avg(salary) as avg_salary
    from employees
)
select first_name, last_name, salary
from employees, average_salary
where employees.salary > average_salary.avg_salary;

-- use a cte to join employees with their managers
with employee_managers as (
    select e.employee_id, e.first_name as employee_first_name, e.last_name as employee_last_name,
           m.first_name as manager_first_name, m.last_name as manager_last_name
    from employees e
    left join employees m on e.manager_id = m.employee_id
)
select * from employee_managers;

-- use a recursive cte to generate a hierarchy of employees and managers
with recursive employee_hierarchy as (
    select employee_id, first_name, last_name, manager_id  -- anchor member: select employees with no manager (top-level employees)
    from employees
    where manager_id is null
    union all
    select e.employee_id, e.first_name, e.last_name, e.manager_id
    from employees e
    join employee_hierarchy eh on e.manager_id = eh.employee_id
)
select * from employee_hierarchy;
