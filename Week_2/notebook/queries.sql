-- View first 10 records
SELECT *
FROM sales
LIMIT 10;

-- Filter records from West region
SELECT *
FROM sales
WHERE Region = 'West';

-- Technology category products
SELECT *
FROM sales
WHERE Category = 'Technology';

-- Orders with sales greater than 500
SELECT *
FROM sales
WHERE Sales > 500;

-- Orders after 2017
SELECT *
FROM sales
WHERE "Order Date" >= '2017-01-01';

-- Total sales by category
SELECT Category,
ROUND(SUM(Sales),2) AS Total_Sales
FROM sales
GROUP BY Category;

-- Average profit by region
SELECT Region,
ROUND(AVG(Profit),2) AS Avg_Profit
FROM sales
GROUP BY Region;

-- Total quantity sold by sub-category
SELECT "Sub-Category",
SUM(Quantity) AS Total_Quantity
FROM sales
GROUP BY "Sub-Category";

-- Top 10 products by sales
SELECT "Product Name",
ROUND(SUM(Sales),2) AS Total_Sales
FROM sales
GROUP BY "Product Name"
ORDER BY Total_Sales DESC
LIMIT 10;

-- Top 5 customers by profit
SELECT "Customer Name",
ROUND(SUM(Profit),2) AS Total_Profit
FROM sales
GROUP BY "Customer Name"
ORDER BY Total_Profit DESC
LIMIT 5;

-- Monthly sales trend
SELECT substr("Order Date",1,7) AS Month,
ROUND(SUM(Sales),2) AS Monthly_Sales
FROM sales
GROUP BY Month
ORDER BY Month;

-- Region with highest sales
SELECT Region,
ROUND(SUM(Sales),2) AS Total_Sales
FROM sales
GROUP BY Region
ORDER BY Total_Sales DESC;

-- Loss making products
SELECT "Product Name",
ROUND(SUM(Profit),2) AS Total_Profit
FROM sales
GROUP BY "Product Name"
HAVING Total_Profit < 0
ORDER BY Total_Profit;

-- Detect duplicate records
SELECT *,
COUNT(*) as duplicate_count
FROM sales
GROUP BY "Row ID"
HAVING duplicate_count > 1;

-- Total row count
SELECT COUNT(*) AS Total_Rows
FROM sales;

-- Unique categories
SELECT DISTINCT Category
FROM sales;
