title: SQL Operators and sorting rows

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
Used to group records by one or more columns. This is a variant of `DISTINCT` where you can select two or more columns but remove duplicates in 1 column from the result set.