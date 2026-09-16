-- ============================================================
-- E-COMMERCE SALES ANALYTICS
-- PostgreSQL SQL Analysis
-- ============================================================

-- 1. TABLE SETUP
DROP TABLE IF EXISTS cleaned_orders;

CREATE TABLE cleaned_orders (
    order_id TEXT,
    customer_name TEXT,
    email TEXT,
    product TEXT,
    category TEXT,
    price NUMERIC,
    quantity INTEGER,
    order_date DATE,
    shipping_status TEXT,
    country TEXT
);


-- 2. DATA EXPLORATION

-- Total number of records
SELECT COUNT(*) AS total_records
FROM cleaned_orders;

-- Sample records
SELECT *
FROM cleaned_orders
LIMIT 10;

-- Check for missing values
SELECT *
FROM cleaned_orders
WHERE customer_name IS NULL
   OR email IS NULL
   OR product IS NULL
   OR category IS NULL
   OR price IS NULL
   OR quantity IS NULL
   OR order_date IS NULL
   OR shipping_status IS NULL
   OR country IS NULL;

-- Distinct countries
SELECT DISTINCT country
FROM cleaned_orders
ORDER BY country;

-- Distinct categories
SELECT DISTINCT category
FROM cleaned_orders
ORDER BY category;


-- 3. DATA VALIDATION

-- Check duplicate orders
SELECT order_id, COUNT(*) AS order_count
FROM cleaned_orders
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY order_count DESC;

-- Check invalid prices or quantities
SELECT *
FROM cleaned_orders
WHERE price <= 0
   OR quantity <= 0;


-- 4. BUSINESS ANALYSIS

-- Q1. Total revenue by country
SELECT
    country,
    SUM(price * quantity) AS total_sales
FROM cleaned_orders
GROUP BY country
ORDER BY total_sales DESC;


-- Q2. Total units sold by product
SELECT
    product,
    SUM(quantity) AS total_units_sold
FROM cleaned_orders
GROUP BY product
ORDER BY total_units_sold DESC;


-- Q3. Total revenue
SELECT
    SUM(price * quantity) AS total_revenue
FROM cleaned_orders;


-- Q4. Monthly sales trend
SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(price * quantity) AS monthly_sales
FROM cleaned_orders
GROUP BY month
ORDER BY month;


-- Q5. Total orders by country
SELECT
    country,
    COUNT(DISTINCT order_id) AS total_orders
FROM cleaned_orders
GROUP BY country
ORDER BY total_orders DESC;


-- Q6. Total revenue by category
SELECT
    category,
    SUM(price * quantity) AS total_revenue
FROM cleaned_orders
GROUP BY category
ORDER BY total_revenue DESC;


-- Q7. Top 5 products by units sold
SELECT
    product,
    SUM(quantity) AS total_products_sold
FROM cleaned_orders
GROUP BY product
ORDER BY total_products_sold DESC
LIMIT 5;


-- Q8. Average order value
SELECT
    SUM(price * quantity) /
    NULLIF(COUNT(DISTINCT order_id), 0) AS average_order_value
FROM cleaned_orders;


-- Q9. Total customers
SELECT
    COUNT(DISTINCT customer_name) AS total_customers
FROM cleaned_orders;


-- Q10. Country-wise revenue and orders
SELECT
    country,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(price * quantity) AS total_revenue
FROM cleaned_orders
GROUP BY country
ORDER BY total_revenue DESC;


-- 5. FINAL KPI VALIDATION

SELECT
    SUM(price * quantity) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_products_sold,
    COUNT(DISTINCT customer_name) AS total_customers
FROM cleaned_orders;

-- ============================================================
-- END OF SQL ANALYSIS
-- ============================================================
