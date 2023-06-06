DROP TABLE IF EXISTS customer CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS pay CASCADE;
DROP TABLE IF EXISTS employee CASCADE;
DROP TABLE IF EXISTS process CASCADE;
DROP TABLE IF EXISTS department CASCADE;
DROP TABLE IF EXISTS workplace CASCADE;
DROP TABLE IF EXISTS works CASCADE;
DROP TABLE IF EXISTS office CASCADE;
DROP TABLE IF EXISTS warehouse CASCADE;
DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS contains CASCADE;
DROP TABLE IF EXISTS supplier CASCADE;
DROP TABLE IF EXISTS delivery CASCADE;

CREATE TABLE customer (
    cust_no INTEGER PRIMARY KEY,
    name VARCHAR(80) NOT NULL,
    email VARCHAR(254) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(255)
);

CREATE TABLE orders (
    order_no INTEGER PRIMARY KEY,
    cust_no INTEGER NOT NULL REFERENCES customer,
    date DATE NOT NULL
    --order_no must exist in contains
);

CREATE TABLE pay(
    order_no INTEGER PRIMARY KEY REFERENCES orders,
    cust_no INTEGER NOT NULL REFERENCES customer
);

CREATE TABLE employee(
    ssn VARCHAR(20) PRIMARY KEY,
    TIN VARCHAR(20) UNIQUE NOT NULL,
    bdate DATE,
    name VARCHAR NOT NULL
    --age must be >=18
);

CREATE TABLE process(
    ssn VARCHAR(20) REFERENCES employee,
    order_no INTEGER REFERENCES orders,
    PRIMARY KEY (ssn, order_no)
);

CREATE TABLE department(
    name VARCHAR PRIMARY KEY
);

CREATE TABLE workplace(
    address VARCHAR PRIMARY KEY,
    lat NUMERIC(8, 6) NOT NULL,
    long NUMERIC(9, 6) NOT NULL,
    UNIQUE(lat, long)
    --address must be either in warehouse or office
    --address cannot be both in warehouse and office simultaneously
);

CREATE TABLE office(
    address VARCHAR(255) PRIMARY KEY REFERENCES workplace
);

CREATE TABLE warehouse(
    address VARCHAR(255) PRIMARY KEY REFERENCES workplace
);

CREATE TABLE works(
    ssn VARCHAR(20) REFERENCES employee,
    name VARCHAR(200) REFERENCES department,
    address VARCHAR(255) REFERENCES workplace,
    PRIMARY KEY (ssn, name, address)
);

CREATE TABLE product(
    SKU VARCHAR(25) PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description VARCHAR,
    price NUMERIC(10, 2) NOT NULL,
    ean NUMERIC(13) UNIQUE
);

CREATE TABLE contains(
    order_no INTEGER REFERENCES orders,
    SKU VARCHAR(25) REFERENCES product,
    qty INTEGER,
    PRIMARY KEY (order_no, SKU)
);

CREATE TABLE supplier(
    TIN VARCHAR(20) PRIMARY KEY,
    name VARCHAR(200),
    address VARCHAR(255),
    SKU VARCHAR(25) REFERENCES product,
    date DATE
);

CREATE TABLE delivery(
    address VARCHAR(255) REFERENCES warehouse,
    TIN VARCHAR(20) REFERENCES supplier,
    PRIMARY KEY (address, TIN)
);


INSERT INTO product VALUES ('10000001', 'Vassoura', 'Vassoura de qualidade industrial', '4.20', '345678');
INSERT INTO product VALUES ('10000002', 'Detergente', 'Detergente multi usos tão bom que o Fairy até chora', '9.60');
INSERT INTO product VALUES ('10000003', 'Walkman', ' Sony Walkman - dispositivo de audição de música em cassete de alta qualidade', '300.00', '12345');
INSERT INTO product VALUES ('10000004', 'Batatas', 'Saco de batatas irlandesas recem colhidas', '6.90');
INSERT INTO product VALUES ('10000005', 'PS5', 'Consola Playstation de nova geração', '500', ' 565656');
INSERT INTO product VALUES ('10000006', 'Geforce RTX 3060', 'Placa Gráfica Geforce RTX da NVIDIA', '300');
INSERT INTO product VALUES ('10000007', 'Cooler', 'Sistema de Arrefecimento para um computador', '70', ' 232323');
INSERT INTO product VALUES ('10000008', 'Fonte de Alimentação', 'Fonte de Energia para um computador', '90');
INSERT INTO product VALUES ('10000009', 'SSD de 500gb', 'Armazenamento SSD de tamanho 500gb', '120', ' 1212');
INSERT INTO product VALUES ('10000010', '12Gb de RAM', '2 cartões de RAM que juntos fazem 12 GB', '200');

