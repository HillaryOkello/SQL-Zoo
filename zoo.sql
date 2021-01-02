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

--SELECT FROM NOBEL
SELECT yr, subject, winner FROM nobel WHERE yr = 1950;
SELECT winner FROM nobel WHERE yr = 1962 AND subject = 'Literature';
SELECT yr, subject FROM nobel WHERE winner = 'Albert Einstein';
SELECT winner FROM nobel WHERE yr >= 2000 AND subject = 'Peace';
SELECT yr, subject, winner FROM nobel WHERE yr >= 1980 AND yr <= 1989 AND subject = 'Literature';
SELECT * FROM nobel WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama');
SELECT winner FROM nobel WHERE winner LIKE 'John%';
SELECT yr, subject, winner FROM nobel WHERE (yr = 1980 AND subject = 'Physics') OR (yr = 1984 AND subject = 'Chemistry');
SELECT yr, subject, winner FROM nobel WHERE yr = 1980 AND subject NOT LIKE '%Chemistry%' AND subject NOT LIKE '%medicine%';
SELECT yr, subject, winner FROM nobel WHERE (subject = 'Medicine' AND yr < 1910) OR (subject = 'Literature' AND yr >= 2004);
SELECT * FROM nobel WHERE winner = 'PETER GRÜNBERG';
SELECT * FROM nobel WHERE winner = 'EUGENE O''NEILL';
SELECT winner, yr, subject FROM nobel WHERE winner LIKE 'Sir%' ORDER BY yr DESC, winner ASC;
SELECT winner, subject FROM nobel WHERE yr=1984 ORDER BY subject IN ('Physics', 'Chemistry'), subject, winner;

--SELECT within SELECT
SELECT name FROM world WHERE population > (SELECT population FROM world WHERE name='Russia');
SELECT name FROM world WHERE continent = 'Europe' AND gdp / population > (SELECT gdp / population FROM world WHERE name = 'United Kingdom');
SELECT name, continent FROM world
  WHERE continent = (SELECT continent FROM world WHERE name = 'Argentina') OR continent = (SELECT continent FROM world WHERE name = 'Australia')
  ORDER BY name;
SELECT name FROM world
  WHERE population > (SELECT population FROM world WHERE name = 'Canada') AND population < (SELECT population FROM world WHERE name = 'Poland')
  ORDER BY name;
SELECT name , CONCAT(ROUND(population / (SELECT population FROM world WHERE name = 'Germany') * 100, 0), '%') FROM world WHERE continent = 'Europe';
SELECT name FROM world WHERE IFNULL(gdp, 0) > ALL(SELECT IFNULL(gdp, 0) FROM world WHERE continent = 'Europe');
SELECT continent, name, area FROM world x WHERE area >= ALL (SELECT area FROM world y WHERE y.continent=x.continent AND area>0);
SELECT continent, name FROM world x WHERE name <= ALL (SELECT name FROM world y WHERE y.continent=x.continent);
SELECT name, continent, population FROM world x WHERE 25000000 > ALL(SELECT population FROM world y WHERE y.continent=x.continent AND y.population > 0);
SELECT name, continent FROM world x WHERE population > ALL(SELECT population * 3 FROM world y WHERE y.continent=x.continent AND y.population > 0 AND x.name != y.name);