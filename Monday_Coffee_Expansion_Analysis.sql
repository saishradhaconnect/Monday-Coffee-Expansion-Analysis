-- Create Database
CREATE DATABASE monday_coffee_db;
USE monday_coffee_db;

-- Drop Tables
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS city;

-- create Tables
-- First create city, then products, customers & sales
CREATE TABLE city
(
	city_id	int PRIMARY KEY,
	city_name varchar(15),	
	population	bigint,
	estimated_rent	float,
	city_rank int
);

CREATE TABLE products
(
	product_id	INT PRIMARY KEY,
	product_name VARCHAR(35),	
	price float
);

CREATE TABLE customers
(
	customer_id int primary key,	
	customer_name varchar(25),	
	city_id int,
	CONSTRAINT fk_city FOREIGN KEY (city_id) REFERENCES city(city_id)
);

CREATE TABLE sales
(
	sale_id	INT PRIMARY KEY,
	sale_date	date,
	product_id	INT,
	customer_id	INT,
	total FLOAT,
	rating INT,
	CONSTRAINT fk_products FOREIGN KEY (product_id) REFERENCES products(product_id),
	CONSTRAINT fk_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
);


-- Verify Tables
show tables;
desc city;
desc products;
desc customers;
desc sales;

-- Verify Imported Data
SELECT * FROM city;
SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM sales;



----------- DATA ANALYSIS -----------

-- Q1. Coffee Consumers Count
-- How many people in each city are estimated to consume coffee, given that 25% of the population does?

SELECT city_name, 
    ROUND((population * 0.25) / 1000000, 2) AS coffee_consumers_in_millions,
    city_rank
FROM city
ORDER BY coffee_consumers_in_millions  DESC;




-- Q.2 Total Revenue from Coffee Sales
-- What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?
-- Also find which cities generated the highest revenue in Q4 2023?

-- Total Revenue generated during Q4 2023
SELECT SUM(total) AS total_revenue
FROM sales
WHERE YEAR(sale_date) = 2023 AND QUARTER(sale_date) = 4;


-- Revenue contribution by each city
SELECT ci.city_name, 
	SUM(s.total) AS total_revenue
FROM sales AS s
	JOIN customers AS c   
	ON s.customer_id = c.customer_id
	JOIN city AS ci   
	ON c.city_id = ci.city_id
WHERE YEAR(s.sale_date) = 2023
  AND QUARTER(s.sale_date) = 4
GROUP BY ci.city_name
ORDER BY total_revenue DESC;






-- Q.3 Sales Count for Each Product
-- How many units of each coffee product have been sold?

SELECT p.product_name, 
	COUNT(s.sale_id) AS total_orders
FROM products AS p
	LEFT JOIN sales AS s
	ON p.product_id = s.product_id
GROUP BY p.product_name
ORDER BY total_orders DESC;






-- Q.4 Average Sales Amount per City
-- What is the average sales amount per customer in each city?

SELECT ci.city_name,
    SUM(s.total) AS total_revenue,
    COUNT(DISTINCT s.customer_id) AS total_customers,
    ROUND(SUM(s.total) / COUNT(DISTINCT s.customer_id),2) AS avg_sale_per_customer
FROM sales AS s
	JOIN customers AS c
    ON s.customer_id = c.customer_id
	JOIN city AS ci
    ON c.city_id = ci.city_id
GROUP BY ci.city_name
ORDER BY total_revenue DESC;



-- Q.5 City Population and Coffee Consumers (25%)
-- Provide a list of cities along with their populations and estimated coffee consumers.
-- return city_name, total current consumers, estimated coffee consumers (25%)

WITH city_population AS
(
    SELECT
        city_name,
        ROUND((population * 0.25) / 1000000, 2) AS estimated_coffee_consumers_in_millions
    FROM city
),

customer_data AS
(
    SELECT
        ci.city_name,
        COUNT(DISTINCT c.customer_id) AS current_consumers
    FROM sales AS s
    JOIN customers AS c
        ON s.customer_id = c.customer_id
    JOIN city AS ci
        ON c.city_id = ci.city_id
    GROUP BY ci.city_name
)

SELECT
    cp.city_name,
    cd.current_consumers,
    cp.estimated_coffee_consumers_in_millions
FROM city_population AS cp
JOIN customer_data AS cd
    ON cp.city_name = cd.city_name
ORDER BY cp.estimated_coffee_consumers_in_millions DESC;




-- Q6 Top Selling Products by City
-- What are the top 3 selling coffee products in each city based on the no of orders?

