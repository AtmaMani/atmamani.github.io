# SQL - In Depth

## Parameterized query
When SQL is used as a programming language, you need constructs like variables. Such queries are called parameterized queries. The example below updates a record using SQL variables.

```sql
SET @EmpID = 5;
SET @EmpID = 5;
SET @EmpName = 'Aliza John';
SET @Salary = 65000;

INSERT INTO Employees (EmpID, EmpName, Salary)
VALUES (@EmpID, @EmpName, @Salary);

SELECT * FROM Employees
WHERE  EmpID = 5; 
```

The variable can be derived as the result of a query as well, like below:

```sql
SET @match_empid = (SELECT EmpId FROM Employees WHERE EmpName = "Sarah R");

UPDATE Employees SET Salary = 55000 WHERE EmpId = @match_empid;
```

## `AS` SQL Alias operator
You can use `AS` to create alias to a **column** or a **table**. Alias live only for the duration of the query and are not persisted.

```sql
/* Column alias */
SELECT ColumnName AS ColAlias
FROM   TableName;

/* Column alias with space */
SELECT ColumnName AS "Col Alias"
FROM   TableName;

/* Table alias */
SELECT t.ColumnName
FROM   TableName AS t;

/* Table alias without using AS */
SELECT t.ColumnName
FROM   TableName t;
```

## If-Else like conditional execution - SQL `CASE`
Use the `CASE` statement to create an if-else conditional logic.

```sql
/*SQL command using CASE to calculate total marks in subject Mathematics */
SELECT SUM(CASE WHEN Subject = 'Mathematics' THEN Marks ELSE 0 END) AS TotalMarksMaths
FROM   StudentGrades;

/*functionally equivalent to */
SELECT SUM(Marks) FROM StuendGrades WHERE Subject = 'Mathematics';
```