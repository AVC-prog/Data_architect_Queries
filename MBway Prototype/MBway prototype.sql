use sql_hr;

-- This table will keep track of all transactions that occurred

create table transaction_log(
transaction_id int auto_increment primary key,
account_id int,
transaction_type varchar(50),
transaction_amount dec(10,2),
transaction_date timestamp default current_timestamp
);

delimiter $$

create function tax_apply(amount dec(10,2)) returns dec(10,2)  -- for 10% taxes on every transaction
deterministic
begin
    return amount*0.9;
end $$

delimmiter ;

delimiter $$

create function anual_bonus(balance dec(10,2))  -- for the yearly bonus that everyone gets, event appears later)
returns dec(10,2)
deterministic
begin
    return (balance*1.05 + 10);
end $$

delimiter ;

create view full_table as
select b.account_id, b.account_holder, b.balance, b.work_status, b.phone_number, u.password, u.password_hash
from bank_account b
join users u on u.account_id = b.account_id;


delimiter $$

create procedure transfer_funds(
    in sender_id int,
    in receiver_id int,
    in transfer_amount dec(10,2),
    in entered_password varchar(255)
)
begin
    declare sender_balance dec(10,2);
    declare transaction_count int;
    declare receiver_name varchar(50);
    declare receiver_phone varchar(15);
    declare transaction_limit dec(10,2) default 750.00;
    declare correct_password boolean;

    -- validate password
    select case when password_hash = sha2(entered_password, 256) then true else false end
    into correct_password
    from full_table
    where user_id = sender_id;

    if not correct_password then
        signal sqlstate '45000' set message_text = 'Incorrect password.';
    end if;

    -- check sender balance
    select balance into sender_balance
    from full_table
    where account_id = sender_id;

    if sender_balance < transfer_amount then
        signal sqlstate '45000' set message_text = 'Insufficient funds.';
    end if;

    -- count small transactions in last 24 hours
    select count(account_id) into transaction_count
    from transaction_log
    where account_id = sender_id
    and transaction_amount < 50
    and transaction_date >= now() - interval 1 day;

    -- can only make 3 small transactions (<50) per day
    if transaction_count > 3 then
        signal sqlstate '45000' set message_text = 'Too many small transfers.';
    end if;

    -- get receiver information
    select account_holder, phone_number into receiver_name, receiver_phone
    from full_table
    where account_id = receiver_id;

    -- validate receiver name (proper case)
    if receiver_name not regexp '^[A-Z][a-z]+' then
        signal sqlstate '45000' set message_text = 'Invalid name.';
    end if;

    -- validate receiver phone number (allowed countries: Portugal, Spain, and Italy)
    if not (receiver_phone like '+351%' or 
            receiver_phone like '+39%' or 
            receiver_phone like '+34%') then
        signal sqlstate '45000' set message_text = 'Invalid phone number.';
    end if;

    -- validate transaction limit
    if transfer_amount > transaction_limit then
        signal sqlstate '45000' set message_text = 'transaction amount is too high.';
    end if;

    -- start transaction only if all of the above conditions are met
    start transaction;
        update full_table
        set balance = balance - transfer_amount 
        where account_id = sender_id;

        update full_table 
        set balance = balance + (transfer_amount * 0.9) 
        where account_id = receiver_id;

        insert into transaction_log(account_id, transaction_type, transaction_amount)
        values 
            (sender_id, "withdrawal", transfer_amount),
            (receiver_id, "deposit", tax_apply(transfer_amount));
    commit;
end;  $$



delimiter ;

delimiter $$

create event yearly_bonus;
on schedule every 1 year
begin
   update full_table
   set balance = anual_bonus(balance)
end

delimiter ;

-- adding indexes
create index idx_transaction_date on transaction_log(transaction_date);
create index idx_sender_receiver on transaction_log(account_id, transaction_type);

-- adding trigger for automatic auditing
delimiter $$

create trigger after_transfer_fund
after insert on transaction_log
for each row
begin
    -- audit log
    insert into transaction_audit_log(transaction_id, transaction_type, sender_id, receiver_id, timestamp)
    values (new.transaction_id, new.transaction_type, new.account_id, new.receiver_id, now());

    -- if the transaction type is 'withdrawal' and amount is high, trigger review
    if new.transaction_type = 'withdrawal' and new.transaction_amount > 5000 then
        call trigger_high_value_review(new.transaction_id);
    end if;
end $$

delimiter ;

delimiter $$

create trigger balance_update_trigger
after update on full_table
for each row
begin
    if new.balance < 0 then
        signal sqlstate '45000' set message_text = 'balance cannot be negative';
    end if;

    -- example of auditing balance changes
    insert into balance_audit(account_id, old_balance, new_balance, change_date)
    values (new.account_id, old.balance, new.balance, now());
end $$

delimiter ;
