----- EXERCICIO 1 -----
SELECT name
FROM customer
    NATURAL JOIN order
    NATURAL JOIN contains
    FULL OUTER JOIN product ON product.name = customer.name
WHERE date > '2022-12-31' AND date < '2024-01-01' AND price > 50;

----- EXERCICIO 2 -----

SELECT name
FROM employee
    NATURAL JOIN (
        SELECT order_date
        FROM order
        WHERE date > '2022-31-12' AND date < '2023-02-01'
    )
    NATURAL JOIN process
    FULL OUTER JOIN works ON works.name = employee.name
    NATURAL JOIN warehouse WHERE warehouse_workplace_address NOT IN(
        SELECT office_workplace_address FROM office
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

