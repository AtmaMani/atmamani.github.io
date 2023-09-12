title: SQL Problem sets
Derived from: 

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