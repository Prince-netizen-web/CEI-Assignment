-- ==========================================================
-- E-Commerce Order Analytics System
-- Basic SQL Queries
-- ==========================================================

-------------------------------------------------------------
-- Query 1: Total Revenue per Category
-------------------------------------------------------------
-- Revenue = quantity × unit_price × (1 - discount_percent/100)
-- Exclude cancelled orders and returned items

SELECT
    p.category,
    ROUND(
        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100.0)
        ),
        2
    ) AS total_revenue

FROM order_items oi

JOIN products p
    ON oi.product_id = p.product_id

JOIN orders o
    ON oi.order_id = o.order_id

WHERE
    oi.quantity > 0
    AND o.status != 'CANCELLED'

GROUP BY
    p.category

ORDER BY
    total_revenue DESC;


-------------------------------------------------------------
-- Query 2: Top 10 Customers by Total Order Value
-------------------------------------------------------------

SELECT

    c.customer_id,

    c.customer_name,

    ROUND(
        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100.0)
        ),
        2
    ) AS total_order_value

FROM customers c

JOIN orders o

ON c.customer_id = o.customer_id

JOIN order_items oi

ON o.order_id = oi.order_id

WHERE

    oi.quantity > 0

    AND o.status = 'DELIVERED'

GROUP BY

    c.customer_id,
    c.customer_name

ORDER BY

    total_order_value DESC

LIMIT 10;


-------------------------------------------------------------
-- Query 3: Month-wise Order Count (Last 12 Months)
-------------------------------------------------------------

SELECT

    strftime('%Y-%m', order_date) AS order_month,

    COUNT(*) AS total_orders

FROM orders

WHERE

    date(order_date) >= date('now','-12 months')

GROUP BY

    strftime('%Y-%m', order_date)

ORDER BY

    order_month;




-------------------------------------------------------------
-- Query 4: Customers Who Placed Orders but Never Had
-- Any Item Delivered
-------------------------------------------------------------

SELECT DISTINCT

    c.customer_id,
    c.customer_name,
    c.email

FROM customers c

JOIN orders o
ON c.customer_id = o.customer_id

WHERE c.customer_id NOT IN (

    SELECT DISTINCT customer_id

    FROM orders

    WHERE status = 'DELIVERED'

      AND customer_id IS NOT NULL

)

ORDER BY c.customer_id;


-------------------------------------------------------------
-- Query 5: Products That Had More Returns Than Purchases
-------------------------------------------------------------

SELECT

    p.product_id,
    p.product_name,

    SUM(
        CASE
            WHEN o.status = 'RETURNED'
            THEN ABS(oi.quantity)
            ELSE 0
        END
    ) AS returned_items,

    SUM(
        CASE
            WHEN o.status = 'DELIVERED'
            THEN oi.quantity
            ELSE 0
        END
    ) AS purchased_items

FROM products p

JOIN order_items oi

ON p.product_id = oi.product_id

JOIN orders o

ON oi.order_id = o.order_id

GROUP BY

    p.product_id,
    p.product_name

HAVING

    returned_items > purchased_items

ORDER BY

    returned_items DESC;


-------------------------------------------------------------
-- Query 6: Return Rate Per Category
-------------------------------------------------------------

SELECT

    p.category,

    SUM(
        CASE
            WHEN o.status = 'RETURNED'
            THEN ABS(oi.quantity)
            ELSE 0
        END
    ) AS returned_items,

    SUM(ABS(oi.quantity)) AS total_items,

    ROUND(

        (
            SUM(
                CASE
                    WHEN o.status='RETURNED'
                    THEN ABS(oi.quantity)
                    ELSE 0
                END
            )

            *100.0

            /

            SUM(ABS(oi.quantity))

        ),

        2

    ) AS return_rate_percent

FROM products p

JOIN order_items oi

ON p.product_id = oi.product_id

JOIN orders o

ON oi.order_id = o.order_id

GROUP BY

    p.category

ORDER BY

    return_rate_percent DESC;