INSERT INTO customer VALUES ('1', 'Adams', 'adams12345@gmail.com', '918138586');
INSERT INTO customer VALUES ('2', 'John', 'johnxina@gmail.com', '918134543');
INSERT INTO customer VALUES ('3', 'Bob', 'bob12345@gmail.com', '923423452');
INSERT INTO customer VALUES ('4', 'Steve', 'steve12345@gmail.com', '917123411');
INSERT INTO customer VALUES ('5', 'Leon', 'leon1234@gmail.com', '919519439');
INSERT INTO customer VALUES ('6', 'Ashley', 'ashley1234@gmail.com', '918410660');
INSERT INTO customer VALUES ('7', 'Thomas', 'thomas1234@gmail.com', '921324777');
INSERT INTO customer VALUES ('8', 'Will', 'will1234@gmail.com', '911222111');
INSERT INTO customer VALUES ('9', 'Tyler', 'tyler1234@gmail.com', '920988756');
INSERT INTO customer VALUES ('10', 'Drake', 'drake1234@gmail.com', '965888232');

INSERT INTO orders VALUES ('1', '1', '2023-01-04');
INSERT INTO orders VALUES ('2', '2', '2023-02-10');
INSERT INTO orders VALUES ('3', '1', '2023-01-17');
INSERT INTO orders VALUES ('4', '3', '2023-01-23');
INSERT INTO orders VALUES ('5', '4', '2023-05-11');
INSERT INTO orders VALUES ('6', '5', '2023-09-02');
INSERT INTO orders VALUES ('7', '6', '2023-11-29');
INSERT INTO orders VALUES ('8', '8', '2023-04-01');
INSERT INTO orders VALUES ('9', '5', '2023-03-05');
INSERT INTO orders VALUES ('10', '7', '2023-08-16');
INSERT INTO orders VALUES ('11', '7', '2023-01-21');
INSERT INTO orders VALUES ('12', '9', '2023-05-04');
INSERT INTO orders VALUES ('13', '10', '2023-07-02');
INSERT INTO orders VALUES ('14', '2', '2023-11-13');
INSERT INTO orders VALUES ('15', '1', '2023-09-19');

INSERT INTO employee VALUES ('111111111', '123456789', '1990-01-01', 'Tomás');
INSERT INTO employee VALUES ('222222222', '987654321', '1995-02-02', 'Mateus');
INSERT INTO employee VALUES ('333333333', '123112323', '1999-04-29', 'Rodrigo');
INSERT INTO employee VALUES ('444444444', '321999872', '1989-01-29', 'Maia');
INSERT INTO employee VALUES ('555555555', '233333444', '1991-08-14', 'Fábio');
INSERT INTO employee VALUES ('666666666', '555554444', '1992-12-03', 'José');
INSERT INTO employee VALUES ('777777777', '666666664', '1993-10-08', 'Nelson');
INSERT INTO employee VALUES ('888888888', '232324444', '1994-06-09', 'Isabel');
INSERT INTO employee VALUES ('999999999', '111111144', '1995-07-12', 'Gonçalo');
INSERT INTO employee VALUES ('100000000', '555444777', '1996-09-21', 'João');
INSERT INTO employee VALUES ('100111111', '565656565', '1997-11-01', 'Vicente');
INSERT INTO employee VALUES ('100222222', '000999000', '1998-05-08', 'Amadeu');
INSERT INTO employee VALUES ('100333333', '777777773', '1999-02-09', 'Maria');
INSERT INTO employee VALUES ('100444444', '111222233', '2000-03-10', 'Alice');
INSERT INTO employee VALUES ('100555555', '088887700', '2007-07-15', 'Joana');

