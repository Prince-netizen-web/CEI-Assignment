
# Week 3 Assignment - SQL Analysis Using Subqueries, CTEs and Window Functions

## Overview

This project analyzes the Superstore dataset using advanced SQL concepts including Subqueries, Common Table Expressions (CTEs), Window Functions, Joins, and Aggregations. The objective is to derive business insights related to customer sales performance and order analysis.

---

## Dataset

**Dataset Used:** Superstore.csv

The dataset contains information about:

* Orders
* Customers
* Products
* Sales
* Profit
* Quantity
* Shipping Details

---

## Objectives

* Import and organize Superstore data into relational tables.
* Apply Subqueries for filtering and analysis.
* Use CTEs for customer sales aggregation.
* Implement Window Functions for ranking and row numbering.
* Combine JOIN, CTE, and Window Functions to generate customer rankings.
* Solve business-oriented analytical queries.

---

## Database Schema

### customers

* customer_id
* customer_name
* segment

### products

* product_id
* category
* sub_category
* product_name

### orders

* order_id
* customer_id
* product_id
* order_date
* sales
* quantity
* profit

---

## SQL Concepts Used

### Subqueries

* Orders with sales greater than average sales
* Highest sales order per customer

### Common Table Expressions (CTEs)

* Total sales per customer
* Customers with above-average sales

### Window Functions

* ROW_NUMBER()
* RANK()

### Joins

* Customer ranking report using JOIN + CTE + Window Function

---

## Business Questions Solved

1. Find all orders where sales are greater than average sales.
2. Find the highest sales order for each customer.
3. Calculate total sales for each customer.
4. Find customers whose total sales are above average.
5. Rank customers based on total sales.
6. Assign row numbers to orders within each customer.
7. Display top 3 customers based on total sales.
8. Identify top 5 customers.
9. Identify bottom 5 customers.
10. Find customers who placed only one order.
11. Find customers with above-average sales.
12. Determine the highest order value for each customer.

---

## Project Structure

Week_3/


├── notebook.ipynb

├── README.md

├── insights.md


└── Superstore.csv

---

## Key Insights

* A small percentage of customers contribute a large portion of total sales.
* Several customers have placed only one order, indicating retention opportunities.
* Customer sales rankings help identify high-value customers.
* Window Functions provide efficient ranking and sequencing capabilities.
* CTEs improve query readability and maintainability.

---

## Author

Prince Badgoti

Celebal Technologies Internship Program


