------- QUERY 1 -------
SELECT sku, city, month, day_of_month, day_of_week, SUM(qty) AS total_qty, SUM(total_price) AS total_sales FROM product_sales
WHERE year = 2022
GROUP BY sku,
    GROUPING SETS(
    (sku,month),
    (sku,day_of_month),
    (sku,day_of_week),
    (sku,city),
    ()
    )
ORDER BY sku,city, month, day_of_month, day_of_week;


------- QUERY 2 -------
SELECT month, day_of_week, AVG(total_price) AS average FROM product_sales
WHERE year = 2022
GROUP BY
    CUBE(month, day_of_week)
ORDER BY month, day_of_week;
