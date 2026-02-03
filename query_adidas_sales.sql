select * from SalesData

select COLUMN_NAME,DATA_TYPE from INFORMATION_SCHEMA.COLUMNS

select
min(invoice_date) as min_date,
max(invoice_date) as max_date
from SalesData

select 'Total Sales' as Metrics,sum(Sales) as Metric_Value from SalesData
union all
select 'Total Profit', ROUND(sum(Profit),0) from SalesData
union all
select 'Total Unit Sold', sum(units_sold) from SalesData

alter table SalesData
add Sales int, profit int

update SalesData
set Sales = [price_per_unit]*[units_sold]

update SalesData
set profit = Sales*operating_margin
-------------------------------------------
--Retailer
--**********
--Total Sales snd Contribution By Retailer
select *,
sum(total_sales) over() as Overall_Sales,
CONCAT(ROUND(CAST(total_sales as float)/sum(total_sales) over()*100,2),'%') as Contribution
from
(
select
retailer,
sum(sales) as total_sales
from salesdata
group by Retailer) a
order by total_sales Desc
-------------------------
--Total Profit by Retailer

select *,
sum(total_profit) over() as Overall_Profit,
CONCAT(ROUND(CAST(total_profit as float)/sum(total_profit) over()*100,2),'%') as Contribution
from
(
select
retailer,
sum(profit) as total_profit
from salesdata
group by Retailer) a
order by total_profit Desc
--------------------------
--Total Units Sold by Retailer
select *,
sum(total_units) over() as Overall_Units,
CONCAT(ROUND(CAST(total_units as float)/sum(total_units) over()*100,2),'%') as Contribution
from
(
select
retailer,
sum(units_sold) as total_units
from salesdata
group by Retailer) a
order by total_units Desc
----------------------------
--Total Sales By Region

select *,
sum(total_sales) over() as Overall_Sales,
CONCAT(ROUND(CAST(total_sales as float)/sum(total_sales) over()*100,2),'%') as Contribution
from
(
select
Region,
sum(sales) as total_sales
from salesdata
group by Region) a
order by total_sales Desc
-------------------------
--Total Profit by Region

select *,
sum(total_profit) over() as Overall_Profit,
CONCAT(ROUND(CAST(total_profit as float)/sum(total_profit) over()*100,2),'%') as Contribution
from
(
select
Region,
sum(profit) as total_profit
from salesdata
group by Region) a
order by total_profit Desc
-----------------------------
--Total Units Sold by Region

select *,
sum(total_units) over() as Overall_Units,
CONCAT(ROUND(CAST(total_units as float)/sum(total_units) over()*100,2),'%') as Contribution
from
(
select
Region,
sum(units_sold) as total_units
from salesdata
group by Region) a
order by total_units Desc
--------------------------
--Total Sales by Product

select *,
sum(total_sales) over() as Overall_Sales,
CONCAT(ROUND(CAST(total_sales as float)/sum(total_sales) over()*100,2),'%') as Contribution
from
(
select
product,
sum(sales) as total_sales
from salesdata
group by product) a
order by total_sales Desc
-------------------------
--Total Profit by Product

select *,
sum(total_profit) over() as Overall_Profit,
CONCAT(ROUND(CAST(total_profit as float)/sum(total_profit) over()*100,2),'%') as Contribution
from
(
select
product,
sum(profit) as total_profit
from salesdata
group by product) a
order by total_profit Desc
----------------------------
--Total units sold by Product

