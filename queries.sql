----- EXERCICIO 1 -----
SELECT name
FROM customer
    NATURAL JOIN order
    NATURAL JOIN contains
    NATURAL JOIN product
WHERE date > '31-12-2022' AND date < '1-1-2024' AND price > 50;

----- EXERCICIO 2 -----

SELECT name
FROM employee
    NATURAL JOIN (
        SELECT order_date
        FROM order
        WHERE date > '31-12-2022' AND date < '1-2-2023'
    )
    NATURAL JOIN process
    NATURAL JOIN works
    NATURAL JOIN (
        SELECT warehouse_workplace_address
        FROM warehouse
        WHERE warehouse_workplace_address NOT IN (
            SELECT office_workplace_address FROM office
        )
    );


----- EXERCICIO 3 -----
SELECT name
FROM sale NATURAL JOIN contains NATURAL JOIN product
HAVING SUM(units) >= ALL (
    SELECT SUM(units)
    FROM contains
);

----- EXERCICIO 4 -----
SELECT order_number, SUM(price * quantity) AS total_value
FROM sale NATURAL JOIN contains NATURAL JOIN product
GROUP BY order_number;

