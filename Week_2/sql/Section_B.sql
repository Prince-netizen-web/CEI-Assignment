-- =========================================
-- Section B — Filtering & Optimization (WHERE, Indexes)
-- =========================================
 
 --Q7. Retrieve all orders with status = 'Delivered'. 
 SELECT * from orders;
 SELECT * FROM orders 
 WHERE status='Delivered'




 --Q8. Find all products in the 'Electronics' category with a unit_price greater than ₹2000. 
 SELECT * FROM products;

 SELECT * FROM products
 WHERE category='Electronics' AND unit_price>2000




 --Q9. List all customers who joined in the year 2024 and belong to the state 'Maharashtra'. 
 SELECT * FROM customers;
 SELECT * FROM customers
 WHERE YEAR(join_date)=2024 AND state='Maharashtra';




 --Q10. Find all orders placed between '2024-08-10' and '2024-08-25' (inclusive) that are NOT cancelled.
 SELECT * FROM orders
 WHERE order_date between '2024-08-10' AND '2024-08-25'
 AND  status!='Cancelled'




 /*
 Q11. Explain what the index idx_orders_date does. How would it improve the performance of a query that
filters orders by order_date? Write a sample query that would benefit from this index.
-- =====================================
-- Q11. Index: idx_orders_date
-- =====================================

/*
The index idx_orders_date is created on the order_date column
of the orders table.

CREATE INDEX idx_orders_date ON orders(order_date);

Purpose:
The index stores order_date values in a sorted structure,
allowing SQL Server to locate rows for a specific date or
date range much faster than scanning the entire table.

Performance Benefit:
Without the index, SQL Server may perform a full table scan,
checking every row in the orders table.

With the index, SQL Server can perform an index seek,
directly locating the required records based on order_date,
which reduces I/O operations and improves query performance.

This is especially useful when the orders table contains
a large number of records.

------------------------------------------------------------

Example Query:

SELECT *
FROM orders
WHERE order_date BETWEEN '2024-08-10' AND '2024-08-25';

This query can use the idx_orders_date index to quickly find
all orders within the specified date range instead of
scanning the entire table.

------------------------------------------------------------

Conclusion:
The idx_orders_date index improves the performance of
queries that filter, sort, or search data using the
order_date column.
*/



*/



 /*--Q12. If you run: SELECT * FROM customers WHERE YEAR(join_date) = 2024; — 
 would the index on join_date be used? 
Explain why or why not, and rewrite the query to be index-friendly (SARGable)
*/




-- Query:

SELECT *
FROM customers
WHERE YEAR(join_date) = 2024;

/*
Will the index on join_date be used?

No, the index on join_date will not be used efficiently.

Reason:
The YEAR() function is applied to the indexed column
join_date. SQL Server must calculate the year value for
every row before performing the comparison.

Because a function is applied to the indexed column,
SQL Server cannot perform an efficient index seek and
may instead perform an index scan or table scan.

Such queries are called Non-SARGable
(Search ARGument Able) queries.

------------------------------------------------------------

Index-Friendly (SARGable) Query:
*/
SELECT *
FROM customers
WHERE join_date >= '2024-01-01'
  AND join_date < '2025-01-01';

/*------------------------------------------------------------

Why is this better?

1. No function is applied to join_date.
2. SQL Server can use the index on join_date.
3. An index seek can be performed instead of a scan.
4. Query execution is faster, especially for large tables.

------------------------------------------------------------

Conclusion:

Using YEAR(join_date) makes the query non-SARGable and
prevents efficient index usage.

Using a date range allows SQL Server to use the join_date
index effectively, improving performance.
*/