select *,
sum(total_units) over() as Overall_Units,
CONCAT(ROUND(CAST(total_units as float)/sum(total_units) over()*100,2),'%') as Contribution
from
(
select
product,
sum(units_sold) as total_units
from salesdata
group by product) a
order by total_units Desc
----------------------------
--Total Sales by Sales Method
select *,
sum(total_sales) over() as Overall_Sales,
CONCAT(ROUND(CAST(total_sales as float)/sum(total_sales) over()*100,2),'%') as Contribution
from
(
select
sales_method,
sum(sales) as total_sales
from salesdata
group by sales_method) a
order by total_sales Desc
-------------------------
--Total Profit by Sales Method
select *,
sum(total_profit) over() as Overall_Profit,
CONCAT(ROUND(CAST(total_profit as float)/sum(total_profit) over()*100,2),'%') as Contribution
from
(
select
sales_method,
sum(profit) as total_profit
from salesdata
group by sales_method) a
order by total_profit Desc
----------------------------
--Total Units sold by Sales Method

select *,
sum(total_units) over() as Overall_Units,
CONCAT(ROUND(CAST(total_units as float)/sum(total_units) over()*100,2),'%') as Contribution
from
(
select
sales_method,
sum(units_sold) as total_units
from salesdata
group by sales_method) a
order by total_units Desc
--------------------------
--Total Profit by City

select *,
SUM(total_profit) over() as overall_profit,
CONCAT(ROUND(CAST(total_profit as float)/sum(total_profit) over()*100,2),'%') as Contribution
from
(
	select
	region,
	city,
	sum(profit) as total_profit
	from SalesData
	group by
		Region,
		City ) a
order by
	Region,
	total_profit Desc

-------------------
--Total Sales by City
select *,
SUM(total_sales) over() as overall_sales,
CONCAT(ROUND(CAST(total_sales as float)/sum(total_sales) over()*100,2),'%') as Contribution
from
(
	select
	region,
	city,
	sum(sales) as total_sales
	from SalesData
	group by
		Region,
		City ) a
order by
	Region,
	total_sales Desc
-------------------
--Total Units Sold by City

select *,
SUM(total_units) over() as overall_units,
CONCAT(ROUND(CAST(total_units as float)/sum(total_units) over()*100,2),'%') as Contribution
from
(
	select
	region,
	city,
	sum(units_sold) as total_units
	from SalesData
	group by
		Region,
		City ) a
order by
	Region,
	total_units Desc
----------------------
select * from SalesData
-----------------------
--Unit Sold by Region and Product
select *,
sum(total_count) over(partition by region) as region_sales_count,
CONCAT(ROUND(CAST(total_count as float)/sum(total_count) over(partition by region)*100,2),'%') as Contribution
from
(
select
region,
product,
SUM(units_sold) as total_count
from SalesData
group by
	region,
	product) a
order by
	region,
	total_count DESC
----------------------
--Sales by Region and Product

select *,
sum(total_sales) over(partition by region) as region_sales,
CONCAT(ROUND(CAST(total_sales as float)/sum(total_sales) over(partition by region)*100,2),'%') as Contribution
from
(
select
region,
product,
SUM(sales) as total_sales
from SalesData
group by
	region,
	product) a
order by
	region,
	total_sales DESC
--------------------
--Total Profit by Region and Product
select *,
sum(total_profit) over(partition by region) as region_profit,
CONCAT(ROUND(CAST(total_profit as float)/sum(total_profit) over(partition by region)*100,2),'%') as Contribution
from
(
select
region,
product,
SUM(profit) as total_profit
from SalesData
group by
	region,
	product) a
order by
	region,
	total_profit DESC
---------------------------
--Sales by Region and Sales Method
select *,
sum(total_sales) over(partition by region) as region_sales,
CONCAT(ROUND(CAST(total_sales as float)/sum(total_sales) over(partition by region)*100,2),'%') as Contribution
from
(
select
region,
sales_method,
SUM(sales) as total_sales
from SalesData
group by
	region,
	sales_method) a
order by
	region,
	total_sales DESC
----------------------
--Total Profit by Region and Sales Method

select *,
sum(total_profit) over(partition by region) as region_profit,
CONCAT(ROUND(CAST(total_profit as float)/sum(total_profit) over(partition by region)*100,2),'%') as Contribution
from
(
select
region,
sales_method,
SUM(profit) as total_profit
from SalesData
group by
	region,
	sales_method) a
