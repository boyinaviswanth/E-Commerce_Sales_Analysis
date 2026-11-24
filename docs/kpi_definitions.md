# KPI Definitions

Definitions below are based on the supplied SQL analysis file and dashboard metric labels. Confirm exact DAX expressions in the PBIX before claiming exact measure semantics.

| KPI | Mathematical calculation | Columns |
|---|---|---|
| Total Sales | SUM(Sales) | Sales |
| Total Profit | SUM(Profit) | Profit |
| Total Quantity Sold | SUM(Quantity) | Quantity |
| Total Orders | COUNT(DISTINCT Order ID) | Order ID |
| Total Customers | COUNT(DISTINCT Customer ID) | Customer ID |
| Profit Margin % | (Total Profit / Total Sales) × 100 | Profit, Sales |
| Average Sales | Average of Sales values at transaction-row level, if implemented as a column average | Sales |
| Average Profit | Average of Profit values at transaction-row level, if implemented as a column average | Profit |
| Average Order Value | Average of order-level sales totals; equivalently Total Sales / distinct orders | Order ID, Sales |
| Average Shipping Cost | Average Shipping Cost | Shipping Cost |
| MoM Sales Growth % | ((Current Month Sales − Previous Month Sales) / Previous Month Sales) × 100 | Order Date, Sales |
| MoM Profit Growth % | ((Current Month Profit − Previous Month Profit) / Previous Month Profit) × 100 | Order Date, Profit |
| YoY Sales Growth % | ((Current Year Sales − Previous Year Sales) / Previous Year Sales) × 100 | Order Date, Sales |
| Contribution % | (Selected attribute metric / total metric) × 100 | Selected attribute and metric |
| Top N | Rank entities by selected metric and return selected N | Selected attribute and metric |

SQL percentage calculations use NULLIF to protect against division by zero.

Note: The exact DAX definitions for dashboard cards and dynamic calculations must be checked in the PBIX. Average Sales and Average Profit should not be assumed to mean Average Order Value or profit per order.
