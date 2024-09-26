# SQL - CRUD

Content derived from:
 - https://www.sqltutorial.org/
 - https://www.sqlitetutorial.net/

SQL consists of 

 - **Data definition language** : CREATE TABLE, ALTER TABLE, CREATE DATABASE etc.
 - **Data manipulation language**: SELECT, INSERT, UPDATE, DELETE statements 
 - **Data control language**: GRANT USER, REVOKE USER etc.

## SQL Standards
SQL was first created in 1970. ANSI then published the first SQL Standard in 1986, the second in 1992 called SQL92 or SQL2, third in 1999 called SQL99 or SQL3. The latest is SQL:2011

## 4 basic ops in a database:
CRUD - Create, Read (Select), Update, Delete (Drop). In this page, we use [`sqlite3`](https://www.sqlite.org/index.html) for the database. SQLite is tiny, portable, fast, light-weight database and works on all kinds of architectures (phones, laptops, cloud, edge devices etc). To enter sqlite, you type `> sqlite3`. To exit and return back to bash, you type `.quit`.

## Creating a table
Use `sqlite3` database which is portable and tiny. To create a new database, use `$ sqlite3 <db_name>`

```
(scratch) ➜  sql-playground$ sqlite3 favorites.db
SQLite version 3.38.3 2022-04-27 12:03:15
Enter ".help" for usage hints.
sqlite> 
```
Importing CSV into the DB:

```sql
sqlite> .mode csv
sqlite> .import ../../temp/src7/favorites/favorites.csv fav
sqlite> .schema
CREATE TABLE IF NOT EXISTS "fav"(
"Timestamp" TEXT, "title" TEXT, "genres" TEXT);
sqlite> 
```

Specifying primary keys, datatypes and auto-incrementing keys:

```sql
CREATE TABLE Employees (
     EmpID   INT AUTO_INCREMENT PRIMARY KEY,
     EmpName VARCHAR(50),
     Salary  DECIMAL(10, 2)
);
```

### Opening back a SQLite DB
To open a DB back, use `sqlite3 <db name>`

```
scratch) ➜  sql-playground ls
favorites.db  favorites2.db
(scratch) ➜  sql-playground sqlite3 favorites2.db 
SQLite version 3.38.3 2022-04-27 12:03:15
Enter ".help" for usage hints.
sqlite>
```

## Listing DB content

* `.tables` to list tables in the current DB
* `.tables <pattern>` like `.tables f%` to open all tables that begin with `f`.
* `.schema` to list all table schemas: Shows create table commands for all tb within the db

## Reading - Select statements
General syntax: `SELECT <columns> FROM <database.table> WHERE <condition>;`. YOu need to terminate commands with `;` Example:

```sql
SELECT Timestamp, language FROM favorires;
```
You can perform operations on the data as you query them out. You can do `AVG, COUNT, DISTINCT, LOWER, MAX, MIN, UPPER...` etc.

```sql
sqlite> SELECT DISTINCT(language) FROM favorires;
C
Python
Scratch

sqlite> SELECT COUNT(Timestamp) FROM favorires;
1456

sqlite> SELECT COUNT(DISTINCT(title)) FROM fav;
107
```

### Limiting outputs
Use `LIMIT <num>` to limit what is displayed.

```sql
sqlite> SELECT title FROM fav LIMIT 5;
"How i met your mother"
"The Sopranos"
"Friday Night Lights"
"Family Guy"
"New Girl"
sqlite> 
```

### Paging output using `OFFSET` and `LIMIT`
Use `LIMIT row_count OFFSET offset` syntax to page through the results. You can increment the offset as you page through a large result table. Is is important to **`ORDER BY`** when paging to avoid duplicates.

```sql
--page 2
sqlite> SELECT employee_id, first_name, last_name FROM employees ORDER BY employee_id LIMIT 5 OFFSET 5;

employee_id  first_name  last_name
-----------  ----------  ---------
105          David       Austin   
106          Valli       Pataballa
107          Diana       Lorentz  
108          Nancy       Greenberg
109          Daniel      Faviet   

--page 3
sqlite> SELECT employee_id, first_name, last_name FROM employees ORDER BY employee_id LIMIT 5 OFFSET 10;
employee_id  first_name   last_name
-----------  -----------  ---------
110          John         Chen     
111          Ismael       Sciarra  
112          Jose Manuel  Urman    
113          Luis         Popp     
114          Den          Raphaely
```

### Where clauses
Equality operations. In sql, `=` is used for comparison, not `==`. For text columns, you can use `LIKE`. YOu can also combine with some simple regex like `%string%` to indicate any chars before and after the substring.

```sql
sqlite> SELECT title FROM fav WHERE title= "office";
sqlite> SELECT title FROM fav WHERE title LIKE  "office";
Office
Office
sqlite> SELECT title FROM fav WHERE title LIKE  "%office%";
Office
Office
"The Office"
"The Office"
"The Office"
...
"ThE OffiCE"
"The Office"
Thevoffice
```

## `DELETE` - deleting records
use `DELETE FROM <table> WHERE <condition>` to delete records that match the condition.

```sql
sqlite> SELECT count(title) FROM fav WHERE title LIKE "%friends%";
9
sqlite> DELETE FROM fav WHERE title LIKE "%friends%";
sqlite> SELECT count(title) FROM fav WHERE title LIKE "%friends%";
0
sqlite> 
```

## `UPDATE` - Updating records
Use `UPDATE <table> SET <operation> WHERE <condition>` syntax. Command will operate on all records that match the given where clause.

```sql
sqlite> SELECT title FROM fav WHERE title = "Thevoffice";
Thevoffice
sqlite> UPDATE fav SET title = "The Office" WHERE title = "Thevoffice";

-- Verify
sqlite> SELECT title FROM fav WHERE title = "Thevoffice";
sqlite> 
```

## `INSERT` - Inserting records
Use `INSERT INTO <table> (<columns>) VALUES (<comma sep values>);`. Example:

```
sqlite> INSERT INTO genres (show_id, genre) VALUES (159, "Comedy");
```

Insert multiple records using multiple comma separated tuples:

```sql
INSERT INTO TableName
VALUES  (value1, value2, value3),
        (value1, value2, value3),
        (value1, value2, value3);
```

## CRUD command syntax

```sql
CREATE TABLE <tablename>;
INSERT INTO <tablename> VALUES ();
SELECT <cols> FROM <tablename> WHERE <condition>;
UPDATE <tablename> SET col=val, col=val;
DELETE FROM <tablename> WHERE <condition>;
```

## Utility commands for `SQLite`

* Getting schema of a database: `.schema`
* Viewing datatypes of each column in a table: `pragma table_info('tb_name');`
* Timing your queries: `sqlite> .timer on` will start to return tike taken for your queries
* Printing column names for select queries - `.headers on`
* Pretty print with table formatting `.mode column`

## Drop vs Truncate table
`DROP TABLE` will delete the entire table (schema and values). 