----- EXERCICIO 1 -----
SELECT name
FROM customer c
    NATURAL JOIN order
    NATURAL JOIN contains
    NATURAL JOIN product
WHERE date > '31-12-2022' AND date < '1-1-2024' AND price > 50

----- EXERCICIO 2 -----

SELECT name
FROM employee


----- EXERCICIO 3 -----
SELECT name
FROM sale NATURAL JOIN contains NATURAL JOIN product
HAVING SUM(units) >= ALL (
    SELECT SUM(units)
    FROM contains
);

----- EXERCICIO 4 -----
SELECT order_number, SUM(price * quantity)
FROM sale NATURAL JOIN contains NATURAL JOIN product

