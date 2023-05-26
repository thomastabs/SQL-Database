-- Inserting example values into the tables --

INSERT INTO customer VALUES (1, 'Adams', 'adams12345@gmail.com',	'Avenida das Bases de Dados',	918138586);
INSERT INTO customer VALUES (2, 'John', 'johnxina@gmail.com',	'Avenida da Interação',	918134543);
INSERT INTO customer VALUES (3, 'Bob', 'bob12345@gmail.com',	'Avenida das Probabilidades', 923423452);
INSERT INTO customer VALUES (4, 'Steve', 'steve12345@gmail.com',	'Avenida dos Sistemas e Sinais', 917123411);

INSERT INTO orders VALUES (1, '2023-01-04', 1);
INSERT INTO orders VALUES (2, '2023-01-10', 2);
INSERT INTO orders VALUES (3, '2023-01-17', 1);
INSERT INTO orders VALUES (4, '2023-01-23', 3);

INSERT INTO sale VALUES (1);
INSERT INTO sale VALUES (2);
INSERT INTO sale VALUES (3);
INSERT INTO sale VALUES (4);

INSERT INTO product VALUES (10000001, 'Vassoura', 'Vassoura de qualidade industrial', 4.20);
INSERT INTO product VALUES (10000002, 'Detergente', 'Detergente multi usos, tão bom que o Fairy até chora', 9.60);
INSERT INTO product VALUES (10000003, 'Walkman', 'Sony Walkman, dispositivo de audição de música em cassete de alta qualidade', 300.00);
INSERT INTO product VALUES (10000004, 'Batatas', 'Saco de batatas irlandesas recem colhidas', 6.90);

INSERT INTO ean_product VALUES (10000003, '1234567890123');
INSERT INTO ean_product VALUES (10000004, '9876543219876');

-- Suppliers normais --
INSERT INTO supplier VALUES (200000001, 'Diogo', 'Rua do Cálculo', 10000001, '2023-01-01');
INSERT INTO supplier VALUES (200000002, 'André', 'Rua da Álgebra', 10000002, '2023-03-06');

-- Suppliers de EAN Products --
INSERT INTO supplier VALUES (200000003, 'Jose', 'Rua de MO', 10000003, '2023-02-11');
INSERT INTO supplier VALUES (200000004, 'Tiago', 'Rua de EO', 10000004, '2023-09-11');

INSERT INTO employee VALUES (111111111, 123456789, '1990-01-01', 'Tomás');
INSERT INTO employee VALUES (222222222, 987654321, '1995-02-02', 'Mateus');
INSERT INTO employee VALUES (333333333, 123112323, '1999-04-29', 'Rodrigo');
INSERT INTO employee VALUES (444444444, 321999872, '1989-01-29', 'Maia');

INSERT INTO department VALUES ('Department 1');
INSERT INTO department VALUES ('Department 2');
INSERT INTO department VALUES ('Department 3');
INSERT INTO department VALUES ('Department 4');
INSERT INTO department VALUES ('Department 5');

INSERT INTO workplace VALUES ('Rua do Amor Perfeito', 12.345678, -98.765432);
INSERT INTO workplace VALUES ('Avenida do Ódio Imperfeito', 98.765432, -12.345678);
INSERT INTO workplace VALUES ('Avenida Candido Oliveira', 76.345678, -48.123432);
INSERT INTO workplace VALUES ('Rua Ribeiro dos Reis', 91.432432, -19.367688);
INSERT INTO workplace VALUES ('Avenida do MrBeast', 21.476542, -65.456987);

INSERT INTO office VALUES ('Rua do Amor Perfeito');
INSERT INTO office VALUES ('Avenida do Ódio Imperfeito');
INSERT INTO office VALUES ('Avenida do MrBeast');

INSERT INTO warehouse VALUES ('Avenida Candido Oliveira');
INSERT INTO warehouse VALUES ('Rua Ribeiro dos Reis');
INSERT INTO warehouse VALUES ('Avenida do MrBeast');

INSERT INTO pay VALUES (1, 1);
INSERT INTO pay VALUES (2, 2);
INSERT INTO pay VALUES (3, 3);
INSERT INTO pay VALUES (4, 4);

INSERT INTO process VALUES (1, 111111111);
INSERT INTO process VALUES (2, 222222222);
INSERT INTO process VALUES (3, 333333333);
INSERT INTO process VALUES (4, 444444444);

INSERT INTO works VALUES (111111111, 'Department 1', 'Rua do Amor Perfeito');
INSERT INTO works VALUES (222222222, 'Department 2', 'Avenida do Ódio Imperfeito');
INSERT INTO works VALUES (333333333, 'Department 3', 'Avenida Candido Oliveira');
INSERT INTO works VALUES (444444444, 'Department 4', 'Rua Ribeiro dos Reis');
INSERT INTO works VALUES (444444444, 'Department 5', 'Avenida do MrBeast');

INSERT INTO delivery VALUES ('Avenida Candido Oliveira', 200000001);
INSERT INTO delivery VALUES ('Rua Ribeiro dos Reis', 200000002);
INSERT INTO delivery VALUES ('Avenida do MrBeast', 200000003);

INSERT INTO contains VALUES



