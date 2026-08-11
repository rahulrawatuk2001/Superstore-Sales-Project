# Database Setup
create database sales;
use sales;

# Data Understanding 
select count(*) from superstore_sales;
select count(distinct Row_id) from superstore_sales;
select * from superstore_sales 
where Order_id is null or Order_id = ""
or Order_date is null or Order_date = ""
or Sales is null or Sales = ""
or Profit is null or Profit = ""
or Region is null or Region = ""
or Segment is null or Segment =""
or Category is null or Category = "";

# Check for duplicate records 

select Order_id,Order_date,Ship_date,Ship_mode,Customer_id,Customer_name,
Segment,Country,City,State,Postal_code,Region,Product_id,
Category,Sub_category,Product_name,Sales,Quantity,Discount,Profit,
count(*) as duplicate_count from superstore_sales
group by Order_id,Order_date,Ship_date,Ship_mode,Customer_id,Customer_name,
Segment,Country,City,State,Postal_code,Region,Product_id,
Category,Sub_category,Product_name,Sales,Quantity,Discount,Profit
having count(*)>1;

# Data Cleaning superstore_sales 
# step 1 : Handling missing values
# sales,profit,Order_date,city check 

select count(*) from superstore_sales where Sales ="";
select count(*) from superstore_sales where Profit ="" or Profit = "unknown" 
or Profit = "N/A";
select count(*) from superstore_sales where Order_date = "N/A";
select count(*) from superstore_sales where City ="";
select count(*) from superstore_sales where Region is null or Region = "";
select count(*) from superstore_sales where Segment is null or Segment = "";
select count(*) from superstore_sales where Category is null or Category = "";


# sales,profit,Order_date,city update
set sql_safe_updates = 0;
update superstore_sales
set Sales = null where Sales="";
update superstore_sales
set Profit = null where Profit ="" or Profit = "unknown" 
or Profit = "N/A";
update superstore_sales
set Order_date = null where Order_date ="N/A";
update superstore_sales
set City = null where City="";
set sql_safe_updates = 1;

# sales,profit,Order_date,city verify 

select count(*) from superstore_sales
where Sales is null;
select count(*) from superstore_sales
where Profit is null;
select count(*) from superstore_sales
where Order_date is null;
select count(*) from superstore_sales
where City is null;

# Step 2 : Remove unwanted symbols
# Sales : â‚¹ symbol removal

select count(*) from superstore_sales
where Sales like "â‚¹%";
set sql_safe_updates = 0;

update superstore_sales
set Sales = replace(Sales,"â‚¹","")
where Sales like "â‚¹%";

set sql_safe_updates = 1;
# Verify
select count(*) from superstore_sales
where Sales like "â‚¹%";
  
#Step3:Convert data type 

alter table superstore_sales
modify Sales decimal(10,2);
alter table superstore_sales
modify Profit decimal(10,2);
alter table superstore_sales
modify Quantity int;
alter table superstore_sales
modify Discount decimal(3,2);

# Step 4 :Text Standarize
# Standardize Text (Sub_category spelling fix)

set sql_safe_updates = 0;

update superstore_sales set Sub_category = 'Accessories' where 
Sub_category = 'Accessoriess';
update superstore_sales set Sub_category = 'Appliances' where 
Sub_category = 'Appliancess';
update superstore_sales set Sub_category = 'Bookcases' where 
Sub_category = 'Bookcasess';
update superstore_sales set Sub_category = 'Furnishings' where 
Sub_category = 'Furnishingss';
update superstore_sales set Sub_category = 'Machines' where 
Sub_category = 'Machiness';
update superstore_sales set Sub_category = 'Storage' where 
Sub_category = 'Storagee';

set sql_safe_updates = 1;

# City : City and State format fix

select count(*) from superstore_sales
where City like "%,%";

set sql_safe_updates = 0;

update superstore_sales
set City = substring_index(City,",",1)
where City like "%,%";

set sql_safe_updates = 1;

# Verify

select count(*) from superstore_sales
where City like "%,%";

# Step 5: Remove duplicate 

select * from(select Row_id ,row_number() over(partition by Order_id, 
Order_date,Ship_date,Ship_mode,Customer_id,Customer_name,
Segment,Country,City,State,Postal_code,Region,Product_id,
Category,Sub_category,Product_name,Sales,Quantity,Discount,Profit
order by Row_id) as rn from superstore_sales) as t where rn>1;

