-- First review item: tri-value logic
-- Expression can have a value (if Boolean, TRUE or FALSE), but they can also be NULL
-- In selecting rows, NULL doesn't cut it, NULL doesnt count as TRUE

SELECT COUNT(*) FROM Bird_nests
    WHERE floatAge < 7 OR floatAge >= 7;
    
SELECT COUNT(*) FROM Bird_nests
    WHERE floatAge IS NULL;

-- Review item: relational algebra
-- Everything is a table! Every operation returns a table!

SELECT COUNT(*) FROM Bird_nests

-- We looked at one example of nesting SELECTs

SELECT Scientific_name
    FROM Species
    WHERE Code NOT IN ( SELECT DISTINCT Species FROM Bird_nests );

-- Lets pretend that SQL didn't have a HAVING clause. Could we somehow get the same functionality?
-- Lets go back to the example where we used a HAVING clause

SELECT Location, MAX(Area) AS Max_area
    FROM Site
    WHERE Location LIKE '%Canada'
    GROUP BY Location
    HAVING MAX(Area) > 200;

-- As a reminder, the site table:
    SELECT * FROM Site LIMIT 5;

-- REVIEW NESTED SELECTS

-- REVIEW AND CONTINUING DISCUSSION OF JOINS
-- What is a join? Conceptually, the database performs a Cartesian product of the two tables, then filters down to the rows that match the join condition
-- In some databases, to do a Cartesian product you would just do a JOIN without a condition
SELECT * FROM A JOIN B;
-- **But** in DuckDB, you have to say:
SELECT * FROM A CROSS JOIN B;
SELECT * FROM A;
SELECT * FROM B;

-- Heres what the cartesian product looks like:
SELECT * FROM A CROSS JOIN B;

-- let's do a join condition, which can be any expression
SELECT * FROM A JOIN B ON acol1 < bcol1;
-- this is what's refered to as an INNER JOIN, because it only includes rows that match the condition

-- outer join: includes rows that don't match the condition, but fills in NULLs for the missing values
SELECT * FROM A RIGHT JOIN B ON acol1 < bcol1;

SELECT * FROM A LEFT JOIN B ON acol1 < bcol1;

-- Just for completeness (not commonly used), a FULL OUTER JOIN includes all rows, and fills in NULLs for missing values on either side
SELECT * FROM A FULL OUTER JOIN B ON acol1 < bcol1;

