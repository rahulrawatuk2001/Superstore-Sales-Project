# Superstore Sales — Excel Dashboard

## Overview
This project analyzes the Superstore Sales dataset using only Excel. The goal was to clean the raw data and build an interactive dashboard using Excel Pivot Tables and Charts.

## Aim
The main aim of this project was to clean and analyze the Superstore Sales dataset using Excel to calculate key business metrics — Total Sales, Total Profit, Profit Margin %, and Total Orders — across Category, Region, Sub-Category, and Customers. The goal was to build an interactive Pivot Table-based dashboard with charts and slicers, and present the key patterns through Insights.

## Tools Used
- Microsoft Excel (Pivot Tables, Pivot Charts, Slicers, Formulas, Find & Replace)

## Workflow
The file has 5 sheets, and each one has a specific job:
- **Raw Data** – the original, unedited dataset (10,014 rows)
- **Working Data** – cleaned version of the data (missing values handled, duplicates removed, and invalid values corrected) — 9,986 rows after cleaning
- **Metrics** – pivot tables that calculate totals, averages, and breakdowns
- **Dashboard** – the final visual dashboard built from the pivot tables
- **Insights** – written observations about what the dashboard shows

## Data Cleaning Process
All initial fields were imported in `General` format. Data types and anomalies were addressed sequentially:

1. **Data Type Standardization:**
   - Converted `Order Date` and `Ship Date` to standard Date formats.
   - Converted `Sales`, `Profit`, `Quantity`, and `Discount` into appropriate Numeric/Currency formats for accurate formula and Pivot Table processing.

2. **Text Normalization & Trimming:**
   - **Leading/Trailing Whitespace:** Applied `TRIM()` to `Ship Mode` and `Customer Name` to eliminate trailing/leading space inconsistencies.
   - **City Field Standardization:** Corrected 10 rows where state names were appended after a comma (e.g., `"Mobile, Alabama"`) by stripping the state suffix to retain clean city names.
   - **Sub-Category Typos:** Corrected 6 misspelled entries with trailing characters (e.g., `"Bookcasess"` → `"Bookcases"`) via Find & Replace.

3. **Missing & Non-Standard Null Handling:**
   - **Order Date:** Identified 22 text instances of `"N/A"` and converted them to true blanks using Find & Replace.
   - **Profit:** Identified 12 instances of `"unknown"` and 8 instances of `"N/A"`, converting both to true blanks (in addition to 35 pre-existing blank rows).
   - **Missing Sales/Profit/Dates:** Kept true blank records intact without deleting entire rows to preserve transactional integrity where applicable.

4. **Numeric Cleansing & Outlier Treatment:**
   - **Sales Formatting Errors:** Removed stray `?` characters from 13 values via Find & Replace to restore numeric usability.
   - **Negative Sales Records:** Completely removed rows containing negative `Sales` values, as these represented irrecoverable corrupted transactions.
   - **Discount Boundary Violations:** Cleared invalid values outside the allowable range of 0.00 to 1.00 while retaining the underlying row.
   - **Quantity Sign Inversion:** Addressed 9 rows containing negative quantities (-1) by applying `ABS()`, treating them as sign-entry errors rather than returns.

5. **Deduplication:**
   - Ran Remove Duplicates across all attributes excluding `Row ID` and `Order ID`, resulting in a final cleaned dataset of 9,986 rows.

## Metrics (Pivot Tables)
- Total Sales, Total Profit, Profit Margin %, and Total Orders calculated at the top level.
- Monthly Sales and Profit Margin % by Year (2019–2022).
- Sales by Category and by Region.
- Sales by Customer Name (Top customers).
- Average Discount and Total Profit by Sub-Category.

## Dashboard
The dashboard has KPI cards for Total Sales, Total Profit, Profit Margin %, and Total Orders, along with a Year slicer to filter the data. It includes charts for:
- Monthly Sales vs Profit Margin % (trend line)
- Region-wise Sales
- Category Share (Sales split by Category)
- Top 10 Customers by Sales
- Average Discount % vs Profit by Sub-Category
- Sub-Category by Sales & Profit (table)

## Insights
Each chart includes a written insight using three parts: Pattern (what the data shows), Reason (possible explanation based on the data), and Suggestion (what to analyze or improve next).

- **Monthly Sales vs Profit Margin %:** Sales move between roughly 660K and 975K with no clear upward or downward trend, and Profit Margin % mostly stays between 5–13%, with one low point of around 3–4% in mid-2021. Higher Sales don't always lead to a higher Profit Margin.
- **Average Discount % vs Profit by Sub-Category:** Discount % varies across sub-categories, but Profit varies much more — higher Discount doesn't always mean lower Profit, so other factors likely affect Profit more than Discount alone.
- **Region-wise Sales:** Central has the highest Sales, followed by East and South, while West has the lowest Sales among all regions.
- **Top 10 Customers:** Brooke Gillingham has the highest Sales among the top 10 customers, and Benjamin Patterson has the lowest in this group.
- **Sub-Category by Sales & Profit:** Bookcases have both the highest Sales and the highest Profit. Labels have the lowest of both. Tables are an exception — their Sales are lower than Chairs, Phones, and Copiers, yet their Profit is higher than all three.
- **Category Share:** Furniture and Office Supplies each contribute about 34% of total Sales, while Technology contributes a slightly smaller share (32%) — Sales are distributed almost equally across all three categories.

## Project Workflow
Raw Dataset → Excel Data Cleaning (Working Data sheet) → Pivot Table Metrics → Dashboard (KPI Cards + Charts) → Insights
