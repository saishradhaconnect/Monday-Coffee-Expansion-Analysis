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

## 🛠️ Tools & Technologies

- **Database:** MySQL
- **IDE:** MySQL Workbench
- **Language:** SQL
- **Concepts:** JOINs, Aggregate Functions, Common Table Expressions (CTEs), Window Functions, GROUP BY, ORDER BY, CASE Statements

| Table | Description |
|--------|-------------|
| `city` | Contains city-level information such as population, estimated rent, and city name. |
| `customers` | Stores customer details and their associated city. |
| `products` | Contains coffee product information including product name and pricing. |
| `sales` | Records customer purchase transactions, including product purchased, sale amount, and transaction date. |
