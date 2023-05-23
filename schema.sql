drop table borrower cascade;
drop table loan cascade;
drop table depositor cascade;
drop table account cascade;
drop table customer cascade;
drop table branch cascade;

----------------------------------------
-- Table Creation
----------------------------------------

create table customer
   (customer_name 	varchar(80)	not null unique,
    customer_street 	varchar(255)	not null,
    customer_address 	varchar(30)	not null,
    customer_phone		numeric(9)
    constraint pk_customer primary key(customer_name));

create table teste
   (branch_name 	varchar(80)	not null unique,
    branch_city 	varchar(30)	not null,
    assets 		numeric(16,4)	not null,
    constraint pk_branch primary key(branch_name));

create table account
   (account_number 	char(5)	not null unique,
    branch_name		varchar(80)	not null,
    balance 		numeric(16,4)	not null,
    constraint pk_account primary key(account_number),
    constraint fk_account_branch foreign key(branch_name) references branch(branch_name));

create table depositor
   (customer_name 	varchar(80)	not null,
    account_number 	char(5)	not null,
    constraint pk_depositor primary key(customer_name, account_number),
    constraint fk_depositor_customer foreign key(customer_name) references customer(customer_name),
    constraint fk_depositor_account foreign key(account_number) references account(account_number));

create table loan
   (loan_number 	char(5)	not null unique,
    branch_name		varchar(80) not null,
    amount 		numeric(16,4) not null,
    constraint pk_loan primary key(loan_number),
    constraint fk_loan_branch foreign key(branch_name) references branch(branch_name));

create table borrower
   (customer_name 	varchar(80) not null,
    loan_number 	char(5)	not null,
    constraint pk_borrower primary key(customer_name, loan_number),
    constraint fk_borrower_customer foreign key(customer_name) references customer(customer_name),
    constraint fk_borrower_loan foreign key(loan_number) references loan(loan_number));

