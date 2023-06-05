------- QUERY 1 -------
SELECT customer_number, customer.name
FROM customer NATURAL JOIN pay NATURAL JOIN contains
    JOIN product p on p.sku = contains.sku
WHERE customer_number = customer.number
GROUP BY customer_number, customer.name
HAVING SUM(price * qty) >= ALL (
    SELECT SUM(price * qty)
    FROM pay NATURAL JOIN product NATURAL JOIN contains
    GROUP BY customer_number
);

------- QUERY 2 -------
SELECT e.name FROM employee e
WHERE NOT EXISTS (
    SELECT DISTINCT o.date FROM orders o
    WHERE EXTRACT(YEAR FROM o.date) = 2022
    AND NOT EXISTS (
        SELECT p.order_num FROM process p
        WHERE p.ssn = e.ssn AND p.order_num = o.order_num
    )
);

------- QUERY 3 -------
SELECT EXTRACT(MONTH FROM o.date) AS month, COUNT(*)
FROM orders o
WHERE o.order_num NOT IN(
    SELECT order_num
    FROM pay
) AND o.date >= '2022-01-01' AND o.date < '2023-01-01'
GROUP BY month
ORDER BY month;
