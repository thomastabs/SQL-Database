-- EXERCICIO 1
-- Πname(σdate>”31−12−2022” ∧ date<”1−1−2024” ∧ price>50 (customer ▷◁ order ▷◁ contains ▷◁ ρname→nameprod(product)))

SELECT customer.name
FROM customer
    JOIN orders o ON customer.number = o.customer_number
    NATURAL JOIN contains
    JOIN product p ON contains.sku = p.sku
WHERE p.price > 50 AND o.date > '2022-12-31' AND o.date < '2024-01-01';

-- EXERCICIO 2
-- A ← σdate>”31−12−2022” ∧ date<”1−2−2023”(order ▷◁ process ▷◁ employee)
-- Πname(A ▷◁ ρname→namework(works) ▷◁ (warehouse − office))

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


-- EXERCICIO 3
-- A ← ρ(2→qty)(skuGSU M (qty)(contains ▷◁ sale))
-- B ← ρ(1→max)(GM AX(qty)(A))
-- Πname(σqty=max(product ▷◁ A × B))

SELECT name
FROM product NATURAL JOIN contains NATURAL JOIN sale
GROUP BY name
HAVING SUM(qty) >= ALL (
    SELECT SUM(qty)
    FROM contains
    GROUP BY sku
)
LIMIT 1;

-- EXERCICIO 4
-- order_noGsum(total value)(Πorder_no,price×qty→total_value(sale ▷◁ contains ▷◁ product))

SELECT order_num, SUM(product.price * contains.qty) AS total_value
FROM sale NATURAL JOIN contains NATURAL JOIN product
GROUP BY order_num
ORDER BY order_num;

