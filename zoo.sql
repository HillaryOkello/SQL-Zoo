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

--SELECT in SELECT
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

--SUM and COUNT
SELECT SUM(population) FROM world;
SELECT DISTINCT(continent) FROM world;
SELECT SUM(gdp) FROM world WHERE continent = 'Africa';
SELECT COUNT(area) FROM world WHERE area > 1000000;
SELECT SUM(population) FROM world WHERE name IN ('Estonia', 'Latvia', 'Lithuania');
SELECT continent, COUNT(name) FROM world GROUP BY continent;
SELECT continent, COUNT(name) FROM world WHERE population > 10000000 GROUP BY continent;
SELECT continent FROM world GROUP BY continent HAVING SUM(population) > 100000000;

--JOIN
SELECT matchid, player FROM goal WHERE teamid = 'GER';
SELECT id,stadium,team1,team2 FROM game WHERE id = 1012;
SELECT player, teamid, stadium, mdate FROM game JOIN goal ON (id=matchid) WHERE teamid = 'GER';
SELECT team1, team2, player FROM game JOIN goal ON (id=matchid) WHERE player LIKE 'Mario%';
SELECT player, teamid, coach, gtime FROM goal JOIN eteam on teamid=id WHERE gtime<=10;
SELECT mdate, teamname FROM game JOIN eteam ON (team1=eteam.id) WHERE eteam.coach = 'Fernando Santos';
SELECT player FROM game JOIN goal ON (id=matchid) WHERE stadium = 'National Stadium, Warsaw';
SELECT DISTINCT(player) FROM game JOIN goal ON matchid = id  WHERE (team1='GER' OR team2='GER') AND teamid !='GER';
SELECT teamname, COUNT(player) FROM eteam JOIN goal ON id=teamid GROUP BY teamname ORDER BY teamname;
SELECT stadium, COUNT(matchid) FROM game JOIN goal ON id = matchid GROUP BY stadium;
SELECT matchid, mdate, COUNT(matchid) FROM game JOIN goal ON matchid = id WHERE (team1 = 'POL' OR team2 = 'POL') GROUP BY matchid, mdate;
SELECT matchid, mdate, COUNT(matchid) FROM game JOIN goal ON matchid = id WHERE (teamid = 'GER') GROUP BY matchid, mdate;
SELECT mdate, team1, SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) AS score1, team2, SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) AS score2
  FROM game LEFT JOIN goal ON matchid = id GROUP BY mdate, team1, team2 ORDER BY mdate, matchid, team1, team2;

--More JOIN
SELECT id, title FROM movie WHERE yr=1962;
SELECT yr FROM movie WHERE title = 'Citizen Kane';
SELECT id, title, yr FROM movie WHERE title LIKE ('%Star Trek%') ORDER BY yr;
SELECT id FROM actor WHERE name = 'Glenn Close';
SELECT id FROM movie WHERE title = 'Casablanca';
SELECT name FROM actor JOIN casting ON actorid = id WHERE movieid = 11768;
SELECT name FROM actor JOIN casting ON actorid = actor.id JOIN movie ON movieid = movie.id WHERE title = 'Alien';
SELECT title FROM movie JOIN casting ON movieid = movie.id JOIN actor ON actorid = actor.id WHERE name = 'Harrison Ford';
SELECT title FROM movie JOIN casting ON movieid = movie.id JOIN actor ON actorid = actor.id WHERE name = 'Harrison Ford' AND ord != 1;
SELECT title, name FROM movie JOIN casting ON movieid = movie.id JOIN actor ON actorid = actor.id WHERE ord = 1 AND yr = 1962;
SELECT yr,COUNT(title) FROM movie JOIN casting ON movie.id=movieid JOIN actor ON actorid=actor.id
  WHERE name='Rock Hudson' GROUP BY yr HAVING COUNT(title) > 2;
SELECT title, name FROM movie JOIN casting ON movieid = movie.id JOIN actor ON actorid = actor.id
  WHERE ord = 1 AND movie.id IN (SELECT movieid FROM casting WHERE actorid IN (SELECT id FROM actor WHERE name='Julie Andrews'));
SELECT name FROM movie JOIN casting ON movieid = movie.id JOIN actor ON actorid = actor.id
  WHERE ord = 1 GROUP BY name HAVING COUNT(*) >= 15 ORDER BY name;
SELECT title, COUNT(actorid) FROM movie JOIN casting ON movieid = movie.id WHERE yr = 1978 GROUP BY title ORDER BY COUNT(actorid) DESC, title;
SELECT DISTINCT(name) FROM actor JOIN casting ON actorid = actor.id
  WHERE movieid IN (SELECT movieid FROM casting JOIN actor ON actorid = actor.id WHERE name = 'Art Garfunkel') AND name != 'Art Garfunkel';

--Using Null
SELECT name FROM teacher WHERE dept IS NULL;
SELECT teacher.name, dept.name FROM teacher INNER JOIN dept ON (teacher.dept=dept.id);
SELECT teacher.name, dept.name FROM teacher LEFT JOIN dept ON (teacher.dept=dept.id);
SELECT teacher.name, dept.name FROM teacher RIGHT JOIN dept ON (teacher.dept=dept.id);
SELECT name, COALESCE(mobile, '07986 444 2266') FROM teacher;
SELECT teacher.name, COALESCE(dept.name, 'None') FROM teacher LEFT JOIN dept ON teacher.dept = dept.id;
SELECT COUNT(name), COUNT(mobile) FROM teacher;
SELECT dept.name, COUNT(teacher.name) FROM teacher RIGHT JOIN dept ON teacher.dept = dept.id WHERE dept.name IS NOT NULL GROUP BY dept.name;
SELECT teacher.name, (CASE WHEN dept=1 OR dept=2 THEN 'Sci' WHEN dept=3 THEN 'Art' ELSE 'None' END) FROM teacher;

--Self JOIN
SELECT COUNT(id) FROM stops;
SELECT id FROM stops WHERE name = 'Craiglockhart';
SELECT stops.id, stops.name FROM stops JOIN route ON stop = stops.id WHERE num = 4 AND company = 'LRT' ORDER BY pos;
SELECT company, num, COUNT(*) AS stops FROM route WHERE stop=149 OR stop=53 GROUP BY company, num HAVING stops = 2;
SELECT a.company, a.num, a.stop, b.stop FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num) WHERE a.stop=53 AND b.stop = 149;
SELECT a.company, a.num, stopa.name, stopb.name FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num) JOIN stops stopa ON (a.stop=stopa.id) JOIN stops stopb ON (b.stop=stopb.id)
  WHERE stopa.name='Craiglockhart' AND stopb.name = 'London Road';
SELECT DISTINCT a.company, a.num FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num) WHERE a.stop=115 AND b.stop = 137;
SELECT DISTINCT a.company, a.num FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num) JOIN stops stopa ON (a.stop=stopa.id) JOIN stops stopb ON (b.stop=stopb.id)
  WHERE stopa.name='Craiglockhart' AND stopb.name = 'Tollcross';
SELECT DISTINCT stopb.name, a.company, a.num FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num) JOIN stops stopa ON (a.stop=stopa.id) JOIN stops stopb ON (b.stop=stopb.id)
  WHERE stopa.name='Craiglockhart' AND a.company = 'LRT';