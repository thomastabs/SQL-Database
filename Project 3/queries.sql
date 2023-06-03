------- QUERY 1 -------
SELECT customer_number, customer.name
FROM customer NATURAL JOIN pay NATURAL JOIN contains
    JOIN product p on p.sku = contains.sku
GROUP BY customer_number, customer.name
HAVING SUM(price * qty) >= ALL (
    SELECT SUM(price * qty)
    FROM pay NATURAL JOIN product NATURAL JOIN contains
    GROUP BY customer_number
);

------- QUERY 2 -------
(SELECT name, date FROM employee
 JOIN process p on employee.ssn = p.ssn
 JOIN orders o on o.order_num = p.order_num)
EXCEPT
(SELECT date FROM orders WHERE EXTRACT(YEAR from date) == 2022);

------- QUERY 3 -------
SELECT EXTRACT(MONTH FROM o.date) AS month, COUNT(*)
FROM orders o
WHERE o.order_num NOT IN(
    SELECT order_num
    FROM pay
    )
AND o.date >= '2022-01-01' AND o.date < '2023-01-01'
GROUP BY month
ORDER BY month;
