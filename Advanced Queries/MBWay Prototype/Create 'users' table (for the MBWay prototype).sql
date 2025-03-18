use sql_hr;

create table users (
    account_id int primary key,
    password varchar(255) not null,
    password_hash varchar(64) not null
);

insert into users (account_id, password, password_hash)
values 
(1, 'Alice123!', sha2('Alice123!', 256)),
(2, 'BobSecure$', sha2('BobSecure$', 256)),
(3, 'Charlie@2024', sha2('Charlie@2024', 256)),
(4, 'DavidPass99', sha2('DavidPass99', 256)),
(5, 'EveBank$$', sha2('EveBank$$', 256)),
(6, 'FrankySecure99!', sha2('FrankySecure99!', 256)),
(7, 'Grace2024$$', sha2('Grace2024$$', 256)),
(8, 'HackerNot!123', sha2('HackerNot!123', 256)),
(9, 'IvyStrongPass', sha2('IvyStrongPass', 256)),
(10, 'Jack&Secure', sha2('Jack&Secure', 256)),
(11, 'KevinBank456', sha2('KevinBank456', 256)),
(12, 'LucySuper$', sha2('LucySuper$', 256)),
(13, 'MikeTopSecret', sha2('MikeTopSecret', 256)),
(14, 'NancySafe321', sha2('NancySafe321', 256)),
(15, 'OliverVault!', sha2('OliverVault!', 256));