-------------------------------------------------------------
-- Query 15 : Cohort Analysis
-------------------------------------------------------------

WITH cohorts AS (

SELECT

customer_id,

strftime('%Y-%m',registration_date)

AS cohort

FROM customers

),

activity AS (

SELECT

o.customer_id,

strftime('%Y-%m',o.order_date)

AS activity_month,

c.cohort

FROM orders o

JOIN cohorts c

ON o.customer_id=c.customer_id

)

SELECT

cohort,

activity_month,

COUNT(DISTINCT customer_id)

AS active_customers

FROM activity

GROUP BY

cohort,

activity_month

ORDER BY

cohort,

activity_month;

-------------------------------------------------------------
-- Query 16 : Frequently Bought Together
-------------------------------------------------------------

SELECT

oi1.product_id AS product_a,

oi2.product_id AS product_b,

COUNT(*) AS times_bought_together

FROM order_items oi1

JOIN order_items oi2

ON oi1.order_id=oi2.order_id

AND oi1.product_id<oi2.product_id

GROUP BY

oi1.product_id,

oi2.product_id
ORDER BY
times_bought_together DESC;