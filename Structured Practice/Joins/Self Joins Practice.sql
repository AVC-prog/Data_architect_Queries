use self_joins;

-- Find the names of employees along with their manager’s name.

select e.name as employee_name, m.name as manager_name
from employees e
left join employees m on m.employee_id=e.manager_id;

-- Find customers who referred at least one other customer,
-- along with the count of people they referred.

select r.name as refered_name, count(r.name) as amount
from customers c
join customers r on r.customer_id = c.referred_by
group by r.customer_id
having count(r.customer_id) > 0;

-- Find the flights that are possible to have (giving 1 to 4 hours to prepare for the next)

select *
from flights f1
join flights f2 on f2.departure_city = f1.arrival_city
where timestampdiff(hour, f1.arrival_time, f2.departure_time) between 1 and 4;


