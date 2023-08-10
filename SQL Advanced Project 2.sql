create database miniproject2;
use miniproject2;


 
 -- 1.	Dropping column 'Player Profile' from the table.
rename table  miniproject2.`icc test batting figures` to icc;
alter table icc 
drop column `Player Profile`;
select * from icc;

-- 3 Extracting the country name and player names from the given data and storing it in seperate columns for further usage.

-- Just creating a new table 
create table icc2 as (select * , substring_index( player , '(' ,1) as player_name,
substring_index(substring_index(player , '(' , -1), ')' , 1) as country_name from icc);
select * from icc2;

-- deleting old table and renaming new to old table 
drop table icc;
rename table icc2 to icc;

-- New Table
select * from icc;

 
 
 -- 4 From the column 'Span' extracting the start_year and end_year and store them in seperate columns for further usage.
  
 -- creating new table with required details
 create table icc2 as (select * , substring_index(span , '-',1) as Start_Year, 
 substring_index(span , '-' ,-1) as Final_year from icc);
 -- Deleting Old Table and renaming new table
drop table icc;
rename table icc2 to icc;
-- table with values
select * from icc;



-- 5 The column 'HS' has the highest score scored by the player so far in any given match. 
-- The column also has details if the player had completed the match in a NOT OUT status. 
-- Extracting the data and storing the highest runs and the NOT OUT status in different columns.

-- creating new table with required details
create table icc2 as (select * , substring_index(HS, '*', 1)as High_score , 
if(substring_index(hs, '*' , -1) <> '','N' , 'Y') as Not_out_status from icc);

-- deleting old table and renaming new table
drop table icc;
rename table icc2 to icc;

-- new table 
select * from icc;


-- Q6 Using the data given, considering the players who were active in the year of 2019, 
-- creating a set of batting order of best 6 players using the selection criteria of those 
-- who have a good average score across all matches for India.

with a as (select * , dense_rank() over (order by avg desc) as Player_rank from icc 
where country_name = 'INDIA' and (Start_Year = 2019 or Final_year=2019) )
select * 
FROM a 
where player_rank <= 6;


-- 7.	Using the data given, considering the players who were active in the year of 2019,
-- I create a set of batting order of best 6 players using the selection criteria of those who have
--  highest number of 100s across all matches for India.
select * from icc;

with a as (select * , dense_rank() over (order by `100` desc) as Player_rank from icc 
where country_name = 'INDIA' and (Start_Year = 2019 or Final_year=2019) )
select * 
FROM a 
where player_rank <= 6;


-- 8 Using the data given, considering the players who were active in the year of 2019, 
-- I create a set of batting order of best 6 players using 2 selection criterias of your own for India.

-- Selection Criteria = RUNS
with a as (select * , dense_rank() over (order by Runs desc) as Player_rank from icc 
where country_name = 'INDIA' and (Start_Year = 2019 or Final_year=2019) )
select * 
FROM a 
where player_rank <= 6;

-- Selection Criteria = HIGH SCORE
with a as (select * , dense_rank() over (order by High_score desc) as Player_rank from icc 
where country_name = 'INDIA' and (Start_Year = 2019 or Final_year=2019) )
select * 
FROM a 
where player_rank <= 6;

-- Q9 Creating a View named ‘Batting_Order_GoodAvgScorers_SA’ using the data given,
-- considering the players who were active in the year of 2019, 
-- create a set of batting order of best 6 players using the selection criteria of 
-- those who have a good average score across all matches for South Africa.

create view batting_order_goodavgscores_sa as
	with a as (select * , dense_rank() over (order by Avg desc) as Player_rank from icc 
where country_name like '%SA%'  and (Start_Year = 2019 or Final_year=2019) )
select * 
FROM a 
where player_rank <= 6;
-- Final View 
select * from batting_order_goodavgscores_sa;

-- 10 Creating a View named ‘Batting_Order_HighestCenturyScorers_SA’ Using the data given, 
-- considering the players who were active in the year of 2019, 
-- I create a set of batting order of best 6 players using the selection criteria 
-- of those who have highest number of 100s across all matches for South Africa.

create view batting_order_HighestCenturyScorers_SA as
	with a as (select * , dense_rank() over (order by `100` desc) as Player_rank from icc 
where country_name like '%SA%'  and (Start_Year = 2019 or Final_year=2019) )
select * 
FROM a 
where player_rank <= 6;

select * from batting_order_HighestCenturyScorers_SA;




