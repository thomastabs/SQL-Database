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

INSERT INTO customer VALUES ('1', 'Adams', 'adams12345@gmail.com', '918138586', 'Rua Ribeiro dos Reis 2725-175 Algueirão-Mem Martins');
INSERT INTO customer VALUES ('2', 'John', 'johnxina@gmail.com', '918134543', 'Rua João Chagas 1495-765 Oeiras');
INSERT INTO customer VALUES ('3', 'Bob', 'bob12345@gmail.com', '923423452', 'Rua Combatentes do Ultramar 2670-515 Loures');
INSERT INTO customer VALUES ('4', 'Steve', 'steve12345@gmail.com', '917123411', 'Rua Brito Capelo 4050-128 Porto');
INSERT INTO customer VALUES ('5', 'Leon', 'leon1234@gmail.com', '919519439', 'Rua Conde de Valença 7470-120 Sousel');
INSERT INTO customer VALUES ('6', 'Ashley', 'ashley1234@gmail.com', '918410660', 'Rua Manuel da SIlva Carolino 2460-197 Alcobaça');
INSERT INTO customer VALUES ('7', 'Thomas', 'thomas1234@gmail.com', '921324777', 'Rua Helena Tavares 2725-059 Algueirão-Mem Martins');
INSERT INTO customer VALUES ('8', 'Will', 'will1234@gmail.com', '911222111', 'Rua Fernando Peyroteo 2725-079 Algueirão-Mem Martins');
INSERT INTO customer VALUES ('9', 'Tyler', 'tyler1234@gmail.com', '920988756', 'Praceta Diogo de Silves 2710-725 Sintra');
INSERT INTO customer VALUES ('10', 'Drake', 'drake1234@gmail.com', '965888232', 'Avenida Raul Solnado 2710-204 Sintra');
INSERT INTO customer VALUES ('11', 'Joseph', 'joseph567@gmail.com', '914756283', 'Rua Cedros 2635-047 Rio de Mouro');
INSERT INTO customer VALUES ('12', 'George', 'georgeofthejungle@gmail.com', '917485629', 'Rua Luís de Pina 2740-171 Porto Salvo');
INSERT INTO customer VALUES ('13', 'Fabian', 'fabian123@gmail.com', '968374829', 'Tv. Bairro 2635-047 Rio de Mouro');
INSERT INTO customer VALUES ('14', 'Francis', 'francis321@gmail.com', '917359198', 'Rua Doutor Coutinho Pais 2770-180 Paço de Arcos');
INSERT INTO customer VALUES ('15', 'Maggie', 'maggie234@gmail.com', '962848626', 'Rua São Salvador da Baía 2780-038 Oeiras');
INSERT INTO customer VALUES ('16', 'Regis', 'regie789@gmail.com', '9126357489', 'Rua Silva Lobo 2765-034 Estoril');
INSERT INTO customer VALUES ('17', 'Cole', 'cole123@gmail.com', '9678364699', 'Rua Moinho 2765-311 Estoril');
INSERT INTO customer VALUES ('18', 'James', 'jamie42@gmail.com', '917829457', 'Rua António Jacinto da Silva 2645-543 Alcabideche');
INSERT INTO customer VALUES ('19', 'Richard', 'rich456@gmail.com', '966678899', 'Rua Gingeira 2645-124 Alcabideche');
INSERT INTO customer VALUES ('20', 'Harris', 'harris321@gmail.com', '962384573', 'Rua Gladíolos 2750-247 Cascais');
INSERT INTO customer VALUES ('21', 'Jeremy', 'jeremyc1@gmail.com', '910634847', 'Rua Glicínias 2750-236 Cascais');
INSERT INTO customer VALUES ('22', 'Kelly', 'kelly123@gmail.com', '917875943', 'Rua Falcão Trigoso 2750-004 Cascais');
INSERT INTO customer VALUES ('23', 'Alex', 'alex345@gmail.com', '963728450', 'Rua Rio da Costa 2645-175 Alcabideche');
INSERT INTO customer VALUES ('24', 'Kate', 'kate987@gmail.com', '912736450', 'Rua do Geraldo 2645-167 Alcabideche');
INSERT INTO customer VALUES ('25', 'Harry', 'harry345@gmail.com', '912345678', 'Tv. João de Deus 2710-431 Sintra');

