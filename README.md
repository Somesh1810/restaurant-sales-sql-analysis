# Restaurant Sales Analytics using SQL

## Project Overview
This project analyzes restaurant sales data using SQL.  
The system helps understand customer behavior, revenue trends, and top-selling menu items.

---

## Tech Stack
- MySQL
- GitHub Codespaces
- SQL

---

## Database Schema

### Tables
1. customers
2. menu
3. orders
4. order_items

---

## SQL Concepts Used
- SELECT
- WHERE
- GROUP BY
- ORDER BY
- JOINs
- Aggregate Functions
- Window Functions
- RANK()

---

## Analytics Performed

### 1. Total Revenue
Analyzed total restaurant revenue.

### 2. Top Selling Menu Items
Identified most frequently ordered dishes.

### 3. Revenue by Category
Compared earnings across food categories.

### 4. Customer Spending Analysis
Analyzed customer purchase behavior.

### 5. Average Order Value
Calculated average spending per order.

### 6. Customer Ranking
Ranked customers using SQL window functions.

---

## Project Structure

restaurant-sales-sql-analysis/
│
├── sql/
│   ├── schema.sql
│   ├── data.sql
│   └── analysis.sql
│
└── README.md

---

## Sample Query

```sql
SELECT
    m.item_name,
    SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN menu m
ON oi.item_id = m.item_id
GROUP BY m.item_name
ORDER BY total_quantity DESC;
```

## Future Improvements

Power BI Dashboard
Real-world dataset integration
Stored Procedures
Triggers
Advanced analytics

## Author
Someshwar
