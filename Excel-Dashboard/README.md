# Superstore Sales — Excel Dashboard

## Overview
This project analyzes the Superstore Sales dataset using only Excel. The goal was to clean the raw data and build an interactive dashboard using Excel Pivot Tables and Charts.

## Tools Used
- Microsoft Excel (Pivot Tables, Pivot Charts, Slicers, Formulas, Find & Replace)

## Workflow
The file has 5 sheets, and each one has a specific job:
1. **Raw Data** – the original, unedited dataset (10,014 rows)
2. **Working Data** – cleaned version of the data (missing values handled, duplicates removed, and invalid values corrected) — 9,986 rows after cleaning
3. **Metrics** – pivot tables that calculate totals, averages, and breakdowns
4. **Dashboard** – the final visual dashboard built from the pivot tables
5. **Insights** – written observations about what the dashboard shows

## Data Cleaning
- All columns were originally in the General format. Data types were corrected for Order Date, Ship Date, Sales, Profit, Quantity, and Discount so they worked correctly in formulas and Pivot Tables.
- Missing values in Sales, Profit, and Order Date were treated as blank, not deleted.
- Order Date had 22 rows with "N/A" as text — removed using Find & Replace, so they became true blanks.
- Profit had 12 rows with "unknown" and 8 rows with "N/A" — both removed using Find & Replace, so they became blank (35 rows were already blank and were left as is).
- City had 10 rows where the state name was stuck after a comma (e.g. "Mobile, Alabama") — the state part was removed using Find & Replace, keeping just the city name.
- Sub-Category had spelling mistakes in 6 values (extra letter at the end, like "Bookcasess" instead of "Bookcases") — fixed using Find & Replace.
- Ship Mode and Customer Name had extra leading/trailing spaces — removed using TRIM().
- Sales had 13 rows with a ? symbol stuck to the number — removed using Find & Replace so the values became usable numbers.
- Invalid Discount values (outside the 0–1 range) were cleared, but the row was kept, since the row itself was still a valid transaction.
- Quantity had 9 rows with a negative value (-1) — this was a sign error, not a real return/refund entry, so it was corrected using ABS() rather than removing the row.
- Rows with negative Sales were removed entirely (all columns, not just the Sales value), since there was no way to justify keeping an invalid transaction.
- Duplicate rows were removed using Remove Duplicates, checking all columns except Row ID and Order ID.

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
