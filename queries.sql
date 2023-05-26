----- EXERCICIO 1 -----
SELECT customer.name
FROM customer
    NATURAL JOIN orders
    NATURAL JOIN containss
    FULL OUTER JOIN product ON product.sku = containss.sku
WHERE orders.date > '2022-12-31' AND orders.date < '2024-01-01' AND product.price > 50;

----- EXERCICIO 2 -----

SELECT DISTINCT employee.name
FROM employee
    NATURAL JOIN (
        SELECT *
        FROM orders
        WHERE orders.date > '2022-12-31' AND orders.date < '2023-02-01'
    ) as od
    NATURAL JOIN process
    FULL OUTER JOIN works ON works.ssn = employee.ssn
    NATURAL JOIN warehouse
    WHERE address NOT IN(
        SELECT address
        FROM office
    );


----- EXERCICIO 3 -----
SELECT name
FROM product NATURAL JOIN containss NATURAL JOIN sale
HAVING SUM(qty) >= ALL (
    SELECT SUM(qty)
    FROM containss
)
LIMIT 1;

----- EXERCICIO 4 -----
SELECT order_num, SUM(product.price * containss.qty) AS total_value
FROM sale NATURAL JOIN containss NATURAL JOIN product
GROUP BY order_num
ORDER BY order_num;