WITH product_sales AS
(
    SELECT
        ci.city_name,
        p.product_name,
        COUNT(s.sale_id) AS total_orders,

        DENSE_RANK() OVER
        (
            PARTITION BY ci.city_name ORDER BY COUNT(s.sale_id) DESC
        ) 
        AS product_rank
        
    FROM sales AS s
    JOIN products AS p
        ON s.product_id = p.product_id
    JOIN customers AS c
        ON s.customer_id = c.customer_id
    JOIN city AS ci
        ON c.city_id = ci.city_id

    GROUP BY
        ci.city_name, 
        p.product_name
)

SELECT
    city_name,
    product_name,
    total_orders,
    product_rank
FROM product_sales
WHERE product_rank <= 3;



-- Q.7 Customer Segmentation by City
-- How many unique customers are there in each city who have purchased coffee products?

SELECT
    ci.city_name,
    COUNT(DISTINCT c.customer_id) AS unique_customers

FROM sales AS s
JOIN customers AS c
    ON s.customer_id = c.customer_id
JOIN city AS ci
    ON c.city_id = ci.city_id

GROUP BY ci.city_name
ORDER BY unique_customers DESC;




-- Q.8 Average Sale vs Rent
-- Find each city and their average sale per customer and avg rent per customer

WITH city_sales AS
(
    SELECT
        ci.city_name,
        SUM(s.total) AS total_revenue,
        COUNT(DISTINCT s.customer_id) AS total_customers,
        ROUND(SUM(s.total) / COUNT(DISTINCT s.customer_id),2) AS avg_sale_per_customer
    FROM sales AS s
    JOIN customers AS c
        ON s.customer_id = c.customer_id
    JOIN city AS ci
        ON c.city_id = ci.city_id
    GROUP BY ci.city_name
),

city_rent AS
(
    SELECT
        city_name, 
        estimated_rent
    FROM city
)

SELECT
    cr.city_name,
    cr.estimated_rent,
    cs.total_customers,
    cs.avg_sale_per_customer,
    ROUND(cr.estimated_rent / cs.total_customers,2) AS avg_rent_per_customer
FROM city_rent AS cr
JOIN city_sales AS cs
    ON cr.city_name = cs.city_name
ORDER BY avg_sale_per_customer DESC;



-- Q.9 Monthly Sales Growth
-- Sales growth rate: Calculate the percentage growth(or decline) in sales over different time periods(monthly) by each city

WITH monthly_sales AS
(
    SELECT
        ci.city_name,
        YEAR(s.sale_date) AS sales_year,
        MONTH(s.sale_date) AS sales_month,
        SUM(s.total) AS total_sales
    FROM sales AS s
    JOIN customers AS c
        ON s.customer_id = c.customer_id
    JOIN city AS ci
        ON c.city_id = ci.city_id
    GROUP BY
        ci.city_name,
        YEAR(s.sale_date),
        MONTH(s.sale_date)
),

growth_data AS
(
    SELECT
        city_name,
        sales_year,
        sales_month,
        total_sales,
        LAG(total_sales) OVER(PARTITION BY city_name ORDER BY sales_year, sales_month) AS previous_month_sales
    FROM monthly_sales
)

SELECT
    city_name,
    sales_year,
    sales_month,
    total_sales,
    previous_month_sales,
    ROUND(((total_sales - previous_month_sales)/previous_month_sales) * 100,2) AS growth_percentage
FROM growth_data
WHERE previous_month_sales IS NOT NULL;



-- Q.10 Market Potential Analysis
-- Identify top 3 city based on highest sales, return 
-- city name, total sale, total rent, total customers, estimated coffee consumer

WITH city_sales AS
(
    SELECT
        ci.city_name,
        SUM(s.total) AS total_revenue,
        COUNT(DISTINCT s.customer_id) AS total_customers,
        ROUND(SUM(s.total) / COUNT(DISTINCT s.customer_id),2) AS avg_sale_per_customer
    FROM sales AS s
    JOIN customers AS c
        ON s.customer_id = c.customer_id
    JOIN city AS ci
        ON c.city_id = ci.city_id
    GROUP BY ci.city_name
),

city_info AS
(
    SELECT
        city_name,
        estimated_rent,
        ROUND((population * 0.25) / 1000000,2) AS estimated_coffee_consumers
    FROM city
)

SELECT
    cs.city_name,
    cs.total_revenue,
    ci.estimated_rent,
    cs.total_customers,
    ci.estimated_coffee_consumers,
    cs.avg_sale_per_customer,
    ROUND(ci.estimated_rent / cs.total_customers,2) AS avg_rent_per_customer
FROM city_sales AS cs
JOIN city_info AS ci
    ON cs.city_name = ci.city_name
ORDER BY total_revenue DESC
LIMIT 3;












