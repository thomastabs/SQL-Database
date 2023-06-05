------- QUERY 1 -------
SELECT cust_no, customer.name
FROM customer NATURAL JOIN pay NATURAL JOIN contains
    JOIN product p on p.sku = contains.sku
WHERE cust_no = customer.cust_no
GROUP BY cust_no, customer.name
HAVING SUM(price * qty) >= ALL (
    SELECT SUM(price * qty)
    FROM pay NATURAL JOIN product NATURAL JOIN contains
    GROUP BY cust_no
);

------- QUERY 2 -------
SELECT e.name FROM employee e
WHERE NOT EXISTS (
    SELECT DISTINCT o.date FROM orders o
    WHERE EXTRACT(YEAR FROM o.date) = 2022
    AND NOT EXISTS (
        SELECT p.order_no FROM process p
        WHERE p.ssn = e.ssn AND p.order_no = o.order_no
    )
);

------- QUERY 3 -------
SELECT EXTRACT(MONTH FROM o.date) AS month, COUNT(*)
FROM orders o
WHERE o.order_no NOT IN(
    SELECT pay.order_no
    FROM pay
) AND o.date >= '2022-01-01' AND o.date < '2023-01-01'
GROUP BY month
ORDER BY month;
