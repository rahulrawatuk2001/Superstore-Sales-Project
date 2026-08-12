# Superstore Sales – Python EDA Project

## Overview
This project is an Exploratory Data Analysis (EDA) of the Superstore Sales dataset using Python. The goal was to clean the raw data, check it for quality issues, and find patterns in Sales and Profit using statistics and visualizations.

## Tools Used
- Python
- Pandas (data cleaning, statistics, aggregation)
- NumPy
- Matplotlib and Seaborn (visualization)
- Jupyter Notebook

## Dataset
- Raw file: `Superstore_sales.csv`
- Total rows before cleaning: 10,014
- Total columns: 21

## Step 1: Basic Exploration
Before touching the data, I explored it first using `.head()`, `.tail()`, `.sample()`, `.shape`, `.info()`, `.describe()`, `.columns`, and `.dtypes`. I also checked unique values and count of unique values for key categorical columns (Ship Mode, Segment, Region, Category, Sub-Category) to understand what values exist before cleaning.

## Step 2: Data Cleaning

**Missing Values**
- Checked missing values using `.isnull().sum()`.
- Order Date had 22 missing values, City had 18, Sales had 45, and Profit had 43.
- Sales and Profit missing values were kept as NaN because Pandas automatically ignores NaN values in functions like `.sum()` and `.mean()`, similar to how NULL works in SQL.

**Standardization**
- Removed invalid `~?` characters from the Sales column.
- Removed extra spaces from Ship Mode and Customer Name using `.str.strip()`.
- Standardized Region text to proper case using `.str.title()`.
- Fixed spelling mistakes in Sub-Category (example: "Furnishingss" → "Furnishings", "Bookcasess" → "Bookcases").
- Cleaned City column by removing State name that was incorrectly attached to some City values.
- Replaced invalid text like "unknown" and "N/A" in Profit column with proper NA (pd.NA) so they are treated as missing, not as text.

**Duplicate Check (Initial)**
- Ran `.duplicated().sum()` at this stage, which returned 0. (Final duplicate removal was done later, after all cleaning was complete, so that duplicates hidden by formatting/typos could also be caught.)

**Data Type Conversion**
- Converted Order Date and Ship Date to proper datetime format using `pd.to_datetime()` with `dayfirst=True` and `errors="coerce"` (mixed date formats in the raw data).
- Converted Sales and Profit to numeric type using `pd.to_numeric()` with `errors="coerce"`.

**Invalid Value Correction**
- Negative Sales: Found 8 rows with negative Sales values. Verified them first, then removed these rows completely since there is no Refund column to explain them as valid.
- Invalid Discount: Found 5 rows where Discount was greater than 1 (not a valid percentage). Instead of deleting the row, only the Discount value was set to null (NaN), keeping the rest of the row's data intact.
- Negative Quantity: Found 9 rows with negative Quantity. Fixed these using `.abs()` to convert them to positive, treating them as sign-entry mistakes rather than deleting the rows.

**Duplicate Removal (Final)**
- After all cleaning steps were done, duplicate rows were removed using `drop_duplicates()`, excluding Row ID and Order ID from the comparison (since these are unique identifiers and would never match even for genuine duplicate records).

## Step 3: Feature Engineering
- Added a new column, **Profit_margin**, calculated as `(Profit / Sales) * 100`.

## Step 4: Outlier Check
- Used the IQR (Interquartile Range) method to detect outliers.
- Sales column: 210 outliers found.
- Profit column: 1,156 outliers found.

## Step 5: Data Selection & Filtering
Practiced basic Pandas operations for selecting and filtering data:
- Selecting single/multiple columns, row slicing with `.iloc`, conditional selection with `.loc`.
- Filtering examples: Sales greater than 1000; Furniture orders with negative Profit.
- Sorting data by Profit (ascending).

## Step 6: Statistics
Calculated Mean, Median, Standard Deviation, and Variance for the Sales column. Also checked the most common Category using Mode.
Also checked correlation between Sales, Profit, Discount, and Quantity using `.corr()`.

## Step 7: Aggregation
- Grouped Sales by Region using `.groupby()` and `.agg()` (sum, mean, count).
- Checked value counts for Category.
- Built a pivot table showing Sales by Region and Category using `pd.pivot_table()`.

## Step 8: Visualizations & Insights

**1. Line Plot – Monthly Sales Trend**

<img src="images/chart1_monthly_sales_trend.png" width="500">

Sales go up and down every month from 2019 to 2022, with no steady increase or decrease. Some months (like early 2021) show very high sales, while others drop a lot. The chart alone doesn't explain why — deeper analysis by Category, Region, or Segment is needed.

**2. Bar Plot – Category-wise Sales**

<img src="images/chart2_category_sales.png" width="500">

Office Supplies had the highest Sales, Furniture was very close to it, while Technology had comparatively lower Sales than the other two categories.

**3. Scatter Plot – Discount vs Profit**

<img src="images/chart3_discount_vs_profit.png" width="500">

Discount only occurs at fixed levels (0.0, 0.1, 0.2, 0.3, 0.5 — no orders at 0.4). As Discount increases, the maximum Profit value decreases — at 0 discount, Profit goes up to ~6800, but at 0.5 discount, it only reaches ~2600.

**4. Box Plot – Profit by Category**

<img src="images/chart4_profit_by_category.png" width="500">

All three categories have both profit and loss orders, and all three contain many outliers (both high-profit and high-loss). Technology has some of the highest positive profit outliers.

**5. Heatmap – Correlation Matrix**

<img src="images/chart5_correlation_heatmap.png" width="500">

Sales and Quantity: moderate positive relationship (0.61). Sales and Profit: weak positive relationship (0.23). Sales and Discount: weak negative relationship (-0.2). Profit and Discount: almost no relationship (-0.049).

**6. Histogram – Sales Distribution**

<img src="images/chart6_sales_distribution.png" width="500">

Most Sales transactions are concentrated at lower values, and the number of transactions gradually decreases as Sales amount increases. A small number of transactions have very high Sales values, forming a long right tail (positively/right skewed distribution).

## Key Findings
- Multiple data-quality issues were identified and corrected: Region inconsistencies, Sub-Category typos, invalid Discount values, and negative Sales/Quantity values.
- Monthly Sales fluctuated across 2019–2022 with no consistent trend.
- Office Supplies and Furniture had nearly equal Sales, while Technology was slightly lower.
- Higher Discount levels showed lower maximum Profit, though the overall Discount–Profit relationship was weak.
- Sales and Quantity had a moderate positive relationship.
- All categories had both high-profit and high-loss outliers, with Technology showing some of the highest profit outliers.
- Most Sales transactions were low-value, with a few high-value orders forming a long right tail.

## Business Recommendations
- Review high-discount orders (especially 0.3 and 0.5) to understand their impact on profitability.
- Investigate high-profit and high-loss outlier orders to understand why they performed differently.
- Analyze high-value Sales orders to understand which categories or regions generate the most Sales.
- Check Category and Sub-Category performance before making business decisions.
