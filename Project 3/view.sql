DROP VIEW IF EXISTS product_sales;

CREATE VIEW product_sales AS
SELECT c.SKU,
       c.order_no,
       c.qty,
       (c.qty * p.price) AS total_price,
       EXTRACT(YEAR FROM o.date) AS year,
       EXTRACT(MONTH FROM o.date) AS month,
       EXTRACT(DAY FROM o.date) AS day_of_month,
       EXTRACT(DOW FROM o.date) AS day_of_week,
       TRIM(REGEXP_REPLACE(cu.address, '.*([0-9]{4}-[0-9]{3}) ([[:alpha:] ]+)$', '\2')) AS city
FROM contains c
JOIN orders o ON c.order_no = o.order_no
JOIN pay py ON o.order_no = py.order_no
JOIN product p ON c.SKU = p.SKU
JOIN customer cu ON o.cust_no = cu.cust_no;




