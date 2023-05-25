DROP TABLE IF EXISTS customer CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS sale CASCADE;
DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS ean_product CASCADE;
DROP TABLE IF EXISTS supplier CASCADE;
DROP TABLE IF EXISTS employee CASCADE;
DROP TABLE IF EXISTS department CASCADE;
DROP TABLE IF EXISTS workplace CASCADE;
DROP TABLE IF EXISTS office CASCADE;
DROP TABLE IF EXISTS warehouse CASCADE;
DROP TABLE IF EXISTS pay CASCADE;
DROP TABLE IF EXISTS containss CASCADE;
DROP TABLE IF EXISTS process CASCADE;
DROP TABLE IF EXISTS works CASCADE;
DROP TABLE IF EXISTS delivery CASCADE;


----------------------------------------
-- Table Creation
----------------------------------------

------------------------------------------------------------------------------------------------------------------------------------
--- As restrições de integridade do modelo Entidade-Associação que não são passíveis de conversão para o modelo relacional são: 
--- (IC-1) Customers can only pay for the Sale of an Order they have placed themselves 
------------------------------------------------------------------------------------------------------------------------------------

create table customer
   (number INTEGER NOT NULL,
    name VARCHAR(80) NOT NULL,
    email VARCHAR(255) NOT NULL,
    UNIQUE(email),
    address VARCHAR(30)	NOT NULL,
    phone NUMERIC(9) NOT NULL,
    PRIMARY KEY(number));

-- Order table name is called orders because of the keyword order --
create table orders
   (order_num INTEGER NOT NULL,
    date DATE NOT NULL,
    customer_number INTEGER NOT NULL,
    PRIMARY KEY(order_num),
    FOREIGN KEY(customer_number) REFERENCES customer(number));
    -- IC-1: Every order (order num) must participate in the contains association --

create table product
   (sku VARCHAR(8) NOT NULL,
    name VARCHAR(80) NOT NULL,
    description VARCHAR(255) NOT NULL,
    price NUMERIC(4,2) NOT NULL,
    PRIMARY KEY (sku),
    -- A product’s price must always be positive --
    CHECK (price > 0));
    -- IC-2: Every product (sku) must participate in the supply entity --

-- Contains table name is called containss with 2 s's because of the keyword contain --
create table containss
   (order_num INTEGER NOT NULL,
    sku VARCHAR(8) NOT NULL,
    qty INTEGER NOT NULL,
    PRIMARY KEY (order_num, sku),
    FOREIGN KEY (order_num) REFERENCES orders(order_num),
    FOREIGN KEY (sku) REFERENCES product(sku));

create table sale 
   (order_num integer NOT NULL,
    PRIMARY KEY (order_num),
    FOREIGN KEY (order_num) REFERENCES orders(order_num));

create table supplier
   (tin NUMERIC(9) NOT NULL,
    name VARCHAR(80) NOT NULL,
    address VARCHAR(30)	NOT NULL,
    sku VARCHAR(8) NOT NULL,
    date DATE NOT NULL,
    PRIMARY KEY (tin),
    FOREIGN KEY (sku) REFERENCES product(sku));

create table ean_product
   (sku VARCHAR(8) NOT NULL,
    ean VARCHAR(13) NOT NULL,
    PRIMARY KEY (sku),
    FOREIGN KEY (sku) REFERENCES product(sku));

create table employee
   (ssn numeric(9) NOT NULL,
    tin numeric(9) NOT NULL unique,
    UNIQUE(tin),
    bdate DATE NOT NULL,
    name VARCHAR(80) NOT NULL,
    PRIMARY KEY (ssn));
    -- IC-3: Every employee (ssn) must participate in the works association --

create table department
   (name VARCHAR(80) NOT NULL,
    PRIMARY KEY (name));

create table workplace
   (address VARCHAR(30) NOT NULL,
    lat DECIMAL(8,6) NOT NULL,
    long decimal(9,6) NOT NULL,
    UNIQUE (lat, long),
    PRIMARY KEY (address));

create table office
   (address VARCHAR(30) NOT NULL,
    PRIMARY KEY (address),
    FOREIGN KEY (address) REFERENCES workplace(address));

create table warehouse
   (address VARCHAR(30) NOT NULL,
    PRIMARY KEY (address),
    FOREIGN KEY (address) REFERENCES workplace(address));

create table pay
   (order_num INTEGER NOT NULL,
    customer_number INTEGER NOT NULL,
    PRIMARY KEY (order_num),
    FOREIGN KEY (order_num) REFERENCES sale(order_num),
    FOREIGN KEY (customer_number) REFERENCES customer(number));

create table process
   (order_num INTEGER NOT NULL,
    ssn NUMERIC(9) NOT NULL,
    PRIMARY KEY (order_num, ssn),
    FOREIGN KEY (order_num) REFERENCES orders(order_num));

create table works
   (ssn NUMERIC(9) NOT NULL,
    name VARCHAR(80) NOT NULL,
    address VARCHAR(30) NOT NULL,
    PRIMARY KEY (ssn, name, address),
    FOREIGN KEY (ssn) REFERENCES employee(ssn),
    FOREIGN KEY (name) REFERENCES department(name),
    FOREIGN KEY (address) REFERENCES workplace(address));

create table delivery
   (address VARCHAR(30) NOT NULL,
    tin numeric(9) NOT NULL,
    PRIMARY KEY (address, tin),
    FOREIGN KEY (address) REFERENCES warehouse(address),
    FOREIGN KEY (tin) REFERENCES supplier(tin));
