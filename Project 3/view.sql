DROP VIEW IF EXISTS product_sales;

CREATE VIEW product_sales(sku, order_no, qty, total_price, year, month, day_of_month, day_of_week, city) AS
    SELECT
            sku,
            order_no,
            qty,
            SUM(price * qty) AS total_price,
            EXTRACT(YEAR from date) AS year,
            EXTRACT(MONTH from date) AS month,
            EXTRACT(DAY from date) AS day_of_month,
            EXTRACT(DOW from date) AS day_of_week,
            SUBSTRING() AS city
    FROM customer NATURAL JOIN pay NATURAL JOIN contains JOIN product p on contains.sku = p.sku




