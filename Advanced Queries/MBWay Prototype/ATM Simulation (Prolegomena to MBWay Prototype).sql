use sql_hr;

-- Transfer 10 dollars from Charlie to David

start transaction;

update bank_account
set balance = balance-10
where account_id = 3;

update bank_account
set balance = balance + 10
where account_id = 4;

commit;

-- Write a transaction that takes 30 dollars from Charlie if he has more than 500 dollars. 
-- If not, then rollback
-- Using if statements in MySQL must be used inside of stored procedures

delimiter $$

create procedure withdraw_charlie_1()
begin

select balance into @charlie_balance
from bank_account
where account_id = 3;

if @charlie_balance >= 500 then
    start transaction;
    update bank_account
    set balance = balance - 30
    where account_id = 3;
    commit;
else
    rollback;
end if;
end $$

delimiter ;

call withdraw_charlie_1();   -- to apply the withdrawl just run this

-- Create a Transaction log table, where it stores all of the procedures that have occurred

Create table Transaction_log(
transaction_id int auto_increment primary key,
account_id int,
transaction_type varchar(50),
transaction_amount dec(10,2),
transaction_date timestamp default current_timestamp
);

start transaction;
update bank_account
set balance = balance -5
where account_id = 4;

insert into Transaction_log(account_id, transaction_type, transaction_amount)
values (4,"Withdrawal",5);

update bank_account
set balance = balance + 5
where account_id = 5;

insert into Transaction_log(account_id, transaction_type, transaction_amount)
values (5,"Deposit",5);

commit;

-- Simulate an ATM, create a procedure that takes (sender_id, receiver_id,transfer_amount)
-- as arguments to make a transaction from one person to another and put it in the log table
-- check if the sender has enough money first, otherwise rollback


delimiter $$

create procedure Transfer_Funds(in sender_id int, in receiver_id int, in transfer_amount dec(10,2))
begin
declare select_balance dec(10,2);
select balance into select_balance
from bank_account
where account_id = sender_id;
if select_balance >= transfer_amount then
    start transaction;
    update bank_account set balance = balance - transfer_amount where account_id = sender_id;
    update bank_account set balance = balance + transfer_amount where account_id = receiver_id;
    insert into Transaction_log(account_id, transaction_type, transaction_amount)
    values (sender_id,"Withdrawal",transfer_amount),
           (receiver_id,"Deposit",transfer_amount);
	commit;
else
    rollback;
end if;
end $$

delimiter ;

call Transfer_Funds(4,5,500);

-- Check concurrency issues some other time
-- Check read committed and read uncommitted, repeatable read, serializable