START TRANSACTION;
SET CONSTRAINTS ALL DEFERRED;

INSERT INTO orders VALUES ('1', '1', '2022-01-04');
INSERT INTO orders VALUES ('2', '2', '2022-02-10');
INSERT INTO orders VALUES ('3', '1', '2022-01-17');
INSERT INTO orders VALUES ('4', '3', '2022-01-23');
INSERT INTO orders VALUES ('5', '4', '2022-05-11');
INSERT INTO orders VALUES ('6', '5', '2022-09-02');
INSERT INTO orders VALUES ('7', '6', '2022-11-29');
INSERT INTO orders VALUES ('8', '8', '2022-04-01');
INSERT INTO orders VALUES ('9', '5', '2022-03-05');
INSERT INTO orders VALUES ('10', '7', '2022-08-16');
INSERT INTO orders VALUES ('11', '7', '2022-01-21');
INSERT INTO orders VALUES ('12', '9', '2022-05-04');
INSERT INTO orders VALUES ('13', '10', '2022-07-02');
INSERT INTO orders VALUES ('14', '2', '2022-11-13');
INSERT INTO orders VALUES ('15', '1', '2022-09-19');
INSERT INTO orders VALUES ('16', '3', '2022-10-21');
INSERT INTO orders VALUES ('17', '4', '2022-10-29');
INSERT INTO orders VALUES ('18', '6', '2022-10-31');
INSERT INTO orders VALUES ('19', '18', '2022-11-06');
INSERT INTO orders VALUES ('20', '11', '2022-11-17');
INSERT INTO orders VALUES ('21', '10', '2022-11-21');
INSERT INTO orders VALUES ('22', '8', '2022-12-03');
INSERT INTO orders VALUES ('23', '14', '2022-12-09');
INSERT INTO orders VALUES ('24', '25', '2022-12-12');
INSERT INTO orders VALUES ('25', '13', '2022-12-16');
INSERT INTO orders VALUES ('26', '7', '2022-12-18');
INSERT INTO orders VALUES ('27', '16', '2022-12-18');
INSERT INTO orders VALUES ('28', '4', '2022-12-19');
INSERT INTO orders VALUES ('29', '7', '2022-12-20');
INSERT INTO orders VALUES ('30', '22', '2022-12-22');
INSERT INTO orders VALUES ('31', '16', '2022-12-26');
INSERT INTO orders VALUES ('32', '12', '2022-12-28');
INSERT INTO orders VALUES ('33', '9', '2023-01-03');
INSERT INTO orders VALUES ('34', '20', '2023-01-10');
INSERT INTO orders VALUES ('35', '4', '2023-01-23');
INSERT INTO orders VALUES ('36', '21', '2023-02-07');
INSERT INTO orders VALUES ('37', '10', '2023-02-15');
INSERT INTO orders VALUES ('38', '15', '2023-02-24');
INSERT INTO orders VALUES ('39', '7', '2023-03-04');
INSERT INTO orders VALUES ('40', '9', '2023-03-22');
INSERT INTO orders VALUES ('41', '24', '2023-03-31');
INSERT INTO orders VALUES ('42', '4', '2023-04-02');
INSERT INTO orders VALUES ('43', '13', '2023-04-17');
INSERT INTO orders VALUES ('44', '10', '2023-04-29');
INSERT INTO orders VALUES ('45', '20', '2023-05-12');
INSERT INTO orders VALUES ('46', '18', '2023-05-29');
INSERT INTO orders VALUES ('47', '17', '2023-06-01');
INSERT INTO orders VALUES ('48', '13', '2023-05-08');
INSERT INTO orders VALUES ('49', '17', '2023-05-10');
INSERT INTO orders VALUES ('50', '19', '2023-05-11');

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
INSERT INTO contains VALUES ('11','10000010','1');
INSERT INTO contains VALUES ('12','10000001','2');
INSERT INTO contains VALUES ('13','10000007','2');
INSERT INTO contains VALUES ('14','10000004','5');
INSERT INTO contains VALUES ('15','10000005','4');
INSERT INTO contains VALUES ('16','10000001','3');
INSERT INTO contains VALUES ('17','10000002','5');
INSERT INTO contains VALUES ('18','10000003','1');
INSERT INTO contains VALUES ('19','10000001','2');
INSERT INTO contains VALUES ('20','10000004','2');
INSERT INTO contains VALUES ('21','10000002','1');
INSERT INTO contains VALUES ('22','10000005','1');
INSERT INTO contains VALUES ('22','10000006','2');
INSERT INTO contains VALUES ('23','10000010','1');
INSERT INTO contains VALUES ('24','10000007','1');
INSERT INTO contains VALUES ('25','10000008','1');
INSERT INTO contains VALUES ('26','10000003','2');
INSERT INTO contains VALUES ('27','10000001','1');
INSERT INTO contains VALUES ('28','10000008','2');
INSERT INTO contains VALUES ('29','10000009','2');
INSERT INTO contains VALUES ('30','10000010','1');
INSERT INTO contains VALUES ('31','10000008','2');
INSERT INTO contains VALUES ('32','10000010','1');
INSERT INTO contains VALUES ('33','10000001','2');
INSERT INTO contains VALUES ('34','10000007','2');
INSERT INTO contains VALUES ('35','10000004','5');
INSERT INTO contains VALUES ('36','10000005','4');
INSERT INTO contains VALUES ('37','10000008','2');
INSERT INTO contains VALUES ('39','10000009','2');
INSERT INTO contains VALUES ('40','10000008','2');
INSERT INTO contains VALUES ('41','10000010','1');
INSERT INTO contains VALUES ('42','10000001','2');
INSERT INTO contains VALUES ('43','10000007','2');
INSERT INTO contains VALUES ('44','10000004','5');
INSERT INTO contains VALUES ('45','10000010','1');
INSERT INTO contains VALUES ('46','10000003','2');
INSERT INTO contains VALUES ('47','10000001','1');
INSERT INTO contains VALUES ('48','10000008','2');
INSERT INTO contains VALUES ('49','10000009','2');
INSERT INTO contains VALUES ('50','10000010','1');

