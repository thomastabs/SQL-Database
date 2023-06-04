------- QUERY 1 -------
SELECT c.number, c.name
FROM customer c JOIN pay p ON c.number = p.customer_number
GROUP BY c.number, c.name
HAVING COUNT(p.order_num) >= ALL (
    SELECT COUNT(p.order_num) FROM pay p
    GROUP BY p.customer_number
)
ORDER BY c.number;

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
