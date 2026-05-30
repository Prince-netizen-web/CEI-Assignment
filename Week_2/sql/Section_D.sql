-- =========================================
-- Section D — Joins & Relationships
-- =========================================

-- Q19. Write an INNER JOIN query to display each order along with the customer's first_name and last_name.
-- Show: order_id, order_date, first_name, last_name, total_amount.

SELECT * from customers;
SELECT * from orders;


SELECT 
    order_id,
    order_date,
    first_name,
    last_name,
    total_amount
FROM orders
INNER JOIN customers
    ON customers.customer_id = orders.customer_id;

-- Q20. Using a LEFT JOIN, list ALL customers and their orders (if any). Customers with no orders should still
-- appear with NULL values for order columns
SELECT customers.customer_id,
		first_name,
		last_name,
		order_id,
		status
FROM customers
LEFT JOIN orders
    ON customers.customer_id = orders.customer_id;

--  Q21. Write a query using JOINs across three tables (orders → order_items → products) to show: order_id,
-- product_name, quantity, unit_price, and discount_pct for each order item.
SELECT
    o.order_id,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.discount_pct
FROM orders o
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id;



/*
Q22. Explain the difference between LEFT JOIN and RIGHT JOIN with an example from this schema. When
would you use a FULL OUTER JOIN?

-- =====================================
-- Q22. LEFT JOIN vs RIGHT JOIN vs FULL OUTER JOIN
-- =====================================

/*
LEFT JOIN:
Returns all rows from the left table and the matching rows
from the right table. If no match exists, NULL values are
returned for columns from the right table.

Example:
SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

This query returns all customers, including those who have
never placed an order. For customers without orders,
order_id will be NULL.

------------------------------------------------------------

RIGHT JOIN:
Returns all rows from the right table and the matching rows
from the left table. If no match exists, NULL values are
returned for columns from the left table.

Example:
SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

This query returns all orders, including any orders that
do not have a matching customer record.

------------------------------------------------------------

Difference:
LEFT JOIN keeps all records from the left table.
RIGHT JOIN keeps all records from the right table.

------------------------------------------------------------

FULL OUTER JOIN:
Returns all rows from both tables. Matching rows are
combined, while non-matching rows from either table
are filled with NULL values.

Example:
SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
FULL OUTER JOIN orders o
ON c.customer_id = o.customer_id;

Use Case:
A FULL OUTER JOIN is useful when you want to identify:
1. Customers who have not placed any orders.
2. Orders that do not have a matching customer.
3. All matching customer-order records.

It is commonly used for data auditing and checking
referential integrity between related tables.
*/
*/




/*  Q23. Identify all Foreign Key relationships in the schema. Explain what would happen if you tried to insert an
 order with customer_id = 999 (which doesn't exist in customers).
INSERT INTO orders
(order_id, customer_id, order_date, status, total_amount)
VALUES
(101, 999, '2024-08-01', 'Pending', 5000.00);

The INSERT statement conflicted with the FOREIGN KEY constraint.
The conflict occurred in table 'customers', column 'customer_id'.

*/ 


