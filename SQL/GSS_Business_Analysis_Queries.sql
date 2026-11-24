/*
PROJECT: GLOBAL SUPERSTORE SALES ANALYSIS
PURPOSE: Business-focused SQL analysis for the GSS Power BI project
DATABASE: SQL Server
SOURCE TABLE: dbo.GlobalSuperStore

SOURCE COLUMNS USED:
[Order_ID], [Order_Date], [Ship_Mode], [Customer_ID], [Customer_Name],
[Segment], [City], [State], [Country], [Postal_Code], [Market], [Region],
[Product_ID], [Category], [Sub_Category], [Product_Name], [Sales],
[Quantity], [Discount], [Profit], [Shipping_Cost], [Order_Priority]

NOTE:
1. Import the raw dataset into SQL Server using the exact column names listed above.
2. Name the table dbo.GlobalSuperStore, or replace that name below with your table name.
3. Keep the source column names as imported, including spaces.
*/


/* ============================================================
   1. OVERALL BUSINESS PERFORMANCE
   Business question: What are the key business KPIs?
   ============================================================ */
SELECT
    SUM([Sales]) AS TOTAL_SALES,
    SUM([Profit]) AS TOTAL_PROFIT,
    SUM([Quantity]) AS TOTAL_QUANTITY_SOLD,
    COUNT(DISTINCT [Order_ID]) AS TOTAL_ORDERS,
    COUNT(DISTINCT [Customer_ID]) AS TOTAL_CUSTOMERS,
    SUM([Profit]) * 100.0 / NULLIF(SUM([Sales]), 0) AS PROFIT_MARGIN_PERCENT
FROM dbo.GlobalSuperStore;


/* ============================================================
   2. YEARLY SALES AND PROFIT TREND
   Business question: How do sales and profit change year by year?
   ============================================================ */
SELECT
    YEAR([Order_Date]) AS SALES_YEAR,
    SUM([Sales]) AS TOTAL_SALES,
    SUM([Profit]) AS TOTAL_PROFIT,
    COUNT(DISTINCT [Order_ID]) AS TOTAL_ORDERS
FROM dbo.GlobalSuperStore
GROUP BY YEAR([Order_Date])
ORDER BY SALES_YEAR;


/* ============================================================
   3. MONTHLY SALES TREND
   Business question: Which months generate the highest sales?
   ============================================================ */
SELECT
    YEAR([Order_Date]) AS SALES_YEAR,
    MONTH([Order_Date]) AS SALES_MONTH,
    DATENAME(MONTH, [Order_Date]) AS MONTH_NAME,
    SUM([Sales]) AS TOTAL_SALES,
    SUM([Profit]) AS TOTAL_PROFIT
FROM dbo.GlobalSuperStore
GROUP BY
    YEAR([Order_Date]),
    MONTH([Order_Date]),
    DATENAME(MONTH, [Order_Date])
ORDER BY
    SALES_YEAR,
    SALES_MONTH;


/* ============================================================
   4. CATEGORY-WISE PERFORMANCE
   Business question: Which category contributes the most sales
   and profit?
   ============================================================ */
SELECT
    [Category],
    SUM([Sales]) AS TOTAL_SALES,
    SUM([Profit]) AS TOTAL_PROFIT,
    SUM([Quantity]) AS TOTAL_QUANTITY,
    SUM([Profit]) * 100.0 / NULLIF(SUM([Sales]), 0) AS PROFIT_MARGIN_PERCENT
FROM dbo.GlobalSuperStore
GROUP BY [Category]
ORDER BY TOTAL_SALES DESC;


/* ============================================================
   5. SUB-CATEGORY PROFITABILITY
   Business question: Which sub-categories are profitable or
   loss-making?
   ============================================================ */
SELECT
    [Category],
    [Sub_Category],
    SUM([Sales]) AS TOTAL_SALES,
    SUM([Profit]) AS TOTAL_PROFIT,
    SUM([Quantity]) AS TOTAL_QUANTITY,
    SUM([Profit]) * 100.0 / NULLIF(SUM([Sales]), 0) AS PROFIT_MARGIN_PERCENT
