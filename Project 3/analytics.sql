SELECT city, month, day_of_month, day_of_week, SUM(qty) AS toqty, SUM(total_price) AS price FROM product_sales
WHERE year = 2022
GROUP BY
    GROUPING SETS((city),(month), (day_of_month), (day_of_week), ())
ORDER BY city, month, day_of_month, day_of_week;

SELECT month, day_of_week, AVG(total_price) AS media FROM product_sales
WHERE year = 2022
GROUP BY
    CUBE(month, day_of_week)
ORDER BY month, day_of_week;
