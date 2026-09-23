select * from ecommerce
select month,sum(sales)as total_sales from ecommerce group by month order by month;
SELECT TIME_OF_DAY,SUM(SALES)AS TOTAL_SALES FROM ECOMMERCE GROUP BY TIME_OF_DAY ORDER BY TOTAL_SALES DESC;
SELECT HOUR,SUM(SALES)AS TOTAL_SALES FROM ECOMMERCE GROUP BY HOUR ORDER BY TOTAL_SALES DESC;
SELECT TO_CHAR(ORDER_DATE,'FMDay')AS DAYNAME,SUM(SALES) AS TOTAL_SALES FROM ECOMMERCE
GROUP BY TO_CHAR(ORDER_DATE,'FMDay');
SELECT PRODUCT_CATEGORY,SUM(QUANTITY_ORDERED) AS TOTAL_QUANTITY FROM ECOMMERCE
GROUP BY PRODUCT_CATEGORY ORDER BY TOTAL_QUANTITY DESC;
SELECT PRODUCT_CATEGORY,COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS FROM ECOMMERCE
GROUP BY PRODUCT_CATEGORY ORDER BY TOTAL_ORDERS DESC;
SELECT PRODUCT,SUM(QUANTITY_ORDERED) AS TOTAL_ORDERS FROM ECOMMERCE 
GROUP BY PRODUCT ORDER BY TOTAL_ORDERS DESC LIMIT 10;
select 
 case when sales >=1000 then 'high_sales' 
      when sales >=500 then 'medium_sales' 
		   else 'low_sales' 
   end AS sales_level,
   count(*) as TOTAL_RECORDS
  from ecommerce
group by
 case when sales >=1000 then 'high_sales' 
      when sales >=500 then 'medium_sales' 
		   else 'low_sales' 		
		   end
		   
		   
WITH PRODUCT_SALES AS (
   SELECT PRODUCT,SUM(SALES) AS TOTAL_SALES FROM ECOMMERCE
   GROUP BY PRODUCT)
   SELECT * FROM PRODUCT_SALES WHERE TOTAL_SALES >
   (SELECT AVG(TOTAL_SALES) AS AVG_SALES FROM PRODUCT_SALES);

SELECT PRODUCT,PRODUCT_CATEGORY,SUM(SALES) AS TOTAL_SALES FROM ECOMMERCE 
GROUP BY PRODUCT,PRODUCT_CATEGORY ORDER BY TOTAL_SALES DESC LIMIT 3;

WITH PRODUCT_SALES AS (
SELECT PRODUCT_CATEGORY,PRODUCT,SUM(SALES) AS TOTAL_SALES, 
ROW_NUMBER() OVER(PARTITION BY PRODUCT_CATEGORY ORDER BY SUM(SALES)DESC) AS RANK FROM ECOMMERCE 
GROUP BY PRODUCT_CATEGORY,PRODUCT) 
SELECT * FROM PRODUCT_SALES
WHERE RANK <=3

WITH PRODUCT_SALES AS (
SELECT PURCHASE_ADDRESS,CITY, SUM(SALES) AS TOTAL_SPENDING,
ROW_NUMBER() OVER (PARTITION BY CITY ORDER BY SUM(SALES) DESC) AS RANK
FROM ECOMMERCE
GROUP BY PURCHASE_ADDRESS, CITY)
SELECT * FROM PRODUCT_SALES
WHERE RANK <=3

with monthly_sales as (
select to_char (order_date,'fmmonth')as sales_month,sum(sales) as monthly_sales from ecommerce 
group by to_char (order_date,'fmmonth')),

saleswithprev as (
select sales_month,monthly_sales,lag (monthly_sales)
over(order by sales_month) as prev_month_sales
from monthly_sales)

select monthly_sales,sales_month,prev_month_sales,
round(
(monthly_sales - prev_month_sales)* 100
/nullif (prev_month_sales,0),2)as mom 
from saleswithprev order by sales_month;

WITH PRODUCT_SALES AS (
SELECT PRODUCT,SUM(SALES) AS TOTAL_SALES 
 FROM ECOMMERCE 
GROUP BY PRODUCT)

select product,total_sales,round(
 total_sales * 100.0 / NULLIF(SUM(total_sales) OVER (), 0),
    2) as pct_contributiom
from product_sales order by total_sales desc;

with product_sold as (
select product_category,product,sum (sales) as total_sales,
rank() over (partition by product_category order by sum(sales) desc) as rank from ecommerce 
group by product_category,product
)
select * from product_sold 
where rank =1;
select * from product
  select p.subcategory,sum(quantity) from product p inner join orders o on
  p.productid = o.productid group by p.subcategory order by sum(quantity) desc

select * from product;
select * from ecommerce;

select product_category,sum(sales) as total_sales,
rank() over(order by sum(sales) desc) as rk,
round(
sum(sales) * 100 / nullif(sum(sum(sales)) over (),0),2) as per_cont from ecommerce 
group by product_category order by total_sales desc;

with monthly_sales as (
select extract(month from order_date)as month,
       extract(year from order_date) as year,
sum(sales) as monthly_sales
from ecommerce group  by extract (month from order_date),extract (year from order_date))

select month,year,monthly_sales,sum(monthly_sales) over (order by month) as running_totals
from monthly_sales order by month,year;

with product_sales as (
select product,product_category,sum(sales) as total_sales,
rank() over(partition by product_category order by sum(sales)desc) as rank
from ecommerce group by product,product_category)

select product_category,total_sales,round( 
total_sales * 100.0 / NULLIF(SUM(total_sales) OVER (partition by product_category), 0),
    2) as pct_contribution from product_sales
 where rank<=3 order by pct_contribution desc;

with cte as (
 select city,sum(sales) as total_sales,
 row_number() over ( order by sum(sales)desc) as rn
 from ecommerce group by city)
 select city,total_sales,
 round( total_sales * 100.0/ nullif(sum(total_sales) over (),0),2) as pt_contribution
 from cte
 where rn <=3 order by total_sales desc

select * from ecommerce
select hour,time_of_day, sum(sales) as total_sales from ecommerce group by hour,time_of_day order by hour desc;
select city,product_category,sum(sales) as total_sales from ecommerce
group by city,product_category order by total_sales desc limit 2
 
 
	
	


		   

  

		


