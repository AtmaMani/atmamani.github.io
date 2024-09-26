# SQL operators and sorting rows

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
 - `BETWEEN` - for range values such as money, dates, times, etc. Between is **inclusive** of upper and lower bounds used.
 - `IS NULL` to check if a value is null. **Do not use** `= NULL`.

Examples:
```sql
>SELECT * FROM employees WHERE department_id=5 ORDER BY first_name;
>SELECT * FROM employees WHERE last_name LIKE "chen";

```

### SQL Aggregate functions
These arithmetic functions reduce multiple records to a single record using aggregators.

 - `SUM`
 - `AVG`
 - `MIN`
 - `MAX`
 - `COUNT`

 Ex:
 ```sql
 /* Find total of columns marks in Math subject */
SELECT SUM(Marks) AS TotalMarks FROM StudentGrades WHERE Subject = "Mathematics";
```



### `ORDER BY` operator
Used to sort the displayed results. This does not change the data organization in the persisted table though. The general syntax is below. The default sort order is `ASC` for ascending.

```sql
SELECT <columns> FROM <table> ORDER BY <col 1> <ASC | DESC>, <col2> <ASC | DESC>;
--example
SELECT * FROM employees ORDER BY hire_date ASC LIMIT 10;
SELECT * FROM employees ORDER BY hire_date ASC, salary DESC LIMIT 10;
```

### `DISTINCT` operator
Used to remove duplicates from the result set. Also used to get unique values. If there is `1` column after `DISTINCT` the operator finds unique values in that column. If multiple columns are specified, the operator will use the **combinations of values** in all specified columns for uniqueness check.

> **Note:** DISTINCT operator treats all `NULL` values the same. Thus it returns just one record per NULL value.

```sql
SELECT DISTINCT <col1>, <col2> FROM <table>;

--EXAMPLE find unique job_id
sqlite> SELECT DISTINCT job_id FROM employees ORDER BY job_id;
job_id
------
1     
2     
3     
4     
....

--EXAMPLE: find unique combinations of job_id and manager_id
sqlite> SELECT DISTINCT job_id, manager_id FROM employees ORDER BY job_id;
job_id  manager_id
------  ----------
1       205       
2       101       
3       101       
4                 
5       100       
6       108   
...
```

### `GROUP BY` operator
Used to group records by one or more columns. This is a variant of `DISTINCT` where you can select two or more columns but remove duplicates in 1 column from the result set. Group by is commonly used with **aggregation** functions.

```sql
/* Find the average price of products for each category */
SELECT   Category, AVG(Price) AS AveragePrice
FROM     Products
GROUP BY Category;
```

### `HAVING` clause
The `HAVING` clause is used to filter results **after** the **grouping** operation. It operates on row-groups. The `WHERE` clause is used to filter **before** grouping operation. Where operates on individual rows, not row-groups.

```sql
/*Select categories with avg price > 50*/
SELECT Category, AVG(Price) AS AvgPrice FROM Products
GROUP BY Category
HAVING AVG(Price) > 50;
```
Using both `WHERE` AND `HAVING` clauses:

```sql
SELECT column1, function_name(column2)
FROM table_name
WHERE condition
GROUP BY column1, column2
HAVING condition;
```

## SQL DateTime operations
SQL provides a number of functions to work with datetime:

- `NOW()`: Returns the current date and time
- `CURDATE()`: Returns the current date
- `YEAR()`: Extracts the YEAR part from a datetime or a date type
- `TIMESTAMPDIFF(unit, datetime1, datetime2)`: Calculates the difference between two datetimes based on a specified unit
- `DATE_FORMAT(col, str_fmt)` such as `'%Y'` for year parsing, `'%W` for name of weekday.
- `DAYNAME(col)`: To get name of week day (Eg: Tuesday)
- `WEEKDAY(col)`: To get enumeration of the week day: 1-Sunday ... 7-Saturday.

Example, to extract just the year from datetime:

```sql
/* The query to extract the year from a date */
SELECT *, YEAR(DateOfJoining) AS YearOfJoining
FROM   EmployeeDetails;
```

Example, calculate age of employees from date of birth:

```sql
/* Calc age from dob */
SELECT *, 
YEAR(CURDATE()) - YEAR(DateOfBirth) - (DAYOFYEAR(NOW()) < DAYOFYEAR(DateOfBirth)) AS Age 
FROM Employees;
```

Example: Select employees who have a DOB between two given dates:

```sql
SELECT COUNT(*) FROM Employees WHERE DateOfBirth BETWEEN '1993-01-01' AND '1995-12-31');
```


## SQL String operations
SQL provides a few string operators like this:

- `SUBSTRING(col/string/date, start pos, end pos)`: To extract sub strings
- `LEFT(col/string/date, num char)`: to extract left n chars
- `RIGHT(col/string/date, num char)`: to extract right n chars (counted in reverse obviously)

Find records of all students whose name ends with 'a':

```sql
/* The query to find the students whose name ends with 'a' */
SELECT * FROM StudentGrades
WHERE  StudentName LIKE '%a';

--or--
SELECT * FROM StudentGrades WHERE RIGHT(StudentName, 1) = 'a'


```
