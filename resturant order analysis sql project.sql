--- view menu items table 
select *
from menu_items;

--- numbers of items on the menu 
select count(*)
from menu_items;

--- the least and most expensive items in the table 
select item_name,price
from menu_items
order by price
limit 1 ;

select item_name,price
from menu_items
order by price desc
limit 1 ;

--- number of italian dishes are on the menu
select category,count(category)
from menu_items
group by category
having category= 'italian';

--- the least and most expensive italian dishes on the menu
select *
from menu_items
where category='italian'
order by price
limit 1;

select *
from menu_items
where category='italian'
order by price desc
limit 1;

--- number of dishes in each category
select category,count(category) as num_dishes 
from menu_items
group by category;

--- average dish price in each category
select category,avg(price) as avg_price
from menu_items
group by category;

-------------------------------------------------------------------------------
--- view order details table 
select *
from order_details;

--- date range of the table
select min(order_date),max(order_date)
from order_details;

--- number of order within the date range 
select count(distinct order_id)
from order_details;

--- number of items ordered within the dste range 
select count(order_details_id)
from order_details;

--- orders with the most numbers of items 
select order_id,count(item_id) as num_items
from order_details
group by order_id
order by num_items desc;

--- orders with more than tweleve items 
select count(*)
from
(select order_id,count(item_id) as num_items
from order_details
group by order_id
having num_items >12) num_orders;

-------------------------------------------------------------------------------
--- ANALYZE CUSTOMER BEHABIOUR ---
--------------------------------------------------------------------------------
SELECT *
from menu_items;
select * 
from order_details;

----- join tables 
select * 
from order_details od
left join menu_items mi
 on od.item_id=mi.menu_item_id;
 
 --- the least  and most  ordered items and in what category
 select item_name,category,count(item_id) as num_purchases
from order_details od
left join menu_items mi
 on od.item_id=mi.menu_item_id
group by item_name,category
order by num_purchases desc
;

select item_name,category,count(item_id) as num_purchases
from order_details od
left join menu_items mi
 on od.item_id=mi.menu_item_id
group by item_name,category
order by num_purchases
;

--- top 5 orders that spent the most money
select order_id,sum(price) as total_spend
from order_details od
left join menu_items mi
 on od.item_id=mi.menu_item_id
group by order_id
order by total_spend desc
limit 5;

--- view details of highest spend order ,what are the insight gathered 
select * 
from order_details od
left join menu_items mi
 on od.item_id=mi.menu_item_id
where order_id =440
order by price desc;
--- the highest spend order had most of it's spending on italian dishes and less spending on mexican,american and asian dishes in that order ;

--- view details of the top 5 highest spend order ,what are the insight gathered
select order_id,category,count(category) as num_category,sum(price) as total_spend
from order_details od
left join menu_items mi
 on od.item_id=mi.menu_item_id
where order_id in (440,2075,1957,330,2675)
group by order_id,category;
--- the top five customers seeems to like italian food,so we should keep the expensive italian dishes because customers seems to like them especially our top money spenders 