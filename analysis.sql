-- ============================================================
-- RESTAURANT SALES ANALYSIS
-- ============================================================

-- ------------------------------------------------------------
-- 1. BASIC METRICS
-- ------------------------------------------------------------

-- Total Revenue
SELECT SUM(total_amount) AS total_revenue
FROM orders;

-- Total Orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- Average Order Value
SELECT
    AVG(total_amount) AS average_order_value
FROM orders;

-- Most Expensive Menu Item
SELECT *
FROM menu
ORDER BY price DESC
LIMIT 1;

-- ------------------------------------------------------------
-- 2. MENU & ITEM ANALYSIS
-- ------------------------------------------------------------

-- Top Selling Items by Quantity
SELECT
    m.item_name,
    SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN menu m ON oi.item_id = m.item_id
GROUP BY m.item_name
ORDER BY total_quantity DESC;

-- Revenue by Category
SELECT
    m.category,
    SUM(oi.quantity) AS total_orders
FROM menu m
JOIN order_items oi ON m.item_id = oi.item_id
GROUP BY m.category
ORDER BY total_orders DESC;

-- ------------------------------------------------------------
-- 3. CUSTOMER ANALYSIS
-- ------------------------------------------------------------

-- Top Customers by Total Spend
SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

-- Customer Order Frequency
SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC;

-- Customer Spend Ranking (Window Function)
SELECT
    customer_name,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS customer_rank
FROM (
    SELECT
        c.customer_name,
        SUM(o.total_amount) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_name
) ranked_customers;

-- #1 Top Customer
SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 1;

-- ------------------------------------------------------------
-- 4. TIME-BASED ANALYSIS
-- ------------------------------------------------------------

-- Daily Revenue Trend
SELECT
    order_date,
    SUM(total_amount) AS daily_revenue
FROM orders
GROUP BY order_date
ORDER BY order_date;

-- Month-over-Month Revenue Growth (Window Function + LAG)
-- Shows: window functions, LAG, DATE_FORMAT, percentage calculation
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(oi.quantity * m.price) AS revenue,
    LAG(SUM(oi.quantity * m.price)) OVER (ORDER BY DATE_FORMAT(o.order_date, '%Y-%m')) AS prev_month_revenue,
    ROUND(
        (SUM(oi.quantity * m.price) - LAG(SUM(oi.quantity * m.price))
            OVER (ORDER BY DATE_FORMAT(o.order_date, '%Y-%m')))
        / LAG(SUM(oi.quantity * m.price))
            OVER (ORDER BY DATE_FORMAT(o.order_date, '%Y-%m')) * 100,
    2) AS growth_pct
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN menu m ON oi.item_id = m.item_id
GROUP BY month;

-- ------------------------------------------------------------
-- 5. ADVANCED ANALYTICS
-- ------------------------------------------------------------

-- Running Total Revenue (Cumulative Sum with Window Function)
SELECT
    order_date,
    SUM(total_amount) AS daily_revenue,
    SUM(SUM(total_amount)) OVER (ORDER BY order_date) AS running_total
FROM orders
GROUP BY order_date
ORDER BY order_date;

-- Customer Segmentation: High / Mid / Low Value
SELECT
    customer_name,
    total_spent,
    CASE
        WHEN total_spent >= 7000 THEN 'High Value'
        WHEN total_spent >= 4000 THEN 'Mid Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM (
    SELECT
        c.customer_name,
        SUM(o.total_amount) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_name
) customer_totals
ORDER BY total_spent DESC;
