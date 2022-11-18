CREATE DATABASE covid;

USE covid;
  
SELECT * FROM CovidDeaths;
  
SELECT * FROM covidvaccinations;

SELECT location,date,population,total_cases,new_cases,total_deaths
FROM CovidDeaths
ORDER BY 1,2;
  
# Looking at total_cases vs total_deaths
-- Shows the likelihood of dying if you are down with covid.
-- SELECT location,sum(total_cases) AS total_cases ,sum(total_deaths) AS total_deaths
-- FROM CovidDeaths
-- WHERE location like '%states%'
-- GROUP BY location;
-- we cannot do this coz we have cummulative numbers in total_cases etc. Hence cannot use sum

#Calculating the percentage of the people who died due to corona
SELECT date,location, total_cases,total_deaths, (total_deaths/total_cases)*100 AS pct_died
FROM CovidDeaths
WHERE location like '%states%';

-- Total cases vs population
-- Shows what % of population gotten covid.
SELECT date,location, total_cases,population, (total_cases/population)*100 AS pct_cases
FROM CovidDeaths
WHERE location like '%states%';

-- Looking at country's infection rate vs population
-- showing the countries with the highest rate of infection
SELECT location,population, MAX(total_cases) AS Highest_infection_rate, (MAX(total_cases/population))*100 AS pct_inf_rate
FROM CovidDeaths
-- WHERE location like '%states%'
GROUP BY location,population
ORDER BY pct_inf_rate DESC;

-- looking at country's total_deaths vs population
SELECT location,MAX(total_deaths) AS Highest_death_infection, (MAX(total_deaths/population))*100 AS pct_death_rate
FROM CovidDeaths
GROUP BY location,population
ORDER BY pct_death_rate DESC;

SELECT location,MAX(total_deaths) AS Highest_death_infection, (MAX(total_deaths/population))*100 AS pct_death_rate,
MAX(total_cases) AS Highest_infection_rate, (MAX(total_cases/population))*100 AS pct_inf_rate
FROM CovidDeaths
GROUP BY location,population
ORDER BY pct_death_rate DESC ,pct_inf_rate DESC;

-- continents
SELECT continent, MAX(total_deaths) AS Highest_death_infection
FROM CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY Highest_death_infection;


SELECT continent, MAX(total_cases) AS Highest_infection_rate
FROM CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY Highest_infection_rate;

-- global numbers by dates
SELECT date,SUM(new_cases) as total_cases, SUM(new_deaths) AS total_deaths, (SUM(new_deaths)/SUM(new_cases))*100 AS death_PCT
FROM CovidDeaths
GROUP BY date
ORDER BY death_PCT desc;

-- global numbers
SELECT SUM(new_cases) as total_cases, SUM(new_deaths) AS total_deaths, (SUM(new_deaths)/SUM(new_cases))*100 AS death_PCT
FROM CovidDeaths;


-- COVID VACCINATION

SELECT * FROM covidvaccinations;

-- joining both the tables
SELECT * 
FROM CovidDeaths dea
JOIN covidvaccinations vac
ON dea.date = vac.date and dea.location = vac.location;

-- looking at total population vs vaccination
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM CovidDeaths as dea
JOIN covidvaccinations vac
ON dea.date = vac.date and dea.location = vac.location;

-- using partition
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vac
FROM CovidDeaths as dea
JOIN covidvaccinations vac
ON dea.date = vac.date and dea.location = vac.location;

-- using roll_people_vac and then dividing it to pop to know how many people are vaccinated
-- 1ST using CTE(common table expression) , cannot use the newly created col in our cal for next col
-- not in mysql (with command)
With popvsvac ( continent,location,date,population,rolling_people_vac)
AS
(
SELECT dea.continent, dea.location, dea.date, dea.population,new_vaccinations, vac.new_vaccinations,
SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vac,
FROM CovidDeaths as dea
JOIN covidvaccinations vac
ON dea.date = vac.date and dea.location = vac.location
); -- this will create a table and then we can use select command - select * from popvsvac; to get our results. and here only writethe cal and run

-- 2nd TEMP TABLE

-- DROP TABLE IF exists #Percent_pop_vac
-- CREATE TABLE #Percent_pop_vac (
-- continent CHAR(255),
-- location VARCHAR(225),
-- date DATE,
-- population INT,
-- new_vaccinations INT,
-- rolling_people_vac INT
-- )
-- INSERT INTO #Percent_pop_vac
-- SELECT dea.continent, dea.location, dea.date, dea.population,new_vaccinations, vac.new_vaccinations,
-- SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vac,
-- FROM CovidDeaths as dea
-- JOIN covidvaccinations vac
-- ON dea.date = vac.date and dea.location = vac.location
-- SELECT *, (rolling_people_vac/population)*100
-- FROM #Percent_pop_vac


-- creating views 
CREATE VIEW pct_pop AS 
SELECT location,MAX(total_deaths) AS Highest_death_infection, (MAX(total_deaths/population))*100 AS pct_death_rate,
MAX(total_cases) AS Highest_infection_rate, (MAX(total_cases/population))*100 AS pct_inf_rate
FROM CovidDeaths
GROUP BY location,population
ORDER BY pct_death_rate DESC ,pct_inf_rate DESC;

-- to see the view created
SELECT * FROM pct_pop;


