INSERT INTO process VALUES ('111111111', '1');
INSERT INTO process VALUES ('222222222', '2');
INSERT INTO process VALUES ('333333333', '3');
INSERT INTO process VALUES ('444444444', '4');
INSERT INTO process VALUES ('555555555', '5');
INSERT INTO process VALUES ('666666666', '6');
INSERT INTO process VALUES ('777777777', '7');
INSERT INTO process VALUES ('888888888', '8');
INSERT INTO process VALUES ('999999999', '9');
INSERT INTO process VALUES ('100000000', '10');
INSERT INTO process VALUES ('100111111', '11');
INSERT INTO process VALUES ('100222222', '12');
INSERT INTO process VALUES ('100333333', '13');
INSERT INTO process VALUES ('100444444', '14');
INSERT INTO process VALUES ('100555555', '15');

INSERT INTO department VALUES ('Department A');
INSERT INTO department VALUES ('Department B');
INSERT INTO department VALUES ('Department C');
INSERT INTO department VALUES ('Department D');
INSERT INTO department VALUES ('Department E');

INSERT INTO workplace VALUES ('Rua Amor Perfeito 2745-766 Queluz', '38.736946', '-9.142685');
INSERT INTO workplace VALUES ('Praceta Columbano Bordalo Pinheiro T 2745-258 Queluz', '98.765432', '-12.345678');
INSERT INTO workplace VALUES ('Avenida Candido Oliveira 2725-178 Algueirão-Mem Martins', '76.345678', '-48.123432');
INSERT INTO workplace VALUES ('Rua Ribeiro dos Reis 2725-175 Algueirão-Mem Martins', '91.432432', '-19.367688');
INSERT INTO workplace VALUES ('Rua Domingos da Cunha 2725-079 Algueirão-Mem Martins', '21.476542', '-65.456987');
INSERT INTO workplace VALUES ('Rua dos Lírios 2725-368 Algueirão-Mem Martins', '97.234221', '-23.234388');

INSERT INTO warehouse VALUES ('Rua Amor Perfeito 2745-766 Queluz');
INSERT INTO warehouse VALUES ('Praceta Columbano Bordalo Pinheiro T 2745-258 Queluz');
INSERT INTO warehouse VALUES ('Avenida Candido Oliveira 2725-178 Algueirão-Mem Martins');

INSERT INTO office VALUES ('Rua Ribeiro dos Reis 2725-175 Algueirão-Mem Martins');
INSERT INTO office VALUES ('Rua Domingos da Cunha 2725-079 Algueirão-Mem Martins');
INSERT INTO office VALUES ('Rua dos Lírios 2725-368 Algueirão-Mem Martins');

INSERT INTO works VALUES ('111111111','Department A','Rua Amor Perfeito 2745-766 Queluz');
INSERT INTO works VALUES ('222222222','Department B','Praceta Columbano Bordalo Pinheiro T 2745-258 Queluz');
INSERT INTO works VALUES ('333333333','Department C','Avenida Candido Oliveira 2725-178 Algueirão-Mem Martins');
INSERT INTO works VALUES ('444444444','Department D','Rua Ribeiro dos Reis 2725-175 Algueirão-Mem Martins');
INSERT INTO works VALUES ('555555555','Department E','Rua Domingos da Cunha 2725-079 Algueirão-Mem Martins');
INSERT INTO works VALUES ('666666666','Department A','Rua dos Lírios 2725-368 Algueirão-Mem Martins');
INSERT INTO works VALUES ('777777777','Department B','Rua Amor Perfeito 2745-766 Queluz');
INSERT INTO works VALUES ('888888888','Department C','Praceta Columbano Bordalo Pinheiro T 2745-258 Queluz');
INSERT INTO works VALUES ('999999999','Department D','Avenida Candido Oliveira 2725-178 Algueirão-Mem Martins');
INSERT INTO works VALUES ('100000000','Department E','Rua Ribeiro dos Reis 2725-175 Algueirão-Mem Martins');
INSERT INTO works VALUES ('100111111','Department A','Rua Domingos da Cunha 2725-079 Algueirão-Mem Martins');
INSERT INTO works VALUES ('100222222','Department B','Rua dos Lírios 2725-368 Algueirão-Mem Martins');
INSERT INTO works VALUES ('100333333','Department C','Rua Amor Perfeito 2745-766 Queluz');
INSERT INTO works VALUES ('100444444','Department D','Praceta Columbano Bordalo Pinheiro T 2745-258 Queluz');
INSERT INTO works VALUES ('100555555','Department E','Avenida Candido Oliveira 2725-178 Algueirão-Mem Martins');

