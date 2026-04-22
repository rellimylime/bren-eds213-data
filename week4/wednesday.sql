-- start by opening toy database: duckdb toy.duckdb

SELECT * FROM A;
SELECT * FROM B;

SELECT * FROM A CROSS JOIN B;

SELECT acol1, acol2 FROM (SELECT * FROM A CROSS JOIN B);

SELECT acol1, ANY_VALUE(acol2), COUNT(*) -- SQL need ANY_VALUE because acol2 is not in the GROUP BY, but we know that all values of acol2 will be the same for each value of acol1
    FROM (SELECT * FROM A CROSS JOIN B)
    GROUP BY acol1;

SELECT acol1, ANY_VALUE(acol2), COUNT(bcol3) 
    FROM (SELECT * FROM A CROSS JOIN B)
    GROUP BY acol1;

-- USING a condition
SELECT * FROM A JOIN B ON acol1 < bcol1;


SELECT * FROM Student;
SELECT * FROM House;

-- INNER
SELECT * FROM Student AS S JOIN House AS H ON S.House_ID  = H.House_ID;

-- shorter syntax but requires that the column name be the same in both tables, also, columns are not repeated
SELECT * FROM Student JOIN House USING (House_ID);

-- LEFT JOIN
SELECT * FROM Student LEFT JOIN House USING (House_ID);

-- FULL JOIN
SELECT * FROM Student FULL JOIN House USING (House_ID);