FROM dbo.GlobalSuperStore
GROUP BY
    [Category],
    [Sub_Category]
ORDER BY TOTAL_PROFIT;


/* ============================================================
   6. CUSTOMER SEGMENT ANALYSIS
   Business question: Which customer segment contributes the
   highest revenue and profit?
   ============================================================ */
SELECT
    [Segment],
    SUM([Sales]) AS TOTAL_SALES,
    SUM([Profit]) AS TOTAL_PROFIT,
    COUNT(DISTINCT [Order_ID]) AS TOTAL_ORDERS,
    COUNT(DISTINCT [Customer_ID]) AS TOTAL_CUSTOMERS
FROM dbo.GlobalSuperStore
GROUP BY [Segment]
ORDER BY TOTAL_SALES DESC;


/* ============================================================
   7. MARKET-WISE PERFORMANCE
   Business question: Which market is the strongest in sales
   and profitability?
   ============================================================ */
SELECT
    [Market],
    SUM([Sales]) AS TOTAL_SALES,
    SUM([Profit]) AS TOTAL_PROFIT,
    COUNT(DISTINCT [Order_ID]) AS TOTAL_ORDERS,
    SUM([Profit]) * 100.0 / NULLIF(SUM([Sales]), 0) AS PROFIT_MARGIN_PERCENT
FROM dbo.GlobalSuperStore
GROUP BY [Market]
ORDER BY TOTAL_SALES DESC;


/* ============================================================
   8. REGION-WISE PERFORMANCE
   Business question: Which regions generate the highest sales
   and profit margins?
   ============================================================ */
SELECT
    [Region],
    SUM([Sales]) AS TOTAL_SALES,
    SUM([Profit]) AS TOTAL_PROFIT,
    SUM([Profit]) * 100.0 / NULLIF(SUM([Sales]), 0) AS PROFIT_MARGIN_PERCENT
FROM dbo.GlobalSuperStore
GROUP BY [Region]
ORDER BY TOTAL_SALES DESC;


/* ============================================================
   9. TOP 10 COUNTRIES BY SALES
   Business question: Which countries are the biggest markets?
   ============================================================ */
SELECT TOP 10
    [Country],
    SUM([Sales]) AS TOTAL_SALES,
    SUM([Profit]) AS TOTAL_PROFIT,
    COUNT(DISTINCT [Order_ID]) AS TOTAL_ORDERS
FROM dbo.GlobalSuperStore
GROUP BY [Country]
ORDER BY TOTAL_SALES DESC;


/* ============================================================
   10. TOP 10 CUSTOMERS BY SALES
   Business question: Who are the highest-value customers?
   ============================================================ */
SELECT TOP 10
    [Customer_ID],
    [Customer_Name],
    SUM([Sales]) AS TOTAL_SALES,
    SUM([Profit]) AS TOTAL_PROFIT,
    COUNT(DISTINCT [Order_ID]) AS TOTAL_ORDERS
FROM dbo.GlobalSuperStore
GROUP BY
    [Customer_ID],
    [Customer_Name]
ORDER BY TOTAL_SALES DESC;


/* ============================================================
   11. TOP 10 PRODUCTS BY SALES
   Business question: Which products generate the most revenue?
   ============================================================ */
SELECT TOP 10
    [Product_ID],
    [Product_Name],
    [Category],
    [Sub_Category],
    SUM([Sales]) AS TOTAL_SALES,
    SUM([Profit]) AS TOTAL_PROFIT,
    SUM([Quantity]) AS TOTAL_QUANTITY
FROM dbo.GlobalSuperStore
GROUP BY
    [Product_ID],
    [Product_Name],
    [Category],
    [Sub_Category]
ORDER BY TOTAL_SALES DESC;


/* ============================================================
   12. DISCOUNT IMPACT ON PROFITABILITY
   Business question: How do discount ranges affect sales and
   profit?
   ============================================================ */