COMMIT;

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
INSERT INTO employee VALUES ('100555555', '088887700', '2001-07-15', 'Joana');
INSERT INTO employee VALUES ('100666666', '888888222', '2001-09-04', 'Matilde');
INSERT INTO employee VALUES ('100777777', '222999922', '2001-10-29', 'António');
INSERT INTO employee VALUES ('100888888', '898989898', '2001-12-24', 'Manuel');
INSERT INTO employee VALUES ('100999999', '222277777', '2002-01-14', 'Marta');
INSERT INTO employee VALUES ('200000000', '444444999', '2002-02-27', 'Margarida');
INSERT INTO employee VALUES ('200111111', '111666666', '2002-04-19', 'Francisco');
INSERT INTO employee VALUES ('200222222', '333377777', '2002-05-15', 'Alexandre');
INSERT INTO employee VALUES ('200333333', '787878787', '2002-06-06', 'Alberto');
INSERT INTO employee VALUES ('200444444', '222666111', '2002-06-30', 'Bernardo');
INSERT INTO employee VALUES ('200555555', '444445555', '2002-09-01', 'Humberto');

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
INSERT INTO process VALUES ('100666666', '16');
INSERT INTO process VALUES ('100777777', '17');
INSERT INTO process VALUES ('100888888', '18');
INSERT INTO process VALUES ('100999999', '19');
INSERT INTO process VALUES ('200000000', '20');
INSERT INTO process VALUES ('200111111', '21');
INSERT INTO process VALUES ('200222222', '22');
INSERT INTO process VALUES ('200333333', '23');
INSERT INTO process VALUES ('200444444', '24');
INSERT INTO process VALUES ('200555555', '25');
INSERT INTO process VALUES ('111111111', '26');
INSERT INTO process VALUES ('222222222', '27');
INSERT INTO process VALUES ('333333333', '28');
INSERT INTO process VALUES ('444444444', '29');
INSERT INTO process VALUES ('555555555', '30');
INSERT INTO process VALUES ('666666666', '31');
INSERT INTO process VALUES ('777777777', '32');
INSERT INTO process VALUES ('888888888', '33');
INSERT INTO process VALUES ('999999999', '34');
INSERT INTO process VALUES ('100000000', '35');
INSERT INTO process VALUES ('100111111', '36');
INSERT INTO process VALUES ('100222222', '37');
INSERT INTO process VALUES ('100333333', '38');
INSERT INTO process VALUES ('100444444', '39');
INSERT INTO process VALUES ('100555555', '40');
INSERT INTO process VALUES ('100666666', '41');
INSERT INTO process VALUES ('100777777', '42');
INSERT INTO process VALUES ('100888888', '43');
INSERT INTO process VALUES ('100999999', '44');
INSERT INTO process VALUES ('200000000', '45');
INSERT INTO process VALUES ('200111111', '46');
INSERT INTO process VALUES ('200222222', '47');
INSERT INTO process VALUES ('200333333', '48');
INSERT INTO process VALUES ('200444444', '49');
INSERT INTO process VALUES ('200555555', '50');

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
INSERT INTO works VALUES ('100666666','Department A','Rua Ribeiro dos Reis 2725-175 Algueirão-Mem Martins');
INSERT INTO works VALUES ('100777777','Department B','Rua Domingos da Cunha 2725-079 Algueirão-Mem Martins');
INSERT INTO works VALUES ('100777777','Department C','Rua dos Lírios 2725-368 Algueirão-Mem Martins');
INSERT INTO works VALUES ('100999999','Department D','Rua Amor Perfeito 2745-766 Queluz');
INSERT INTO works VALUES ('200000000','Department E','Praceta Columbano Bordalo Pinheiro T 2745-258 Queluz');
INSERT INTO works VALUES ('200111111','Department A','Avenida Candido Oliveira 2725-178 Algueirão-Mem Martins');
INSERT INTO works VALUES ('200222222','Department B','Rua Ribeiro dos Reis 2725-175 Algueirão-Mem Martins');
INSERT INTO works VALUES ('200333333','Department C','Rua Domingos da Cunha 2725-079 Algueirão-Mem Martins');
INSERT INTO works VALUES ('200444444','Department D','Rua dos Lírios 2725-368 Algueirão-Mem Martins');
INSERT INTO works VALUES ('200555555','Department E','Rua Amor Perfeito 2745-766 Queluz');