order by
	region,
	total_profit DESC
------------------------
--Order Volume by Region and Sales Method
select *,
sum(total_count) over(partition by region) as region_sales_count,
CONCAT(ROUND(CAST(total_count as float)/sum(total_count) over(partition by region)*100,2),'%') as Contribution
from
(
select
region,
sales_method,
SUM(units_sold) as total_count
from SalesData
group by
	region,
	sales_method) a
order by
	region,
	total_count DESC

----------------------
--Year wise Sales 

select
YEAR(invoice_date) as Year,
sum(Sales) as Total_Sales
from SalesData
group by YEAR(invoice_date)
order by Year

---YoY Performance
with yoy_sales as
(
select *,
LAG(Total_Sales) over(order by Year) as py_sales,
Total_Sales-LAG(Total_Sales) over(order by Year) as Sales_Diff
from
(
	select
	YEAR(invoice_date) as Year,
	sum(Sales) as Total_Sales
	from SalesData
	group by YEAR(invoice_date)
) a)
select *,
case when py_sales is null then 'No Previous Value'
else
CONCAT(ROUND((Cast(Total_Sales-py_sales as Float)/py_sales)*100,2),'%') end as Yoy_perf
from
yoy_sales
order by year
---------------
--Year wise Order Volume

select
YEAR(invoice_date) as Year,
sum(units_sold) as Total_Units
from SalesData
group by YEAR(invoice_date)
order by Year
---------------
--YOY volume performance
with yoy_orders as
(
select *,
LAG(Total_units) over(order by Year) as py_order,
Total_units-LAG(Total_units) over(order by Year) as Sales_Diff
from
(
	select
	YEAR(invoice_date) as Year,
	sum(units_sold) as Total_units
	from SalesData
	group by YEAR(invoice_date)
) a)
select *,
case when py_order is null then 'No Previous Value'
else
CONCAT(ROUND((Cast(Total_units-py_order as Float)/py_order)*100,2),'%') end as Yoy_perf
from
yoy_orders
order by year
-------------
--YOY Prifit Analysis
with yoy_profit as
(
select *,
LAG(Total_Profit) over(order by Year) as py_profit,
Total_Profit-LAG(Total_Profit) over(order by Year) as Profit_Diff
from
(
	select
	YEAR(invoice_date) as Year,
	sum(Profit) as Total_Profit
	from SalesData
	group by YEAR(invoice_date)
) a)
select *,
case when py_profit is null then 'No Previous Value'
else
CONCAT(ROUND((Cast(Total_Profit-py_profit as Float)/py_profit)*100,2),'%') end as Yoy_perf
from
yoy_profit
order by year
-----------------
--Quarterly Sales
with qoq_sales as
(
select *,
LAG(Total_Sales) over(order by QUARTER) as pq_sales,
Total_Sales-LAG(Total_Sales) over(order by QUARTER) as Sales_Diff
from
(
	select
	CONCAT('Q',DATEPART(QUARTER,invoice_date)) as QUARTER,
	sum(Sales) as Total_Sales
	from SalesData
	group by CONCAT('Q',DATEPART(QUARTER,invoice_date))
) a)
select *,
case when pq_sales is null then 'No Previous Value'
else
CONCAT(ROUND((Cast(Total_Sales-pq_sales as Float)/pq_sales)*100,2),'%') end as Yoy_perf
from
qoq_sales
order by QUARTER
-----------------
--QoQ Order Volume

with qoq_orders as
(
select *,
LAG(Total_units) over(order by QUARTER) as pq_order,
Total_units-LAG(Total_units) over(order by QUARTER) as Sales_Diff
from
(
	select
	CONCAT('Q',DATEPART(QUARTER,invoice_date)) as QUARTER,
	sum(units_sold) as Total_units
	from SalesData
	group by CONCAT('Q',DATEPART(QUARTER,invoice_date))
) a)
select *,
case when pq_order is null then 'No Previous Value'
else
CONCAT(ROUND((Cast(Total_units-pq_order as Float)/pq_order)*100,2),'%') end as qoq_perf
from
qoq_orders
order by QUARTER
-------------------
--Qoq Profit

