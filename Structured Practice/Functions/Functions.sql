use sql_hr;

-- Create a function that returns the prices of products after a 10% tax raise

delimiter $$

create function Calculate(price dec(10,2)) returns dec(10,2)
deterministic   # this means it's injective or one-to-one
begin
return price*0.1 + price;
end $$

delimiter ;

select product_name, price, Calculate(price) as after_tax from Products;

-- Create a function that counts how many orders a customer has made

delimiter $$

create function CountCustomerOrders(cust_id int) returns int
reads sql data
begin
    declare order_count int;
    select count(*) into order_count from Orders where customer_id = cust_id;
    return order_count;
end $$

delimiter ;


select customer_name, CountCustomerOrders(customer_id) as total_orders from Customers;
