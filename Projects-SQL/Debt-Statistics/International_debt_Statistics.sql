create database International_Debt;
use international_Debt;

#  Let's first SELECT all of the columns from the international_debt
select * from international_debt;

# Finding the number of distinct countries
select count(distinct(country_name)) as Number_of_Country from international_debt;

# Finding out the distinct debt indicators
SELECT DISTINCT indicator_code AS distinct_debt_indicators,indicator_name FROM international_debt
ORDER BY distinct_debt_indicators;

# Totaling the amount of debt owed by the countries
select country_name, sum(debt) as Amount_of_Debt  from international_debt group by country_name;

# Top 5 Country with the highest debt
select country_name, sum(debt) as Amount_of_Debt  from international_debt group by country_name order by Amount_of_Debt desc limit 5;

# Average amount of debt across indicators
SELECT indicator_code AS debt_indicator,indicator_name,ROUND(AVG(debt), 2) AS average_debt
FROM international_debt GROUP BY indicator_name, debt_indicator ORDER BY average_debt;

# The most common debt indicator
select indicator_code,count(indicator_code) as Indicator_Count from international_debt group by indicator_code order  by Indicator_Count desc ;

