title: SQL Queries

## Optimizing queries using Index
You can build an index using the `CREATE` command. Syntax: `CREATE INDEX <index name> ON <table> (<col_name>);`

```sql
sqlite> CREATE INDEX "title_index" ON "shows" ("title");
Run Time: real 0.151 user 0.113454 sys 0.021356
```
The database uses a **tree** type data structure to optimize the search. Often a **B-tree** data structure is used. The tree is wide horizontally and shallow in tallness. The index creation is expensive, but queries are faster.

> Schema of the IMDB training table:
```
sqlite> .schema
CREATE TABLE shows (
                    id INTEGER,
                    title TEXT NOT NULL,
                    year NUMERIC,
                    episodes INTEGER,
                    PRIMARY KEY(id)
                );
CREATE TABLE genres (
                    show_id INTEGER NOT NULL,
                    genre TEXT NOT NULL,
                    FOREIGN KEY(show_id) REFERENCES shows(id)
                );
CREATE TABLE stars (
                show_id INTEGER NOT NULL,
                person_id INTEGER NOT NULL,
                FOREIGN KEY(show_id) REFERENCES shows(id),
                FOREIGN KEY(person_id) REFERENCES people(id)
            );
CREATE TABLE writers (
                show_id INTEGER NOT NULL,
                person_id INTEGER NOT NULL,
                FOREIGN KEY(show_id) REFERENCES shows(id),
                FOREIGN KEY(person_id) REFERENCES people(id)
            );
CREATE TABLE ratings (
                show_id INTEGER NOT NULL,
                rating REAL NOT NULL,
                votes INTEGER NOT NULL,
                FOREIGN KEY(show_id) REFERENCES shows(id)
            );
CREATE TABLE people (
                id INTEGER,
                name TEXT NOT NULL,
                birth NUMERIC,
                PRIMARY KEY(id)
            );
```

## Operations on columns
When querying data using `SELECT` statement, you can perform basic arithmetic and type conversions. The results are on-the-fly and not stored.

```sql
SELECT first_name, last_name, salary, salary * 1.05 as hike_salary
    FROM employees;
```

### SQL operators
Operators:

 - `=` for equality. Note, just 1 equal sign.
 - `<>` or `!=` for non equality
 - `<`, `<=`, `>`, `>=` for size comparison
 - `LIKE` - for tolerant string comparison
 - `AND`, `OR` - to chain conditions
 - `BETWEEN` - for range values such as money, dates, times, etc.
 - `IS NULL` to check if a value is null. **Do not use** `= NULL`.

Examples:
```sql
>SELECT * FROM employees WHERE department_id=5 ORDER BY first_name;
>SELECT * FROM employees WHERE last_name LIKE "chen";

```

### Sub queries
You can join two tables without actually using a join. This is a primitive and simpler way and is less readable. Below we try to find shows with "Arnold Sch..".

```sql
--Step 1: find person ID of Arnold Sch..
sqlite> SELECT id FROM people WHERE name LIKE "%Arnold Sch%";
216

--Step 2: pass this to stars table to find show id
sqlite> SELECT show_id FROM stars WHERE person_id = (SELECT id FROM people WHERE name LIKE "%Arnold Sch%");
200355
1025006
10408914
...

--Step 3: pass this to shows table to get show names
sqlite> SELECT * FROM shows WHERE id IN (SELECT show_id FROM stars WHERE person_id = (SELECT id FROM people WHERE name LIKE "%Arnold Sch%"));
200355|Moviewatch|1993|68
1025006|Regis Philbin's Lifestyles|1984|11
1388415|Citizen Kate|2008|
1990507|Climate One Commonwealth Club Forum|2010|2
2963070|Years of Living Dangerously|2014|17
4074786|Radical Body Transformations|2015|30
4995052|Explorer|2015|42
5290904|Talking to Hollywood with Betty Zhou|2015|5
7423218|Objectified|2016|25
10408914|Superhero Kindergarten|2021|14
10922386|Chad Goes Deep|2017|32
12591074|Hallo, wie geht's|1989|37
14650368|The New Celebrity Apprentice|2017|7
15545956|Action - Neu im Kino|1986|
```
I had no idea Arnold Schwarzenegger acted in so many shows, some as recent at 2021!

