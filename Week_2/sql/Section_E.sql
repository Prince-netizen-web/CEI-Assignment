-- =========================================
-- Section E — Advanced Concepts (CASE, ACID, Transactions)
-- =========================================

/*
Q24. Write a query using CASE to classify products into price tiers:
 • 'Budget' → unit_price < 1000
 • 'Mid-Range' → unit_price BETWEEN 1000 AND 3000
 • 'Premium' → unit_price > 3000
Display: product_name, unit_price, price_tier.
*/

SELECT * from products;
SELECT product_name,
	   unit_price,
CASE when unit_price < 1000 then 'Budget'
when unit_price between 1000 and 3000 then 'Mid-Range'
else 'Premium'
end as price_tier
from products;

-- Q25. Using a CASE statement inside an aggregate function, count how many orders are 'Delivered' vs 'Not
-- Delivered' (all other statuses). Display the result in a single row.
SELECT * from orders;

SELECT
    SUM(CASE
            WHEN status = 'Delivered' THEN 1
            ELSE 0
        END) AS Delivered_Orders,

    SUM(CASE
            WHEN status <> 'Delivered' THEN 1
            ELSE 0
        END) AS Not_Delivered_Orders
FROM orders;

/*

Q26. Explain each letter of ACID:
 • A – Atomicity
 • C – Consistency
 • I – Isolation
 • D – Durability
Give a real-world example (e.g., bank transfer) showing why each property is important.

-- =====================================
-- Q26. ACID Properties
-- =====================================

/*
A - Atomicity
A transaction is treated as a single unit of work.
Either all operations succeed or all operations fail.

Example:
In a bank transfer of ₹1000 from Account A to Account B,
the amount must be deducted from Account A and added to Account B.
If either step fails, the entire transaction is rolled back.

------------------------------------------------------------

C - Consistency
A transaction must take the database from one valid state
to another valid state while maintaining all rules,
constraints, and relationships.

Example:
Before a bank transfer:
Account A = ₹5000
Account B = ₹3000
Total = ₹8000

After transferring ₹1000:
Account A = ₹4000
Account B = ₹4000
Total = ₹8000

The total amount of money remains unchanged,
maintaining consistency.

------------------------------------------------------------

I - Isolation
Multiple transactions running at the same time should not
interfere with each other.

Example:
If two customers simultaneously withdraw money from the
same account, each transaction should execute independently
to prevent incorrect balances or lost updates.

------------------------------------------------------------

D - Durability
Once a transaction is committed, its changes are permanently
stored and will survive system failures.

Example:
After a successful bank transfer, the updated account
balances remain saved even if there is a power failure,
server crash, or database restart.

------------------------------------------------------------

Bank Transfer Summary:
Atomicity  -> Transfer happens completely or not at all.
Consistency -> Total money remains correct.
Isolation   -> Concurrent transfers do not interfere.
Durability  -> Committed transfer remains saved permanently.
*/
GO

*/
		
/* 
 Q27. Write a SQL transaction that does the following atomically:
 1. Insert a new order (order_id=1011, customer_id=102, today's date, 'Pending', 1598.00)
 2. Insert two order items for that order
 3. Update the stock_qty of the purchased products
 4. If any step fails, ROLLBACK the entire transaction. Otherwise, COMMIT.
 Write the complete BEGIN...COMMIT/ROLLBACK block.
 */

 BEGIN TRY
    BEGIN TRANSACTION;

    -- Step 1: Insert new order
    INSERT INTO orders
        (order_id, customer_id, order_date, status, total_amount)
    VALUES
        (1011, 102, CAST(GETDATE() AS DATE), 'Pending', 1598.00);

    -- Step 2: Insert order items
    INSERT INTO order_items
        (order_id, product_id, quantity, unit_price, discount_pct)
    VALUES
        (1011, 201, 2, 499.00, 0.00),
        (1011, 202, 1, 600.00, 0.00);

    -- Step 3: Update product stock
    UPDATE products
    SET stock_qty = stock_qty - 2
    WHERE product_id = 201;

    UPDATE products
    SET stock_qty = stock_qty - 1
    WHERE product_id = 202;

    -- Step 4: Commit if everything succeeds
    COMMIT TRANSACTION;

    PRINT 'Transaction completed successfully.';
END TRY

BEGIN CATCH
    -- Roll back if any error occurs
    ROLLBACK TRANSACTION;

    PRINT 'Transaction failed. All changes rolled back.';
    PRINT ERROR_MESSAGE();
END CATCH;

/*
(1 row affected)

(0 rows affected)
Transaction failed. All changes rolled back.
Cannot insert the value NULL into column 'item_id', table 'CEI_Assignments.dbo.order_items'; column does not allow nulls. INSERT fails.
*/