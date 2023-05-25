-- IGNORE: Exemplo do Chat GPT --

-- Insert values into customer table
INSERT INTO customer (number, name, email, address, phone)
VALUES (1, 'John Doe', 'johndoe@example.com', '123 Main St', 123456789),
       (2, 'Jane Smith', 'janesmith@example.com', '456 Elm St', 987654321);

-- Insert values into orders table
INSERT INTO orders (order_num, date, customer_number)
VALUES (1, '2023-05-01', 1),
       (2, '2023-05-02', 2);

-- Insert values into product table
INSERT INTO product (sku, name, description, price)
VALUES ('P1', 'Product 1', 'Description of Product 1', 10.99),
       ('P2', 'Product 2', 'Description of Product 2', 19.99);

-- Insert values into containss table
INSERT INTO containss (order_num, sku, qty)
VALUES (1, 'P1', 2),
       (1, 'P2', 3),
       (2, 'P1', 1);

-- Insert values into sale table
INSERT INTO sale (order_num)
VALUES (1),
       (2);

-- Insert values into supplier table
INSERT INTO supplier (tin, name, address, sku, date)
VALUES (123456789, 'Supplier 1', '789 Oak St', 'P1', '2023-05-01'),
       (987654321, 'Supplier 2', '456 Pine St', 'P2', '2023-05-02');

-- Insert values into ean_product table
INSERT INTO ean_product (sku, ean)
VALUES ('P1', '1234567890123'),
       ('P2', '9876543210123');

-- Insert values into employee table
INSERT INTO employee (ssn, tin, bdate, name)
VALUES (111111111, 123456789, '1990-01-01', 'Employee 1'),
       (222222222, 987654321, '1995-02-02', 'Employee 2');

-- Insert values into department table
INSERT INTO department (name)
VALUES ('Department 1'),
       ('Department 2');

-- Insert values into workplace table
INSERT INTO workplace (address, lat, long)
VALUES ('123 Main St', 12.345678, -98.765432),
       ('456 Elm St', 98.765432, -12.345678);

-- Insert values into office table
INSERT INTO office (address)
VALUES ('123 Main St'),
       ('456 Elm St');

-- Insert values into warehouse table
INSERT INTO warehouse (address)
VALUES ('789 Oak St'),
       ('456 Pine St');

-- Insert values into pay table
INSERT INTO pay (order_num, customer_number)
VALUES (1, 1),
       (2, 2);

-- Insert values into process table
INSERT INTO process (order_num, ssn)
VALUES (1, 111111111),
       (2, 222222222);

-- Insert values into works table
INSERT INTO works (ssn, name, address)
VALUES (111111111, 'Department 1', '123 Main St'),
       (222222222, 'Department 2', '456 Elm St');

-- Insert values into delivery table
INSERT INTO delivery (address, tin)
VALUES ('789 Oak St', 123456789),
       ('456 Pine St', 987654321);

