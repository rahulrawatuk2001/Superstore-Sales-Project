# Superstore Sales — SQL + Power BI Analytics Pipeline

This project shows an end-to-end sales analytics workflow. The raw Superstore Sales 
data was cleaned and validated in MySQL, then imported into Power BI for data 
modeling, DAX calculations, and dashboard creation.

## Tools Used
- MySQL
- Power BI

## Data Cleaning (SQL)
- Converted missing values in Sales, Profit, Order Date, and City to NULL instead of deleting rows.
- Removed corrupted characters from the Sales column caused by an encoding issue during data import into MySQL.
- Converted columns to the correct data types.
- Corrected spelling mistakes in the Sub-Category column.
- Split the City column from the "City, State" format.
- Removed duplicate records using ROW_NUMBER().

## Business Validation
- Deleted rows with negative Sales values.
- Replaced invalid Discount values with NULL (row preserved, not deleted).
- Corrected negative Quantity values using ABS().

## Power BI Data Model
- Built a star schema with Orders as the fact table, connected to Date, Customer, 
  Product, and Location dimension tables.
- Created a Date table using CALENDARAUTO().
- Removed duplicate location records to avoid a many-to-many relationship issue 
  between the fact and Location tables.

## DAX Measures
- Total Sales
- Total Profit
- Profit Margin %
- Total Orders
- Average Order Value (AOV)
- Year-over-Year (YoY) Growth % — used SAMEPERIODLASTYEAR with a VAR-based fix to 
  avoid incorrect results when no year is selected.

## Dashboard

### Page 1
- KPI cards
- Monthly Sales and Profit Trend
- Category Performance
- Segment Analysis

### Page 2
- Key Business Insights
- Business recommendations based on dashboard findings

## Power Query
Power Query was used for minor data preparation, including text formatting 
(Trim, Capitalize Each Word) and date conversion, before loading the data into 
the Power BI model.

## Project Workflow
Raw Dataset → MySQL Data Cleaning → Business Validation → Power BI Data Model → 
DAX Measures → Interactive Dashboard
