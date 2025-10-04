--You've been given a table of Netflix users and another with their viewing activity, including the movie name, date started, and whether they finished it.

--Your task is to engineer these new features for each user, based on their activity:

--create tables
create table activity
(
	id int,
	user_id int,
	date date,
	movie_name varchar(128),
	finished int
);

create table users
(
	id int,
	created_at date,
	country_code varchar(2)
);

--copy data from csv to tables
\copy activity from activity.csv header delimiter ',';
\copy users from users.csv header delimiter ',';


--    Date from the first movie they finished
select user_id, min(date)
from activity
where finished = 1
group by user_id
order by user_id;


--    Name of the first movie they finished
with cte as(
	select user_id, min(date) as first_date
	from activity
	where finished = 1
	group by user_id
	order by user_id)
select c.user_id, c.first_date, a.movie_name
from cte c
left join activity a
on c.user_id = a.user_id and c.first_date = a.date
order by c.user_id;


--    Date from the last movie they finished
select user_id, max(date)
from activity
where finished = 1
group by user_id
order by user_id;


--    Name of the last movie they finished
with cte as(
	select user_id, max(date) as last_date
	from activity
	where finished = 1
	group by user_id
	order by user_id)
select c.user_id, c.last_date, a.movie_name
from cte c
left join activity a
on c.user_id = a.user_id and c.last_date = a.date
order by c.user_id;


--    Movies started
select * from activity
where finished = 0;


--    Movies finished
select * from activity
where finished = 1;


--How many users have "Fight Club" as the last film they've seen?
with cte as(
	select user_id, max(date) as last_date
	from activity
	where finished = 1
	group by user_id
	order by user_id)
select count(*)
from cte c
left join activity a
on c.user_id = a.user_id and c.last_date = a.date
where movie_name = 'Fight Club';
