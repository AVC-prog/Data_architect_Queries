-- Practice indexes

-- Check if there’s an index on user_id by running the following query

show indexes from users;

-- Create a unique index on the email column in the users table. check that it exists

create unique index idx_email on users(email);

-- Create a full-text index on the profile_description column
-- This is best for full-text indexing for fast searching in text-heavy columns

create fulltext index idx_profile_description on users(profile_description);

select * 
from users 
where match(profile_description) against ('tech');

-- Create a spatial index on the coordinates column in the locations table

create spatial index idx_coordinates on locations(coordinates);

select * 
from locations 
where st_distance(coordinates, st_geomfromtext('point(-74.0060 40.7128)')) < 50000;

-- Create a composite index on user_id and order_date in the orders table
-- Composite indexes improve performance when filtering by multiple columns

create index idx_user_order_date on orders(user_id, order_date);

select * 
from orders 
where user_id = 1 and order_date between '2024-01-01' and '2024-01-31';

-- Create a descending index on the order_date column

create index idx_order_date_desc on orders(order_date desc);

select * 
from orders 
order by order_date desc limit 5;

-- Make the email index invisible

alter table users alter index idx_email invisible;

select * 
from users 
where email = 'alice@example.com';

alter table users alter index idx_email visible;

-- Drop the indexes/indicies

drop index idx_email on users;
