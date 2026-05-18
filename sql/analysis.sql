#total_revenue
SELECT SUM(total_amount) AS total_revenue
FROM orders;

#total_orders
SELECT COUNT(*) AS total_orders
FROM orders;

SELECT
    m.item_name,
    SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN menu m
ON oi.item_id = m.item_id
GROUP BY m.item_name
ORDER BY total_quantity DESC;

SELECT
    m.item_name,
    SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN menu m
ON oi.item_id = m.item_id
GROUP BY m.item_name
ORDER BY total_quantity DESC;

SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

SELECT
    AVG(total_amount) AS average_order_value
FROM orders;

SELECT *
FROM menu
ORDER BY price DESC
LIMIT 1;

SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC;

SELECT
    customer_name,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS customer_rank
FROM (
    SELECT
        c.customer_name,
        SUM(o.total_amount) AS total_spent
    FROM customers c
    JOIN orders o
    ON c.customer_id = o.customer_id
    GROUP BY c.customer_name
) ranked_customers;

SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 1;

SELECT
    m.category,
    SUM(oi.quantity) AS total_orders
FROM menu m
JOIN order_items oi
ON m.item_id = oi.item_id
GROUP BY m.category
ORDER BY total_orders DESC;

SELECT
    order_date,
    SUM(total_amount) AS daily_revenue
FROM orders
GROUP BY order_date
ORDER BY order_date;