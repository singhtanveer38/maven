--create table
create table sales
(
	order_number int,
	order_date date,
	fulfillment varchar(32),
	quantity int,
	product_name varchar(256),
	product_price float
);

--copy data from csv to table
\copy sales from orders.csv header delimiter ',';

--What is the sum of total online sales? (round to nearest integer)
select fulfillment, round(sum(quantity * product_price)) as total_sale
from sales
group by fulfillment
having fulfillment = 'Online';