INSERT INTO supplier VALUES ('200000001','Diogo','Avenida Prof. Dr. Cavaco Silva 2744-016 Porto Salvo');
INSERT INTO supplier VALUES ('200000002','André','Estr. Ligeiras 2735-337 Agualva-Cacém');
INSERT INTO supplier VALUES ('200000003','Jose','Rua Vitor Alves 2730-250 Agualva-Cacém');
INSERT INTO supplier VALUES ('200000004','Tiago','Rua Urano 13 2635-265 Rio de Mouro');
INSERT INTO supplier VALUES ('200000005','Eusébio','Rua Marquês Pombal 2635-600 Rio de Mouro');
INSERT INTO supplier VALUES ('200000006','Joseph','Rua dos Lírios 2725-341 Algueirão-Mem Martins');
INSERT INTO supplier VALUES ('200000007','Jamal','Estr. Mem Martins 2725-389 Algueirão-Mem Martins');
INSERT INTO supplier VALUES ('200000008','Jotaro','Avenida Dr. António Nabais 2605-164 Belas');
INSERT INTO supplier VALUES ('200000009','Josuke','Avenida Pedro Álvares Cabral 2710-297 Sintra');
INSERT INTO supplier VALUES ('200000010','Jolyne','Rua República da Coreia 2710-116 Sintra');

INSERT INTO delivery VALUES ('Rua Amor Perfeito 2745-766 Queluz','200000001');
INSERT INTO delivery VALUES ('Praceta Columbano Bordalo Pinheiro T 2745-258 Queluz','200000002');
INSERT INTO delivery VALUES ('Avenida Candido Oliveira 2725-178 Algueirão-Mem Martins','200000003');
INSERT INTO delivery VALUES ('Rua Amor Perfeito 2745-766 Queluz','200000004');
INSERT INTO delivery VALUES ('Praceta Columbano Bordalo Pinheiro T 2745-258 Queluz','200000005');
INSERT INTO delivery VALUES ('Avenida Candido Oliveira 2725-178 Algueirão-Mem Martins','200000006');
INSERT INTO delivery VALUES ('Rua Amor Perfeito 2745-766 Queluz','200000007');
INSERT INTO delivery VALUES ('Praceta Columbano Bordalo Pinheiro T 2745-258 Queluz','200000008');
INSERT INTO delivery VALUES ('Avenida Candido Oliveira 2725-178 Algueirão-Mem Martins','200000009');
INSERT INTO delivery VALUES ('Rua Amor Perfeito 2745-766 Queluz','200000010');

INSERT INTO contains VALUES ('1','10000001','3');
INSERT INTO contains VALUES ('1','10000002','5');
INSERT INTO contains VALUES ('2','10000003','1');
INSERT INTO contains VALUES ('3','10000001','2');
INSERT INTO contains VALUES ('4','10000004','2');
INSERT INTO contains VALUES ('4','10000002','1');
INSERT INTO contains VALUES ('5','10000005','1');
INSERT INTO contains VALUES ('6','10000006','2');
INSERT INTO contains VALUES ('6','10000007','1');
INSERT INTO contains VALUES ('7','10000008','1');
INSERT INTO contains VALUES ('7','10000003','2');
INSERT INTO contains VALUES ('7','10000001','1');
INSERT INTO contains VALUES ('8','10000008','2');
INSERT INTO contains VALUES ('9','10000009','2');
INSERT INTO contains VALUES ('10','10000010','1');
INSERT INTO contains VALUES ('10','10000008','2');

INSERT INTO pay VALUES ('1','1');
INSERT INTO pay VALUES ('2','2');
INSERT INTO pay VALUES ('3','1');
INSERT INTO pay VALUES ('4','3');
INSERT INTO pay VALUES ('5','4');
INSERT INTO pay VALUES ('6','5');
INSERT INTO pay VALUES ('7','6');
INSERT INTO pay VALUES ('8','8');

