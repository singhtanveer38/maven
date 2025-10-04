--You have been given two tables:
--	A table with promotional periods, each with a start and end date
--	A table with orders, each with an order date and quantity
--Your task is to join each transaction to the promotion active on its order date.

--create tables
create table orders
(
	order_id int,
	order_date date,
	order_quantity int
);

create table promotions
(
	promo_id varchar(8),
	promo_name varchar(32),
	start_date date,
	end_date date
);

--copy data into tables from csv files
\copy orders from orders.csv header delimiter ',';
\copy promotions from promotions.csv header delimiter ',';

--How many orders were placed outside of promotional periods?

select count(o.order_id)
from orders o
left join promotions p
on (o.order_date >= p.start_date and o.order_date <= p.end_date)
where p.promo_id is null;
