----- EXERCICIO 1 -----
SELECT customer.name
FROM customer
    JOIN orders o ON customer.number = o.customer_number
    NATURAL JOIN contains
    JOIN product p ON contains.sku = p.sku
WHERE p.price > 50 AND o.date > '2022-12-31' AND o.date < '2024-01-01';

----- EXERCICIO 2 -----

SELECT DISTINCT employee.name
FROM employee
    NATURAL JOIN process
    JOIN orders o ON process.order_num = o.order_num
    JOIN works w ON w.ssn = employee.ssn
    NATURAL JOIN warehouse
WHERE address NOT IN(
    SELECT address
    FROM office
) AND o.date > '2022-12-31' AND o.date < '2023-02-01';


----- EXERCICIO 3 -----
SELECT name
FROM product NATURAL JOIN contains NATURAL JOIN sale
GROUP BY name
HAVING SUM(qty) >= ALL (
    SELECT SUM(qty)
    FROM contains
    GROUP BY sku
)
LIMIT 1;

----- EXERCICIO 4 -----
SELECT order_num, SUM(product.price * contains.qty) AS total_value
FROM sale NATURAL JOIN contains NATURAL JOIN product
GROUP BY order_num
ORDER BY order_num;