In the example below, we find the employees with the second highest salary from emp db.

```sql
--limit 1 offset 1 gets the 2nd row from the result set
sqlite> SELECT employee_id, first_name, last_name, salary
   ...> FROM employees
   ...> WHERE salary = (SELECT DISTINCT salary FROM
   ...> employees ORDER BY salary DESC LIMIT 1 OFFSET 1);
employee_id  first_name  last_name  salary 
-----------  ----------  ---------  -------
101          Neena       Kochhar    17000.0
102          Lex         De Haan    17000.0
```

### Simple JOINs
You can JOIN two tables using the syntax: Here `PK - primary key` and `FK - foreign key`.
```sql
-- Simple join syntax
SELECT <cols> FROM <tableA> JOIN <tableB> ON <how_to_join>
SELECT users.fullname, cars.mileage_info FROM users JOIN cars ON users.car_name = cars.name

-- With where and order by
SELECT <cols_to_disp> FROM <tableA> JOIN <tableB> ON <tableA.PK> = <tableB.FK> WHERE <condition> ORDER BY <field>;
```

You can nest multiple joins as shown below:

```sql
sqlite> SELECT title FROM people JOIN stars ON people.id = stars.person_id JOIN shows ON stars.show_id = shows.id WHERE people.name LIKE "Arnold Sch%" ORDER BY shows.year;
```

Another style to write this join, if you know the tables being used before hand, is this:

```sql
SELECT title FROM people, stars, shows WHERE people.id = stars.person_id AND stars.show_id = shows.id AND people.name LIKE "Arnold Sch%" ORDER BY shows.year;
```
Notice the command `JOIN` does not show up in the case above.

## Problem sets:
1. **How many shows to type 'Comedy' were directed during a leap year?**: This is a simple join between `shows` and `genres` tables. Use `%` operator as a modulus.
    
```sql
SELECT COUNT(DISTINCT shows.id) FROM shows
JOIN genres ON shows.id = genres.show_id
WHERE shows.year % 4 = 0
AND genres.genre = "Comedy";
```

2. **List all actors that have acted in a show called "Anandham".**: This requires joining 3 tables - `person`, `stars`, `shows` and getting the actor names
    
```sql
SELECT people.name FROM people
JOIN stars ON people.id = stars.person_id 
JOIN shows ON stars.show_id = shows.id
WHERE shows.title = "Anandham";
```

which returns:

```
name             
-----------------
Saakshi Sivaa    
Brinda Das       
Kamalesh         
Delhi Kumar
...
```

3. **Find the number of actors that acted in shows between 1970 and 1990**: This requires joining the same 3 tables and counting distinct actor ids:

```sql
SELECT COUNT(DISTINCT people.id) FROM PEOPLE 
JOIN stars ON people.id  = stars.person_id 
JOIN shows ON stars.show_id = shows.id 
WHERE shows.year BETWEEN 1970 AND 1990;
```

returns

```
COUNT(DISTINCT people.id)
-------------------------
72095
```

4. **How many actors also worked as writers**?

```sql
SELECT COUNT(DISTINCT name) FROM people
WHERE id IN 
(SELECT stars.person_id FROM stars 
JOIN writers ON stars.person_id = writers.person_id);
```

5. **List to top 10 shows that have highest votes and highest rating**

```sql
SELECT shows.title, shows.year, shows.episodes, ratings.rating, ratings.votes FROM shows 
JOIN ratings ON shows.id = ratings.show_id 
ORDER BY ratings.votes DESC, ratings.rating DESC 
LIMIT 10;
```

returns

```
title                  year  episodes  rating  votes  
---------------------  ----  --------  ------  -------
Game of Thrones        2011  73        9.2     1888391
Breaking Bad           2008  62        9.4     1596038
Stranger Things        2016  34        8.7     920887 
The Walking Dead       2010  177       8.2     907667 
Friends                1994  235       8.8     905205 
Sherlock               2010  15        9.1     854590 
The Big Bang Theory    2007  280       8.1     754516 
Dexter                 2006  96        8.6     679125 
How I Met Your Mother  2005  208       8.3     635758 
True Detective         2014  24        8.9     524834
```