set sql_safe_updates= 0;

delete t1 from superstore_sales as t1 join(select Row_id ,row_number() 
over(partition by Order_id, 
Order_date,Ship_date,Ship_mode,Customer_id,Customer_name,
Segment,Country,City,State,Postal_code,Region,Product_id,
Category,Sub_category,Product_name,Sales,Quantity,Discount,Profit
order by Row_id) as rn from superstore_sales) as t2 
on t1.Row_id = t2.Row_id where t2.rn>1;

set sql_safe_updates= 1;
select count(*) from superstore_sales;

# Verify Duplicates

select count(*) from(
select Row_id,
row_number() over(
partition by Order_id, Order_date, Ship_date, Ship_mode,
Customer_id, Customer_name, Segment, Country, City, State,
Postal_code, Region, Product_id, Category, Sub_category,
Product_name, Sales, Quantity, Discount, Profit
order by Row_id
) as rn
from superstore_sales
) as t
where rn > 1;

# Step 6: Business Validation

# Negative Sales: Delete (genuinely invalid rows, whole row removed)

set sql_safe_updates = 0;
delete from superstore_sales where Sales < 0 ;

# Invalid Discount: column-null only (row preserved, not deleted)

update superstore_sales set Discount = null where Discount< 0 or Discount >1;

# Negative Quantity: sign error, fix with ABS

update superstore_sales set Quantity = abs(Quantity) where Quantity < 0;
set sql_safe_updates = 1;

# Verify 

select count(*) from superstore_sales where Sales < 0;
select count(*) from superstore_sales where Discount < 0 or Discount > 1;
select count(*) from superstore_sales where Quantity < 0;
select count(*) from superstore_sales;
   
# Business sql queries
# Top Kpi Cards

# Total Sales
select sum(Sales) as Total_Sales from superstore_sales;

# Total Profit
select sum(Profit) as Total_Profit from superstore_sales;

# Total Profit Margin %
select (sum(Profit)/sum(Sales))*100 as Profit_Margin_Percent from superstore_sales;

# Total Distinct Order count 
select count(distinct Order_id) as Total_Orders from superstore_sales;

# Average Order Value

select sum(Sales) as Total_Sales,
count(distinct Order_ID) as Total_Orders,
sum(Sales) / count(distinct Order_ID) as AOV
from superstore_sales where Sales is not null ;

# Year Over Year Growth % 

select  Year_num, Yearly_sales,
       lag(Yearly_sales) over (order by Year_num) as Prev_year_sales,
       ((Yearly_sales - lag(Yearly_sales) over (order by Year_num)) 
         / lag(Yearly_sales) over (order by Year_num)) * 100 AS YoY_Growth
from (
  select right(Order_date, 4) as Year_num, sum(Sales) as Yearly_sales
  from superstore_sales
  where Order_date IS NOT NULL
  group by Year_num
) as t;

# Monthly sales and profit trends 

select
  case Month_num
    when '01' then 'Jan' when '02' then 'Feb' when '03' then 'Mar'
    when '04' then 'Apr' when '05' then 'May' when '06' then 'Jun'
    when '07' then 'Jul' when '08' then 'Aug' when '09' then 'Sep'
    when '10' then 'Oct' when '11' then 'Nov' when '12' then 'Dec'
  end as Month_name,
  Monthly_sales, Monthly_Profit
from (
  select SUBSTRING(Order_date, 4, 2) as Month_num,
         sum(Sales) as Monthly_sales,
         sum(Profit) as Monthly_Profit
  from superstore_sales
  where Order_date is not null
  group by Month_num
) as t
order by Month_num;
 
# Total Sales & Profit Margin % by Category

select Category , sum(Sales) as Total_sales
,(sum(Profit)/sum(Sales))*100 as Profit_Margin_Percent
from superstore_sales group by Category order by Total_sales desc;

# Sales by Segment 

select Segment, sum(Sales) as Total_sales
from superstore_sales group by Segment;

# Category + Sub-category financial overview 

select Category, Sub_category, sum(Profit) as Total_profit, 
sum(Sales) as Total_sales,(sum(Profit)/sum(Sales))*100 AS Profit_Margin_Percent
from superstore_sales
group by Category, Sub_category
order by Category, Total_Sales desc;
