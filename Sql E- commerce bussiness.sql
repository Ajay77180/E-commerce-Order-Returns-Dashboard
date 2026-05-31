-- project 2

create database e_commerce;
use e_commerce;
select * from ecommercedata;

-- city wise rev & return rate %
select city ,
count(*) as total_order,
sum(revenue) as total_rev,
sum(case when order_status ="returned" then 1 else 0 end ) as return_order,
round(sum(case when order_status = "returned" then 1 else 0 end )*100.0/count(*),1) as return_rate
from ecommercedata
group by city
order by total_rev desc;


-- category performance
select category,
count(order_id) as total_order,
sum(revenue) as total_rev,
round(avg(discount_pct),1) as avg_discount
from ecommercedata
group by category;

-- Monthly Revenue vs Target + Achievement

select 
month, month_no,
round(sum(net_revenue),2) as net_rev,
sum(target_revenue) as net_target,
round(sum(net_revenue)/sum(target_revenue)*100,2) as achievment
from ecommercedata
group by month , month_no
order by month_no ;

-- Channel-wise performance (Subquery)
select channel ,
count(order_id) as orders ,
sum(revenue) as total_rev,
rank() over (order by sum(revenue)  desc ) as channel_rank
from ecommercedata
group by channel 
order by total_rev desc;

-- Return Reason Analysis
with rr as(
SELECT Return_Reason,
       COUNT(*) AS Counting
FROM ecommercedata
WHERE Return_Reason != ''
GROUP BY Return_Reason)
select *,
       ROUND(COUNting/sum(counting) over() *100,1) AS Pct
       from rr
       group by Return_Reason
ORDER BY Counting DESC;


