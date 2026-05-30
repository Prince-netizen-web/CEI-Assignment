-- =========================================
-- Section C — Aggregation (GROUP BY, SUM, COUNT, AVG, MIN, MAX)
-- =========================================

-- Q13. Count the total number of orders in the orders table.
SELECT * from orders;
SELECT count(order_id) as total_orderes from orders;

-- Q14. Find the total revenue (SUM of total_amount) from all 'Delivered' orders.
SELECT SUM(total_amount) as total_delivered_amount from orders where status='Delivered';

-- Q15. Calculate the average unit_price of products in each category.
SELECT * from products;
SELECT category,
AVG(unit_price) as avg_price  
from products
GROUP BY category;

-- Q16. For each order status, find the count of orders and the total revenue. Sort the result by total revenue in
-- descending order.

SELECT status, 
	COUNT(order_id) as count_of_items, 
	SUM(total_amount) as total_revenue
FROM orders
GROUP BY status
ORDER BY total_revenue desc;


-- Q17. Find the most expensive (MAX) and cheapest (MIN) product in each category
SELECT category,
	   MAX(unit_price) as expensive ,
	   min(unit_price) as cheapest
FROM products
GROUP BY category;

-- Q18. List all product categories where the average unit_price is greater than ₹2000. (Hint: Use HAVING
-- clause)

Select * from products;
SELECT category,
		AVG(unit_price) as avg_unit_price
FROM products
GROUP BY category
HAVING AVG(unit_price) > 2000;