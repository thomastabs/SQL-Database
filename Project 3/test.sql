SELECT order_no
FROM orders
JOIN contains USING (order_no)
JOIN product USING (SKU)
WHERE price > 50 AND EXTRACT(YEAR FROM date) = 2023;

SELECT order_no, SUM(qty*price)
FROM contains
JOIN product USING (SKU)
WHERE name LIKE 'A%'
GROUP BY order_no;
