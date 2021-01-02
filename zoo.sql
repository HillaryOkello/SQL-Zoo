-- SELECT BASICS
SELECT population FROM world WHERE name = 'Germany';
SELECT name, population FROM world WHERE name IN ('Sweden', 'Norway', 'Denmark');
SELECT name, area FROM world WHERE area BETWEEN 200000 AND 250000;

--SELECT FROM WORLD
SELECT name, continent, population FROM world;
SELECT name FROM world WHERE population > 200000000;
SELECT name, GDP/population FROM world WHERE population > 200000000;
SELECT name, population / 1000000 FROM world WHERE continent = 'South America';
SELECT name, population FROM world WHERE name IN ('France', 'Germany', 'Italy');
SELECT name FROM world WHERE name LIKE '%United%';
SELECT name, population, area FROM world WHERE population > 250000000 OR area > 3000000;
SELECT name, population, area FROM world WHERE population > 250000000 XOR area > 3000000;
SELECT name, ROUND(population / 1000000, 2), ROUND(GDP / 1000000000, 2) FROM world WHERE continent = 'South America';
SELECT name, ROUND(GDP / population / 1000, 0) * 1000 FROM world WHERE GDP > 1000000000000;
SELECT name, capital FROM world WHERE LENGTH(name) = LENGTH(capital);
SELECT name, capital FROM world WHERE LEFT(name,1) = LEFT(capital,1) AND name != capital;
SELECT name FROM world WHERE name LIKE '%a%' AND name LIKE '%e%'AND name LIKE '%i%' AND name LIKE '%o%' AND name LIKE '%u%' AND name NOT LIKE '% %';
