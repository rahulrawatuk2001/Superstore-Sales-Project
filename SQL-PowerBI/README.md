# Superstore Sales — SQL + Power BI Analytics Pipeline

## Overview
This project shows an end-to-end sales analytics workflow. The raw Superstore Sales data was cleaned and checked in MySQL, then imported into Power BI to create table relationships, DAX measures, and an interactive dashboard.

## Aim
The main aim of this project was to analyze sales performance and profitability — Sales, Profit, and Profit Margin — across different months, categories, segments, and sub-categories, along with overall business metrics like Total Orders , AOV and YoY Growth %. The goal was to identify important patterns and differences in sales and profitability, and present the findings through an interactive Power BI dashboard.

## Tools Used
MySQL
Power BI (Power Query + DAX)

## Step 1: Database Setup
Created a new database (sales) and loaded the raw Superstore Sales data into it as the superstore_sales table.

## Step 2: Data Understanding
Checked total row count and distinct Row_id count to confirm the raw data size before touching anything.
Checked which rows had missing or blank values in the key columns (Order ID, Order Date, Sales, Profit, Region, Segment, Category) before deciding a cleaning plan.

## Step 3: Duplicate Check (Initial)
Grouped by every column and used HAVING COUNT(*) > 1 to see if any fully duplicate rows existed before cleaning started.

## Step 4: Data Cleaning

**Missing Values**

Counted blank/invalid values first in Sales, Profit, Order Date, and City.
Sales: blank values ("") converted to NULL.
Profit: blank, "unknown", and "N/A" values all converted to NULL.
Order Date: "N/A" text values converted to NULL.
City: blank values converted to NULL.
Decision: NULL was used instead of deleting rows, because SUM()/AVG() in SQL automatically skip NULL values, so the row's other data (Region, Category, etc.) doesn't get lost.

**Removing Unwanted Symbols**

Found a currency-encoding issue in the Sales column — values were prefixed with ? instead of a clean number (happened during import into MySQL). Removed this symbol using REPLACE().

**Data Type Conversion**

Sales and Profit converted to DECIMAL(10,2).
Quantity converted to INT.
Discount converted to DECIMAL(3,2).

**Text Standardization**

Fixed spelling mistakes in Sub-Category (example: "Accessoriess" → "Accessories", "Bookcasess" → "Bookcases", "Furnishingss" → "Furnishings", "Machiness" → "Machines", "Storagee" → "Storage", "Appliancess" → "Appliances").
City column had State name attached in a "City, State" format — split it using SUBSTRING_INDEX() to keep only the City name.

**Duplicate Removal (Final)**

Used ROW_NUMBER() with PARTITION BY across all columns to identify duplicate rows, then deleted the extra copies (kept the first occurrence, rn = 1), verified afterward with a SELECT COUNT(*) check.

## Step 5: Business Validation
Negative Sales: Rows with Sales less than 0 were deleted completely — these were treated as genuinely invalid data entries, and there is no Refund column to explain them as valid.
Invalid Discount: Rows where Discount was less than 0 or greater than 1 (not a valid percentage) — only the Discount value was set to NULL, the row itself was kept.
Negative Quantity: Fixed using ABS() to convert negative values to positive, treated as a sign-entry mistake rather than deleting the row.
Verified each fix afterward with SELECT COUNT(*) checks to confirm no invalid values remained.

## Step 6: Business SQL Queries
Wrote SQL queries to calculate the main business metrics before building the dashboard. These results were later compared with the Power BI DAX measures to make sure the numbers matched:

Total Sales, Total Profit, Profit Margin % (Profit / Sales × 100)
Total Orders (distinct Order ID count)
Average Order Value (AOV = Total Sales / Total Orders)
Year-over-Year Growth % (using LAG() window function to compare each year's sales to the previous year)
Monthly Sales and Profit trend
Sales and Profit Margin % by Category
Sales by Segment
Category + Sub-Category level Sales, Profit, and Profit Margin overview

## Step 7: Power Query
Connected Power BI to MySQL using Get Data, and imported the cleaned superstore_sales table.
Power Query was used only for minor data preparation, since all major data cleaning and business logic were already handled in SQL:

Text formatting (Trim, Capitalize Each Word).
Date conversion for the Date table.

## Step 8: Power BI Data Model
After Close & Apply, built a star schema — Orders as the fact table, connected to Date, Customer, Product, and Location dimension tables.
Created a Date table using CALENDARAUTO().
Removed duplicate records from the Location table to avoid a many-to-many relationship issue between the fact table and Location.

## Step 9: DAX Measures
Total Sales
Total Profit
Profit Margin % — using DIVIDE() to avoid divide-by-zero errors.
Total Orders — DISTINCTCOUNT() on Order ID.
Average Order Value (AOV)
Year-over-Year (YoY) Growth % — used SAMEPERIODLASTYEAR() with a VAR-based fix, because the direct formula was returning incorrect results (over 3000%) when no year filter was selected on the page.

## Step 10: Dashboard

**Page 1 — Overview**

Slicers: Category, Region, Year
KPI Cards: Total Sales, Total Profit, Profit Margin %, Total Orders, AOV, YoY Growth %
Monthly Sales and Profit line chart
Category + Sub-Category pivot table (Sales, Profit, Profit Margin %)
Sales by Segment donut chart
Category-wise Sales and Profit Margin combo chart

**Page 2 — Chart-wise Insights**

Each chart from Page 1 is explained using Pattern, Reason, and Suggestion:

Monthly Sales and Profit: Sales and Profit fluctuate through the year with no consistent trend — Sales stays between 3.00M and 3.40M every month. Profit doesn't always move with Sales — August has the highest Sales (3.40M) but not the highest Profit, while November has the highest Profit (307.4K) but not the highest Sales.

Category-wise Sales and Profit Margin: Technology has the highest Total Sales (13.17M), but Furniture has the highest Profit Margin (8.77%) — the category with the highest Sales isn't the most profitable one.

Sales by Segment: Consumer contributes the highest share of Sales at 43.79% (16.94M), followed by Corporate at 35.66% (13.80M), and Home Office at 20.55% (7.95M).

Category + Sub-Category Overview: Bookcases leads Furniture in Sales (4.03M), Profit (434.4K), and Profit Margin (10.77%). Envelopes has the highest Profit Margin in Office Supplies (11.61%). In Technology, Machines generate the highest Profit (343.8K), while Phones have the highest Profit Margin (8.70%).

**Page 3 — Key Findings and Business Recommendations**

Key Findings
Monthly Sales and Profit showed an irregular trend, with Sales and Profit not always moving together.
Technology generated the highest Total Sales, while Furniture achieved the highest Profit Margin.
Consumer contributed the largest share of total Sales.
Bookcases led Sales and Profit in Furniture, Envelopes recorded the highest Profit Margin in Office Supplies, and Machines generated the highest Profit in Technology.

Business Recommendations
Find out why Sales and Profit do not always move together every month.
Review why some high-Sales categories have lower Profit Margin and identify ways to improve it.
Continue focusing on the Consumer segment and look for ways to increase Corporate and Home Office sales.
Maintain the performance of top-performing Sub-Categories and find out why some Sub-Categories have lower Profit.

## Project Workflow
Raw Dataset → MySQL Data Cleaning → Business Validation → Power BI Data Model → DAX Measures → Interactive Dashboard
