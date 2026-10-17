-- Q1.What are the total sales, total profit, total orders, and average order value?
select 
format(sum(Sales_Amount_INR),0) as Total_Sales,
format(sum(Profit_INR),0) as Total_Profit,
format(avg(Sales_Amount_INR),0) as Average_Order_Value,
count(distinct Order_ID) as Total_Orders
from sales;

-- Q2. How are sales and profit changing month by month?
select 
date_format(Order_Date,'%m-%Y') as Month,
format(sum(Sales_Amount_INR),0) as Total_Sales,
format(sum(Profit_INR),0) as Total_Profit
from sales
group by date_format(Order_Date,"%m-%Y")
order by Month;

-- Q3. Sales and profit by category
select 
coalesce(p.Category,"Total") as Category,
format (sum(s.Sales_Amount_INR),0) as Total_Sales,
format (sum(s.Profit_INR),0) as Total_Profit
from sales s
join products p
on s.Product_ID = p.Product_ID
group by p.Category with rollup
order by p.Category is null,
sum(s.Sales_Amount_INR) desc;

-- Q4.Which products sell the most?
select
p.Product_Name,
format(sum(s.Sales_Amount_INR),0) as Total_Sales
from sales s 
join products p 
on s.Product_ID = p.Product_ID
group by p.Product_Name 
order by sum(s.Sales_Amount_INR) desc
limit 10;

-- Q5.Which customer segments generate the most sales?
select
c.Customer_Segment,
format(sum(s.Sales_Amount_INR),0) as Total_Sales
from sales s
join customers c 
on s.Customer_ID = c.Customer_ID
group by c.Customer_Segment
order by sum(s.Sales_Amount_INR) desc;

-- Q6. Which states have the highest sales?
select
c.State,
format(sum(s.Sales_Amount_INR),0) as Total_Sales
from sales s
join customers c 
on s.Customer_ID = c.Customer_ID
group by c.State
order by sum(s.Sales_Amount_INR) desc
limit 10;

-- Q7. Which payment methods are used most?
select Payment_Method, 
count(*) as Total_Orders 
from sales
group by Payment_Method
order by Total_Orders desc;


-- Q8. Which sales channels generate the most sales?
select 
Sales_Channel,
format(sum(Sales_Amount_INR),0) as Total_Sales
from sales
group by Sales_Channel
order by sum(Sales_Amount_INR) desc;

-- Q9. How many orders are cancelled or returned?
select
coalesce(Order_Status,"TOTAL") as OrderStatus,
count(*) as Total_Orders
from sales
where Order_Status in ("Cancelled","Returned")
group by Order_Status with rollup;
