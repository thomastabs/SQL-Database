drop table customer cascade;
drop table orderr cascade;
drop table sale cascade;
drop table product cascade;
drop table ean_product cascade;
drop table supplier cascade;
drop table employee cascade;
drop table department cascade;
drop table workplace cascade;
drop table office cascade;
drop table warehouse cascade;
drop table pay cascade;
drop table containss cascade;
drop table process cascade;
drop table works cascade;
drop table delivery cascade;


----------------------------------------
-- Table Creation
----------------------------------------

------------------------------------------------------------------------------------------------------------------------------------
--- As restrições de integridade do modelo Entidade-Associação que não são passíveis de conversão para o modelo relacional são: 
--- (IC-1) Customers can only pay for the Sale of an Order they have placed themselves 
------------------------------------------------------------------------------------------------------------------------------------


create table customer
   (customer_number  integer not null,
    customer_name 	varchar(80)	not null,
    customer_email 	varchar(255)	not null unique,
    customer_address 	varchar(30)	not null,
    customer_phone		numeric(9) not null,
    constraint pk_customer primary key(customer_number));

-- Order table name is called orderr with 2 r's because of the keyword order --
create table orderr
   (order_num 	integer	not null,
    order_date date not null,
    customer_number  integer not null,
    constraint pk_order primary key(order_num),
    constraint fk_order_customer_num foreign key(customer_number) references customer(customer_number),
    -- IC-1: Every order (order num) must participate in the contains association --
    constraint fk_order_contains foreign key (order_num) references containss(contains_order_num));

create table sale 
   (sale_order_num integer not null,
    constraint pk_sale primary key(sale_order_num),
    constraint fk_sale_order_num foreign key(sale_order_num) references orderr(order_num));

create table product
   (product_sku varchar(8) not null,
    product_name varchar(80)	not null,
    product_description varchar(255) not null,
    product_price numeric(4,2) not null,
    constraint pk_product primary key(product_sku),
    -- IC-2: Every product (sku) must participate in the supply entity --
    constraint fk_product_supplier foreign key (product_sku) references supplier(supplier_product_sku),
    -- A product’s price must always be positive --
    constraint chk_positive_price CHECK (product_price > 0));

create table ean_product
   (ean_product_sku varchar(8) not null,
    ean_product_ean varchar(13) not null,
    constraint pk_ean_product primary key(ean_product_sku),
    constraint fk_ean_product_sku foreign key (ean_product_sku) references product(product_sku));

create table supplier
   (supplier_tin numeric(9) not null,
    supplier_name varchar(80)	not null,
    supplier_address varchar(30)	not null,
    supplier_product_sku varchar(8) not null,
    supplier_date date not null,
    constraint pk_supplier primary key (supplier_tin),
    constraint fk_supplier_product_sku foreign key (supplier_product_sku) references product(product_sku));

create table employee
   (employee_ssn numeric(9) not null,
    employee_tin numeric(9) not null unique,
    employee_bdate date not null,
    employee_name varchar(80)	not null,
    constraint pk_employee primary key (employee_ssn),
    -- IC-3: Every employee (ssn) must participate in the works association -- 
    constraint fk_employee_works foreign key (employee_ssn) references works(works_employee_ssn));

create table department
   (department_name varchar(80)	not null,
    constraint pk_department primary key (department_name));

create table workplace
   (workplace_address varchar(30) not null,
    workplace_lat decimal(8,6) not null unique,
    workplace_long decimal(9,6) not null unique,
    constraint pk_workplace primary key (workplace_address));

create table office
   (office_workplace_address varchar(30) not null,
    constraint pk_office primary key (office_workplace_address),
    constraint fk_office_workplace_address foreign key (office_workplace_address) references workplace(workplace_address));

create table warehouse
   (warehouse_workplace_address varchar(30) not null,
    constraint pk_warehouse primary key (warehouse_workplace_address),
    constraint fk_warehouse_workplace_address foreign key (warehouse_workplace_address) references workplace(workplace_address));

create table pay
   (pay_order_num integer not null,
    pay_customer_number integer not null,
    constraint pk_pay primary key (pay_order_num),
    constraint fk_pay_sale_order_num foreign key (pay_order_num) references sale(sale_order_num),
    constraint fk_pay_customer_number foreign key (pay_customer_number) references customer(customer_number));

-- Contains table name is called containss with 2 s's because of the keyword contain --
create table containss
   (contains_order_num integer not null,
    contains_product_sku varchar(8) not null,
    contains_qty integer not null,
    constraint pk_contains1 primary key (contains_order_num),
    constraint pk_contains2 primary key (contains_product_sku),
    constraint fk_contains_order_num foreign key (contains_order_num) references orderr(order_num),
    constraint fk_containss_product_sku foreign key (contains_product_sku) references product(product_sku));

create table process
   (process_order_num integer not null,
    process_employee_ssn numeric(9) not null,
    constraint pk_process1 primary key (process_order_num),
    constraint pk_process2 primary key (process_employee_ssn),
    constraint fk_process_order_num foreign key (process_order_num) references orderr(order_num));

create table works
   (works_employee_ssn numeric(9) not null,
    works_department_name varchar(80)	not null,
    works_workplace_address varchar(30) not null,
    constraint pk_works1 primary key (works_employee_ssn),
    constraint pk_works2 primary key (works_department_name),
    constraint pk_works3 primary key (works_workplace_address),
    constraint fk_works_employee_ssn foreign key (works_employee_ssn) references employee(employee_ssn),
    constraint fk_works_department_name foreign key (works_department_name) references department(department_name),
    constraint fk_works_workplace_address foreign key (works_workplace_address) references workplace(workplace_address));

create table delivery
   (delivery_warehouse_address varchar(30) not null,
    delivery_supplier_sku varchar(8) not null,
    delivery_supplier_tin numeric(9) not null,
    constraint pk_delivery1 primary key (delivery_warehouse_address),
    constraint pk_delivery2 primary key (delivery_supplier_sku),
    constraint pk_delivery3 primary key (delivery_supplier_tin),
    constraint fk_delivery_warehouse_address foreign key (delivery_warehouse_address) references warehouse(warehouse_workplace_address),
    constraint fk_delivery_supplier_sku foreign key (delivery_supplier_sku) references supplier(supplier_product_sku),
    constraint fk_delivery_supplier_tin foreign key (delivery_supplier_tin) references supplier(supplier_tin));
