-- Hash the password for user 'alice' using sha2 (256-bit) and update the password in the users table

update users 
set password = sha2('password123', 256) 
where username = 'alice';

-- Trim any leading and trailing spaces from the `profile_description` column for all users

update users 
set profile_description = trim(profile_description);

-- Get the first 3 characters of the `username` for all users

select username, left(username, 3) as first_three_characters
from users;

-- Get the last 5 characters of the `email` for all users

select email, right(email, 5) as last_five_characters
from users;

-- Extract the first 10 characters from the `profile_description` of each user

select username, profile_description, substring(profile_description, 1, 10) as short_profile_description
from users;

-- Find all users whose `profile_description` contains the word "developer"

select username, profile_description
from users
where profile_description like '%developer%';

-- Replace all occurrences of "tech" in the `profile_description` with "technology"

update users 
set profile_description = replace(profile_description, 'tech', 'technology');

-- Find all users whose email ends with "@example.com"

select username, email
from users
where email like '%@example.com';

-- Find all users whose `username` matches the pattern starting with "a" and ending with "e"

select username, email
from users
where username regexp '^a.*e$';

-- Hash the `password` field for all users using the sha2 function (256-bit)

update users
set password = sha2(password, 256);

-- Find all users whose `profile_description` contains a number (any digit)

select username, profile_description
from users
where profile_description regexp '[0-9]';

-- Update the `email` of the user 'bob' by replacing the domain part with 'newdomain.com'

update users
set email = concat(left(email, locate('@', email) - 1), '@newdomain.com')
where username = 'bob';

-- FInd all users whose `username` starts with "a" and has 4 or more characters

select username
from users
where username regexp '^a.{3,}$';

-- Update `profile_description` to capitalize the first letter of each word (note: use a function if needed)

update users
set profile_description = concat(upper(left(profile_description, 1)), substring(profile_description, 2));

-- Use sha2 to verify if the password is correct for 'alice' (hash and compare)

select username, password = sha2('password123', 256) as password_match
from users
where username = 'alice';