SELECT
    CASE
        WHEN [Discount] = 0 THEN '0% - No Discount'
        WHEN [Discount] <= 0.10 THEN 'Above 0% to 10%'
        WHEN [Discount] <= 0.20 THEN 'Above 10% to 20%'
        WHEN [Discount] <= 0.30 THEN 'Above 20% to 30%'
        WHEN [Discount] <= 0.50 THEN 'Above 30% to 50%'
        ELSE 'Above 50%'
    END AS DISCOUNT_RANGE,
    COUNT(*) AS TRANSACTION_COUNT,
    SUM([Sales]) AS TOTAL_SALES,
    SUM([Profit]) AS TOTAL_PROFIT,
    AVG([Discount]) AS AVERAGE_DISCOUNT
FROM dbo.GlobalSuperStore
GROUP BY
    CASE
        WHEN [Discount] = 0 THEN '0% - No Discount'
        WHEN [Discount] <= 0.10 THEN 'Above 0% to 10%'
        WHEN [Discount] <= 0.20 THEN 'Above 10% to 20%'
        WHEN [Discount] <= 0.30 THEN 'Above 20% to 30%'
        WHEN [Discount] <= 0.50 THEN 'Above 30% to 50%'
        ELSE 'Above 50%'
    END
ORDER BY MIN([Discount]);


/* ============================================================
   13. SHIPPING MODE ANALYSIS
   Business question: Which shipping modes contribute the most
   orders, sales and profit?
   ============================================================ */
SELECT
    [Ship_Mode],
    COUNT(DISTINCT [Order_ID]) AS TOTAL_ORDERS,
    SUM([Sales]) AS TOTAL_SALES,
    SUM([Profit]) AS TOTAL_PROFIT,
    AVG([Shipping_Cost]) AS AVG_SHIPPING_COST
FROM dbo.GlobalSuperStore
GROUP BY [Ship_Mode]
ORDER BY TOTAL_SALES DESC;


/* ============================================================
   14. AVERAGE ORDER VALUE (AOV)
   Business question: What is the average revenue generated
   per distinct order?
   ============================================================ */
WITH ORDER_LEVEL_SALES AS
(
    SELECT
        [Order_ID],
        SUM([Sales]) AS ORDER_SALES
    FROM dbo.GlobalSuperStore
    GROUP BY [Order_ID]
)
SELECT
    COUNT(*) AS TOTAL_ORDERS,
    AVG(ORDER_SALES) AS AVERAGE_ORDER_VALUE
FROM ORDER_LEVEL_SALES;


/* ============================================================
   15. MONTH-OVER-MONTH SALES GROWTH
   Business question: How much did sales increase or decrease
   compared with the previous month?
   ============================================================ */
WITH MONTHLY_SALES AS
(
    SELECT
        DATEFROMPARTS(YEAR([Order_Date]), MONTH([Order_Date]), 1) AS SALES_MONTH,
        SUM([Sales]) AS TOTAL_SALES
    FROM dbo.GlobalSuperStore
    GROUP BY
        YEAR([Order_Date]),
        MONTH([Order_Date])
),
SALES_WITH_PREVIOUS_MONTH AS
(
    SELECT
        SALES_MONTH,
        TOTAL_SALES,
        LAG(TOTAL_SALES) OVER (ORDER BY SALES_MONTH) AS PREVIOUS_MONTH_SALES
    FROM MONTHLY_SALES
)
SELECT
    SALES_MONTH,
    TOTAL_SALES,
    PREVIOUS_MONTH_SALES,
    TOTAL_SALES - PREVIOUS_MONTH_SALES AS SALES_DIFFERENCE,
    (TOTAL_SALES - PREVIOUS_MONTH_SALES) * 100.0
        / NULLIF(PREVIOUS_MONTH_SALES, 0) AS MOM_GROWTH_PERCENT
FROM SALES_WITH_PREVIOUS_MONTH
ORDER BY SALES_MONTH;
