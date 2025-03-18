use sql_hr;

create table bank_account (
    account_id int primary key,
    account_holder varchar(100),
    balance decimal(10,2),
    work_status varchar(20) check (work_status in ('Worker', 'Unemployed')),
    phone_number varchar(15) check (phone_number regexp '^\+351\d{9}$|^\+36\d{9}$|^\+39\d{9}$')
);

insert into bank_account (account_id, account_holder, balance, work_status, phone_number)
values
(1, 'Alice', 1000.00, 'Worker', '+351912345678'),
(2, 'Bob', 1500.00, 'Unemployed', '+36 201234567'),
(3, 'Charlie', 2000.00, 'Worker', '+39 3312345678'),
(4, 'David', 1200.00, 'Worker', '+351923456789'),
(5, 'Eve', 2500.00, 'Unemployed', '+39 3412345678'),
(6, 'Frank', 800.00, 'Worker', '+36 301234567'),
(7, 'Grace', 3200.00, 'Unemployed', '+351934567890'),
(8, 'Hank', 2900.00, 'Worker', '+39 3512345678'),
(9, 'Ivy', 1750.00, 'Worker', '+36 711234567'),
(10, 'Jack', 2200.00, 'Unemployed', '+351987654321');

insert into bank_account (account_id, account_holder, balance, work_status, phone_number)
values
(11, 'michael', 1800.00, 'Worker', '+35192345'), -- Name not capitalized, phone number too short
(12, 'SARAh', 2600.00, 'Unemployed', '+99 123456789'), -- Name randomly capitalized, invalid country code
(13, 'J@ck', 1950.00, 'Worker', '+36-123-456-789'), -- Special character in name, phone format incorrect
(14, 'Emily', 3300.00, 'Worker', '00351 923456789'), -- Incorrect phone prefix (should start with +)
(15, 'Robert', 1200.00, 'Unemployed', '+35193456ABC') -- Non-numeric characters in phone number
;
