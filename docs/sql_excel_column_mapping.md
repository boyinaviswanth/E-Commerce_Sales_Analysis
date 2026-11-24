# SQL and Excel Column-Name Mapping

The supplied SQL script expects table `dbo.GlobalSuperStore` and underscore-style column names. The Excel worksheet uses headers with spaces.

| SQL script column | Excel worksheet header |
|---|---|
| Order_ID | Order ID |
| Order_Date | Order Date |
| Ship_Mode | Ship Mode |
| Customer_ID | Customer ID |
| Customer_Name | Customer Name |
| Postal_Code | Postal Code |
| Product_ID | Product ID |
| Sub_Category | Sub-Category |
| Product_Name | Product Name |
| Shipping_Cost | Shipping Cost |
| Order_Priority | Order Priority |

Before executing the SQL file, either rename the Excel columns during SQL Server import to match the SQL script, or update the SQL identifiers to match the imported headers. Do not execute the script unchanged against a table whose headers still contain spaces.
