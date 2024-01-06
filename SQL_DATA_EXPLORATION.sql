--COVID-19 DATA EXPLORATION

Select * From CovidDeaths$
Order by 3,4

Select * From CovidVaccinations$
where new_vaccinations <> 'NULL'

Select location, date, total_deaths, new_cases, total_cases, population
FROM CovidDeaths$
Order by 1,2

-- Comparing total cases to total deaths can provide Case Fatality Rate(CFR) 
-- which is to measure the severity of a disease 

Select location, date, total_deaths, total_cases, (total_deaths/total_cases)*100 as CFR
FROM CovidDeaths$
WHERE location = 'India'and total_deaths <> 'NULL'
Order by 1,2

-- Comparing total number of cases to the population can provide Infection rate

Select location, date, population, total_cases, (total_cases/population)*100 as InfectionRate
FROM CovidDeaths$
WHERE location like '%India%'
Order by 1,2

-- Identify region with the highest and lowest infection rates 

Select location, population,
 MAX((total_cases/population))*100 as HigestInfectionRate,
 MIN((total_cases/population))*100 as LowestInfectionRate
FROM CovidDeaths$
Group by location, population
Order by HigestInfectionRate desc 

-- Identify region with hightest death rate per population 

Select location, population, MAX(Total_deaths) AS HigestDeath
From CovidDeaths$
Where continent is not null
Group by location, population

-- Understanding the overall impact and scale of pandemic on global level
Select 
SUM(new_cases) as TotalCases, 
SUM(cast(new_deaths as int)) as TotalDeaths, 
SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From CovidDeaths$
where continent is not null 
order by 1,2

-- To show the percentage of the population that has received vaccine dose usiing JOIN

Select D.continent, D.location, D.population, 
SUM(CONVERT(int,V.new_vaccinations))/ SUM(D.population)*100 AS PercentageVaccineted
From CovidDeaths$ D Join CovidVaccinations$ V
On D.location = V.location and D.date = V.date
where D.continent <> 'null' 
Group by D.continent, D.location, D.population
order by 3,4