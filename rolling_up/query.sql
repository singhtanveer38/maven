--create table coffee
--(
--	order_id int,
--	date date,
--	store varchar(32),
--	product varchar(32),
--	quantity int,
--	sales float	
--);

--\copy coffee from coffee_shop_sales.csv header delimiter ',';

with cte as
	(select extract(month from date) as month, store, sum(sales) as sales
	from coffee
	group by month, store)
select month, store, sales, sales - lag(sales) over (partition by store order by month) as sales_vs_last_month 
from cte
order by month, store;