with qoq_profit as
(
select *,
LAG(Total_Profit) over(order by QUARTER) as pq_profit,
Total_Profit-LAG(Total_Profit) over(order by QUARTER) as Profit_Diff
from
(
	select
	CONCAT('Q',DATEPART(QUARTER,invoice_date)) as QUARTER,
	sum(Profit) as Total_Profit
	from SalesData
	group by CONCAT('Q',DATEPART(QUARTER,invoice_date))
) a)
select *,
case when pq_profit is null then 'No Previous Value'
else
CONCAT(ROUND((Cast(Total_Profit-pq_profit as Float)/pq_profit)*100,2),'%') end as qoq_perf
from
qoq_profit
order by QUARTER
-----------------
--MoM Sales
with mom_sales as
(
select *,
LAG(Total_Sales) over(order by Month) as pm_sales,
Total_Sales-LAG(Total_Sales) over(order by Month) as Sales_Diff
from
(
	select
	Month(invoice_date) as Month,
	LEFT(DATENAME(MONTH,invoice_date),3) as Month_name,
	sum(Sales) as Total_Sales
	from SalesData
	group by 
		Month(invoice_date),
		LEFT(DATENAME(MONTH,invoice_date),3)
) a)
select *,
case when pm_sales is null then 'No Previous Value'
else
CONCAT(ROUND((Cast(Total_Sales-pm_sales as Float)/pm_sales)*100,2),'%') end as mom_perf
from
mom_sales
order by Month
----------------
--MoM Order Volume
with mom_orders as
(
select *,
LAG(Total_units) over(order by Month) as pm_order,
Total_units-LAG(Total_units) over(order by Month) as Sales_Diff
from
(
	select
	Month(invoice_date) as Month,
	LEFT(DATENAME(MONTH,invoice_date),3) as Month_name,
	sum(units_sold) as Total_units
	from SalesData
	group by
		Month(invoice_date),
		LEFT(DATENAME(MONTH,invoice_date),3)
) a)
select *,
case when pm_order is null then 'No Previous Value'
else
CONCAT(ROUND((Cast(Total_units-pm_order as Float)/pm_order)*100,2),'%') end as mom_perf
from
mom_orders
order by Month
----------------
--MoM Profit

with mom_profit as
(
select *,
LAG(Total_Profit) over(order by Month) as pm_profit,
Total_Profit-LAG(Total_Profit) over(order by Month) as Profit_Diff
from
(
	select
	Month(invoice_date) as Month,
	LEFT(DATENAME(MONTH,invoice_date),3) as Month_name,
	sum(Profit) as Total_Profit
	from SalesData
	group by
		Month(invoice_date),
		LEFT(DATENAME(MONTH,invoice_date),3)
) a)
select *,
case when pm_profit is null then 'No Previous Value'
else
CONCAT(ROUND((Cast(Total_Profit-pm_profit as Float)/pm_profit)*100,2),'%') end as qoq_perf
from
mom_profit
order by Month
------------------------------------------

select * from SalesData

select
product,
ROUND(AVG(price_per_unit),2) as avg_price,
ROUND(AVG(operating_margin),2) as avg_margin
from salesdata
group by product
order by product
--------------------

select
YEAR(invoice_date) as Year,
Month(invoice_date) as Month,
LEFT(DATENAME(MONTH,invoice_date),3) as Month_name,
sum(Sales) as Total_Sales
from SalesData
group by
	YEAR(invoice_date),
	Month(invoice_date),
	LEFT(DATENAME(MONTH,invoice_date),3)
order by
	Year,
	Month