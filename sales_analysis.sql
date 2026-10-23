CREATE TABLE orders(
	order_id VARCHAR(50),
	order_date DATE,
	region VARCHAR(50),
	category VARCHAR(100),
	sales NUMERIC(12,2)
);
SELECT 
	ROUND(SUM(sales),2) AS total_revenues
FROM orders;

SELECT 
	COUNT(DISTINCT order_id) AS total_orders
FROM orders;

SELECT 
	ROUND(SUM(sales)/COUNT(DISTINCT order_id),2) AS average_order_value
FROM orders;

SELECT 
	region,
	ROUND(SUM(sales),2) AS revenue
FROM orders 
GROUP BY region
ORDER BY revenue desc;

SELECT 
	category,
	ROUND(SUM(sales),2) AS revenue
FROM orders 
GROUP BY category
ORDER BY revenue desc;

SELECT 
	ROUND(SUM(sales),2) AS revenue,
	DATE_TRUNC('month',order_date)::date AS Month
FROM 
orders
GROUP BY Month
ORDER BY Month;

SELECT 
	category,
	ROUND(SUM(sales),2) AS revenue,
	DATE_TRUNC('month',order_date)::date AS Month
FROM 
orders
GROUP BY category,Month
ORDER BY Month;

SELECT 
	ROUND(SUM(sales),2) AS revenue,
	DATE_TRUNC('year',order_date)::date AS Year
FROM 
orders
GROUP BY Year
ORDER BY Year;

SELECT
    region,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(
        SUM(sales) * 100.0 /
        NULLIF((SELECT SUM(sales) FROM orders), 0),
        2
    ) AS sales_percentage
FROM orders
GROUP BY region
ORDER BY sales_percentage DESC;

SELECT 
	category,
	ROUND(SUM(sales),2) AS revenue,
	DATE_TRUNC('month',order_date)::date AS Month
FROM 
orders
GROUP BY category,Month
ORDER BY Month;

SELECT 
	ROUND(SUM(sales),2) AS revenue,
	DATE_TRUNC('year',order_date)::date AS Year
FROM 
orders
GROUP BY Year
ORDER BY Year;

SELECT 
	EXTRACT(YEAR FROM order_date) AS year,
	Category,
	ROUND(SUM(sales),2) AS revenue
FROM orders
GROUP BY year,category
ORDER BY year;

SELECT 
	EXTRACT(MONTH FROM order_date) AS month,
	ROUND(SUM(sales),2) AS revenue
FROM orders
GROUP BY month
ORDER BY month;

WITH yearly_sales AS (
SELECT 
	ROUND(SUM(sales),2) AS revenue,
	EXTRACT(YEAR FROM order_date) AS year
FROM orders
GROUP BY year
)
SELECT 
	year,
	ROUND(revenue,2) AS revenue,
	ROUND(revenue-LAG(revenue) OVER (ORDER BY year) * 100.00/NULLIF(LAG(revenue) OVER (ORDER BY year),0), 2) 
	AS yearly_growth_percentage
FROM yearly_sales
ORDER BY year;