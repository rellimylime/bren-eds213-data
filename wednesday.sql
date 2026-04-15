.table
# recap from Monday
# keywords are ALL CAPS, we did queries such as 

SELECT DISTINCT Location
    FROM Site
    ORDER BY Location
    LIMIT 3;

-- FILTERING
-- looks just like in R or Python
-- * means all the columns
SELECT * FROM Site WHERE Area < 200;
SELECT * FROM Site WHERE Area < 200 AND Latitude > 60;

-- older-style operators
SELECT * FROM Site WHERE Code != 'iglo';
SELECT * FROM Site WHERE Code <> 'iglo'; -- older style

-- expressions: the usual operators, plus lots of functions like regex

## Expressions
SELECT Site_name, Area*2.47 FROM Site; -- convert area from hectares to acres

-- very handy to give a name to columns
SELECT Site_name, Area*2.47 AS Area_acres FROM Site;

-- string concatenation
-- old-style operator: ||
SELECT Site_name || ', ' || Location AS Full_name FROM Site;

## AGGREGATION and GROUPING

-- how many rows are in this table?
SELECT COUNT(*) FROM Bird_nests;

-- the "*" in the above means just count rows
-- we can also ask, how many non-NULL values are there?
SELECT COUNT(*) FROM Species;
SELECT COUNT(Scientific_name) FROM Species;

-- very handy to count number of distinct things
SELECT COUNT(DISTINCT Location) FROM Site; -- number of distinct locations
SELECT COUNT(Location) FROM Site; -- number of non-NULL locations

-- reminder from Monday:
SELECT DISTINCT Location FROM Site; -- what are the distinct locations?

-- other aggregations
SELECT AVG(Area) FROM Site;
SELECT MIN(Area) FROM Site;

-- this won't work, but suppose we want to list the 7 locations
-- that occur in the Site table, along with the average areas
SELECT Location, AVG(Area) FROM Site; 

-- enter a grouping
SELECT Location, AVG(Area) FROM Site GROUP BY Location;

-- similar for counting
SELECT Location, COUNT(*) FROM Site GROUP BY Location;

-- we can still have WHERE clauses
SELECT Location, COUNT(*)
    FROM Site
    WHERE Location LIKE '%Canada'
    GROUP BY Location;

-- the order of the clauses reflects the order of the processing
-- but what if you want to do some filtering on your groups, i.e., after you have done the grouping
SELECT Location, MAX(Area) AS Max_area
    FROM Site
    Where Location LIKE '%Canada'
    GROUP BY Location
    HAVING Max_area > 200
    ORDER BY Max_area DESC;

## RELATIONAL ALGEBRA
-- Everything is a table
-- Every query and every statement, returns a table
SELECT COUNT(*) FROM Site;
-- have can save tables, you can next queries
SELECT COUNT(*) FROM ( SELECT COUNT(*) FROM Site );

-- you can next queries
SELECT DISTINCT Species from Bird_nests;
SELECT Code FROM Species
    WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);

## NULL processing
-- NULL is infectious
-- In a table, NULL means no data, the absence of a value
-- In an expression, NULL means unknown
SELECT COUNT(*) FROM Bird_nests WHERE ageMethod = 'float';
SELECT COUNT(*) FROM Bird_nests WHERE ageMethod <> 'float';

-- this wont work but
SELECT COUNT(*) FROM Bird_nests WHERE ageMethod = NULL -- this is always false, because NULL is unknown, so we can't say it's equal to anything, even NULL
-- The only way
SELECT COUNT(*) FROM Bird_nests WHERE ageMethod IS NULL;
SELECT COUNT(*) FROM Bird_nests WHERE ageMethod IS NOT NULL;

-- JOINS
-- 90% of the time, we'll join tables based on a foreign key relationship
SELECT * FROM Camp_assignment;
SELECT * FROM Camp_assignment JOIN Personnel
    ON Observer = Abbreviation
    LIMIT 10;

-- join is a very general operation and can be applied to any tables with any expression joining them
-- fundamentally joins always start from cartesian product of the table
-- CROSS JOIN = Cartesian product
SELECT * FROM Site CROSS JOIN Species;

-- *any* condition can be expression, we have complete freedom here

-- but when there *is* a foreign key relationship,
-- the result is the same as the table with the foreign, but augmented with additional columns from the other table
SELECT * FROM Bird_nests BN JOIN Species S
    ON BN.Species = S.Code
    LIMIT 5;

SELECT COUNT(*) FROM Bird_nests BN JOIN Species S
    ON BN.Species = S.Code

-- table aliases are useful, without them, the above query would be
SELECT * FROM Bird_nests JOIN Species
    ON Bird_nests.Species = Species.Code
    LIMIT 5;