# Superstore Sales — Excel Dashboard

This project analyzes the Superstore Sales dataset using only Excel. The goal was to clean the raw data and build a pivot-based dashboard, without using SQL or Power BI.

## Tools Used
- Microsoft Excel (Pivot Tables, Pivot Charts, Slicers, Formulas, Find & Replace)

## Workflow
The file has 5 sheets, and each one has a specific job:
1. **Raw Data** – the original, unedited dataset
2. **Working Data** – cleaned version of the data (missing values handled, duplicates removed, wrong values fixed)
3. **Metrics** – pivot tables that calculate totals, averages, and breakdowns
4. **Dashboard** – the final visual dashboard built from the pivot tables
5. **Insights** – written observations about what the dashboard shows

## Data Cleaning
- All columns were originally set to "General" format in Excel, which doesn't distinguish dates from text or numbers from text. Data types were corrected for Order Date, Ship Date (Date format), Sales, Profit (Number, 2 decimals), Quantity (Number), and Discount (Percentage), so they work correctly in formulas and pivot tables.
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

## Dashboard
The dashboard has KPI cards for Total Sales, Total Profit, Profit Margin %, and Total Orders, along with a Year slicer to filter the data. It includes charts for:
- Monthly Sales and Profit trend
- Sales by Category and Region
- Top Customers by Sales
- Sales and Profit by Sub-Category
- Average Discount by Sub-Category

## Insights
Each insight follows a simple structure:
- **Pattern** – what the data shows
- **Reason** – a possible explanation, based only on the data
- **Suggestion** – what could be done about it

## Note
This project was built separately from the SQL + Power BI project, using a different tool and a different approach, but the same dataset. The idea was to show that the same analysis can be done in more than one way.
