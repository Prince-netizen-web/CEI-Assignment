-- ==========================================================
-- E-Commerce Order Analytics System
-- Advanced SQL Queries
-- ==========================================================

-------------------------------------------------------------
-- Query 7 : Running Total Revenue Per Region
-------------------------------------------------------------

WITH daily_revenue AS (

    SELECT
        o.region_code,
        DATE(o.order_date) AS order_date,

        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100.0)
        ) AS daily_revenue

    FROM orders o

    JOIN order_items oi
    ON o.order_id = oi.order_id

    WHERE oi.quantity > 0

    GROUP BY
        o.region_code,
        DATE(o.order_date)

)

SELECT

    region_code,

    order_date,

    ROUND(daily_revenue,2) AS daily_revenue,

    ROUND(

        SUM(daily_revenue) OVER(

            PARTITION BY region_code

            ORDER BY order_date

        ),

        2

    ) AS running_total

FROM daily_revenue

ORDER BY
region_code,
order_date;

-------------------------------------------------------------
-- Query 8 : Product Ranking Using DENSE_RANK
-------------------------------------------------------------

WITH revenue AS (

SELECT

    p.category,

    p.product_name,

    SUM(

        oi.quantity*
        oi.unit_price*
        (1-oi.discount_percent/100.0)

    ) AS total_revenue

FROM products p

JOIN order_items oi
ON p.product_id=oi.product_id

GROUP BY

    p.category,
    p.product_name

)

SELECT

category,

product_name,

ROUND(total_revenue,2),

DENSE_RANK() OVER(

PARTITION BY category

ORDER BY total_revenue DESC

) AS rank_in_category

FROM revenue

ORDER BY
category,
rank_in_category;

-------------------------------------------------------------
-- Query 9 : Days Between Consecutive Orders
-------------------------------------------------------------

WITH customer_orders AS (

SELECT

customer_id,

DATE(order_date) AS order_date,

LAG(DATE(order_date))

OVER(

PARTITION BY customer_id

ORDER BY DATE(order_date)

)

AS previous_order_date

FROM orders

WHERE customer_id IS NOT NULL

)

SELECT

customer_id,

order_date,

previous_order_date,

ROUND(

julianday(order_date)

-

julianday(previous_order_date)

)

AS days_gap

FROM customer_orders;

-------------------------------------------------------------
-- Query 10 : Customer Segmentation (Multi-Level CTE)
-------------------------------------------------------------

WITH monthly_revenue AS (

SELECT

o.customer_id,

strftime('%Y-%m',o.order_date) AS month,

SUM(

oi.quantity*
oi.unit_price*
(1-oi.discount_percent/100.0)

) AS revenue

FROM orders o

JOIN order_items oi

ON o.order_id=oi.order_id

GROUP BY

o.customer_id,

strftime('%Y-%m',o.order_date)

),

customer_segment AS (

SELECT

customer_id,

month,

revenue,

CASE

WHEN revenue>10000 THEN 'High'

WHEN revenue>=5000 THEN 'Medium'

ELSE 'Low'

END AS customer_category

FROM monthly_revenue

)

SELECT

month,

customer_category,

COUNT(*) AS total_customers

FROM customer_segment

GROUP BY

month,

customer_category

ORDER BY

month,

customer_category;

-------------------------------------------------------------
-- Query 11 : Customer Quartiles (NTILE)
-------------------------------------------------------------

WITH lifetime_value AS (

SELECT

o.customer_id,

SUM(

oi.quantity*
oi.unit_price*
(1-oi.discount_percent/100.0)

) AS total_value

FROM orders o

JOIN order_items oi

ON o.order_id=oi.order_id

GROUP BY

o.customer_id

)

SELECT

customer_id,

ROUND(total_value,2),

NTILE(4) OVER(

ORDER BY total_value DESC

) AS quartile,

CASE

WHEN NTILE(4) OVER(
ORDER BY total_value DESC)=1

THEN 'Platinum'

WHEN NTILE(4) OVER(
ORDER BY total_value DESC)=2

THEN 'Gold'

WHEN NTILE(4) OVER(
ORDER BY total_value DESC)=3

THEN 'Silver'

ELSE 'Bronze'

END AS quartile_label

FROM lifetime_value;

-------------------------------------------------------------
-- Query 12 : Year-over-Year Revenue
-------------------------------------------------------------

WITH revenue AS (

SELECT

strftime('%Y',order_date) AS year,

strftime('%m',order_date) AS month,

SUM(

oi.quantity*
oi.unit_price*
(1-oi.discount_percent/100.0)

) AS revenue

FROM orders o

JOIN order_items oi

ON o.order_id=oi.order_id

GROUP BY

year,

month

)

SELECT

year,

month,

ROUND(revenue,2),

ROUND(

LAG(revenue)

OVER(

PARTITION BY month

ORDER BY year

),

2

)

AS prev_year_revenue,

ROUND(

(

revenue-

LAG(revenue)

OVER(

PARTITION BY month

ORDER BY year

)

)

/

LAG(revenue)

OVER(

PARTITION BY month

ORDER BY year

)

*100,

2

)

AS yoy_growth_percent

FROM revenue;

-------------------------------------------------------------
-- Query 13 : First & Last Purchased Category
-------------------------------------------------------------

WITH purchase_history AS (

SELECT

o.customer_id,

p.category,

o.order_date,

ROW_NUMBER()

OVER(

PARTITION BY o.customer_id

ORDER BY o.order_date

)

AS first_order,

ROW_NUMBER()

OVER(

PARTITION BY o.customer_id

ORDER BY o.order_date DESC

)

AS last_order

FROM orders o

JOIN order_items oi

ON o.order_id=oi.order_id

JOIN products p

ON oi.product_id=p.product_id

)

SELECT

f.customer_id,

f.category AS first_category,

l.category AS last_category,

CASE

WHEN f.category=l.category

THEN 'No'

ELSE 'Yes'

END AS category_shift

FROM purchase_history f

JOIN purchase_history l

ON f.customer_id=l.customer_id

WHERE

f.first_order=1

AND

l.last_order=1;

-------------------------------------------------------------
-- Query 14 : Cumulative Revenue Distribution
-------------------------------------------------------------

WITH customer_revenue AS (

SELECT

o.customer_id,

SUM(

oi.quantity*
oi.unit_price*
(1-oi.discount_percent/100.0)

) AS revenue

FROM orders o

JOIN order_items oi

ON o.order_id=oi.order_id

GROUP BY

o.customer_id

),

ordered AS (

SELECT

customer_id,

revenue,

SUM(revenue) OVER(

ORDER BY revenue DESC

) AS cumulative_revenue,

SUM(revenue) OVER() AS total_revenue

FROM customer_revenue

)

SELECT

customer_id,

ROUND(revenue,2),

ROUND(cumulative_revenue,2),

ROUND(

cumulative_revenue*100.0/

total_revenue,

2

)

AS cumulative_percent

FROM ordered;



