create database India_Census;
use India_census;
# To View Table
select * from dataset1;
select * from dataset2;

# To check number of rows in dataset
select count(*) as No_of_Rows from dataset1;
select count(*) as No_of_Rows from dataset2;
 
# To Seperate Dataset for jharkhan and bihar
select * from dataset1 where state in ("Jharkhand","Bihar");

# Population of India
update dataset2 set population=replace(population,",","")where population>1; 
select sum(Population) as India_Population from dataset2;

# State Wise Average sex Ratio  
select state,round(avg(Sex_Ratio),2) as Average_Sex_Ratio from dataset1 group by State;

# State Wise Average Literacy Rate
select State,round(avg(Literacy),2) as Average_Literacy_Rate from dataset1 group by state order by Average_Literacy_Rate desc;

# Top 3 State Showing Highest Average Growth 
select state,round(avg(Growth),2) as Average_Growth from dataset1 group by state order by Average_Growth desc limit 3; 

# state Starting with letter a
select distinct(state) from dataset1 where state like "a%";

# top 3 districts from each state with highest literacy rate
select a.* from
(select district,state,literacy,rank() over(partition by state order by literacy desc) rnk from dataset1) a
where a.rnk in (1,2,3) order by state;

