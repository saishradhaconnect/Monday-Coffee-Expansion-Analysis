# ☕ Monday Coffee Expansion Analysis using SQL

## 📖 Project Overview

Monday Coffee is an online coffee retailer operating across multiple cities in India. This project analyzes customer purchases, sales performance, product demand, and market potential to identify the best cities for opening new coffee stores.

Using MySQL, this project answers key business questions by applying SQL techniques such as Joins, Aggregate Functions, Common Table Expressions (CTEs), and Window Functions to generate actionable business insights.

## 🎯 Business Problem

Monday Coffee is an online coffee retailer looking to expand its business by opening physical coffee stores across India.

To support this expansion, the company needs to identify cities with high customer demand, strong sales performance, favorable rental costs, and significant market potential.

This project analyzes sales data using SQL to provide data-driven recommendations for selecting the top three cities for expansion.

## 📂 Dataset

The analysis is based on four relational tables representing customer transactions and business information.
| Table | Description |
|--------|-------------|
| city | Contains city name, population and estimated rent. |
| customers | Stores customer information and city mapping. |
| products | Contains coffee product details. |
| sales | Stores sales transactions including customer, product, date and amount. |

## 🛠️ Tools & Technologies

- **Database:** MySQL
- **Development Environment:** MySQL Workbench
- **Language:** SQL
- **Techniques Used:** JOINs, Aggregate Functions, GROUP BY, ORDER BY, Common Table Expressions (CTEs), Window Functions, RANK(), DENSE_RANK(), PRIMARY KEY, FOREIGN KEY

## 🧠 SQL Concepts Used

Throughout this project, the following SQL concepts were applied:

- Database & Table Creation
- PRIMARY KEY & FOREIGN KEY Constraints
- INNER JOIN & LEFT JOIN
- Aggregate Functions (`SUM()`, `COUNT()`, `AVG()`)
- GROUP BY
- ORDER BY
- Common Table Expressions (CTEs)
- Window Functions
- `RANK()`
- `DENSE_RANK()`
- Data Verification (`SHOW TABLES`, `DESC`)

## 📊 Business Questions Solved

This project answers the following business questions using SQL:

1. Estimate the number of coffee consumers in each city.
2. Calculate the total revenue generated during Q4 2023.
3. Identify the total sales count for each coffee product.
4. Determine the average sales amount per customer in each city.
5. Compare city population with estimated coffee consumers.
6. Identify the top 3 selling coffee products in each city.
7. Analyze customer segmentation across cities.
8. Compare average sales per customer with average rent per customer.
9. Calculate month-over-month sales growth.
10. Recommend the top three cities for new coffee store expansion.

## 📈 Key Insights

- Pune generated the highest overall revenue while maintaining relatively low rent per customer, making it an attractive expansion location.
- Delhi had the largest estimated coffee consumer base, indicating significant market potential.
- Jaipur demonstrated a strong customer base with comparatively low rental costs.
- Coffee product sales varied across cities, highlighting regional customer preferences.
- Revenue, customer count, rental cost, and estimated coffee consumers were all considered before recommending expansion locations.

## 💡 Business Recommendations

Based on the SQL analysis, the recommended cities for opening new coffee stores are:

### 🥇 Pune
- Highest overall revenue
- Low average rent per customer
- Strong customer spending

### 🥈 Delhi
- Largest estimated coffee consumer base
- High customer count
- Excellent market potential

### 🥉 Jaipur
- Low operational cost
- Strong customer base
- High sales potential
