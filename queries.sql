----- EXERCICIO 1 -----
SELECT customer.name
FROM customer
    NATURAL JOIN orders
    NATURAL JOIN containss
    FULL OUTER JOIN product ON product.name = customer.name
WHERE date > '2022-12-31' AND date < '2024-01-01' AND price > 50;

----- EXERCICIO 2 -----

SELECT employee.name
FROM employee
    NATURAL JOIN (
        SELECT date
        FROM orders
        WHERE date > '2022-31-12' AND date < '2023-02-01') AS january_requests
    NATURAL JOIN process
    FULL OUTER JOIN works ON works.name = employee.name
    NATURAL JOIN warehouse WHERE address NOT IN(
        SELECT office.address FROM office);


----- EXERCICIO 3 -----
SELECT name
FROM sale NATURAL JOIN containss NATURAL JOIN product
HAVING SUM(qty) >= ALL (
    SELECT SUM(qty)
    FROM containss
);

----- EXERCICIO 4 -----
SELECT order_num, SUM(product.price * containss.qty) AS total_value
FROM sale NATURAL JOIN containss NATURAL JOIN product
GROUP BY order_num;

