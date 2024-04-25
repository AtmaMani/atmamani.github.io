# SQL - Joining tables

To visit:
 - Simple Join
 - Inner Join
 - Left Join
 - Right Join
 - Cross Join
 - Self Join
 - Full outer Join

## Sub queries
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

## Simple JOINs
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