INSERT INTO supplier VALUES ('200000001','Diogo','Avenida Prof. Dr. Cavaco Silva 2744-016 Porto Salvo','10000001', '2000-01-01');
INSERT INTO supplier VALUES ('200000002','André','Estr. Ligeiras 2735-337 Agualva-Cacém','10000002', '2001-03-06');
INSERT INTO supplier VALUES ('200000003','Jose','Rua Vitor Alves 2730-250 Agualva-Cacém','10000003', '1999-02-11');
INSERT INTO supplier VALUES ('200000004','Tiago','Rua Urano 13 2635-265 Rio de Mouro','10000004', '1997-09-11');
INSERT INTO supplier VALUES ('200000005','Eusébio','Rua Marquês Pombal 2635-600 Rio de Mouro','10000005', '1989-10-11');
INSERT INTO supplier VALUES ('200000006','Joseph','Rua dos Lírios 2725-341 Algueirão-Mem Martins','10000006', '1995-10-02');
INSERT INTO supplier VALUES ('200000007','Jamal','Estr. Mem Martins 2725-389 Algueirão-Mem Martins','10000007', '1991-09-07');
INSERT INTO supplier VALUES ('200000008','Jotaro','Avenida Dr. António Nabais 2605-164 Belas','10000008', '1987-09-19');
INSERT INTO supplier VALUES ('200000009','Josuke','Avenida Pedro Álvares Cabral 2710-297 Sintra','10000009', '1991-12-31');
INSERT INTO supplier VALUES ('200000010','Jolyne','Rua República da Coreia 2710-116 Sintra','10000010', '1991-04-05');

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

INSERT INTO pay VALUES ('1','1');
INSERT INTO pay VALUES ('2','2');
INSERT INTO pay VALUES ('3','1');
INSERT INTO pay VALUES ('4','3');
INSERT INTO pay VALUES ('5','4');
INSERT INTO pay VALUES ('6','5');
INSERT INTO pay VALUES ('7','6');
INSERT INTO pay VALUES ('8','8');

