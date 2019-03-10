# This is PostGIS
## Set up
### Installation
I am installing the all-in-one package - Postgres APP which inclues Postgres, PostGIS, PLV8. Once installed, it looks like below:

![](img/postgresql-1.jpg)

I am following the [tutorial from here](https://postgis.net/workshops/postgis-intro/)

Note: There is an alternate download called 'OpenGeo Suite', but this is no longer in active development. It may have been acquired by boundless and now it does not resemble its original suite of products. Instead, I am installing [pgadmin](https://www.pgadmin.org/download/) to admin the DB. The new pgAdmin4 is a complete rewrite. It is web based, written in Python, Qt, JS and core components in C++.

Once you install both the Postgres database and PgAdmin4 app, start both, connect to the database server using `localhost:5432` port (which you can look up from properties of db server). PgAdmin will now list the databases. Below is an image of the pgAdmin window running SQL queries on a custom DB I created.

![](img/pgAdmin-1.jpg)

## Introduction
PostGIS is a spatial database. It turns PostgreSQL database into a spatial database. PostGIS inherits all enterprise functionality of PostgreSQL. There are 3 aspects that make a database spatial
 - **spatial data types** - store shapes as points ,lines, polygons. They abstract and encapsulate spatial structures such as boundary, dimension.
 - **spatial indexing** - for efficient spatial operations
 - **spatial functions** - exposed in SQL for querying spatial properties and relationships. Eg: answers which objects are within this particular envelope.

True spatial databases treat spatial features as first class database objs. Spatial DBs are used not just in geospatial env, but to store data related to anatomy of human body, large-scale integrated circuits, molecular structures, EMF etc.

More about **Spatial index**: Bounding boxes are used for spatial containment queries. Computing containment for polygons is very computationally intensive, hence it is performed over their respective bounding boxes. Computing this for rectangles is very simple and fast.

More about **spatial functions**: 5 main categories of spatial functions
- **conversion** of geometries
- **management** of spatial tables, PostGIS administration
- **retrieval** of properties and measurements of geometries
- **comparison** of geometries, wrt spatial relationship
- **generation** of new geometries.

**Notes**: The PostGIS team outlines their reason behind choosing PostgreSQL as the foundation and not some other popular open source ORDBMS like mySQL.

### History of PostGIS
Started in May of 2001. For many years, the functionality, power and ease of use was limited. **MapServer** became the first app to provide visualization of PostGIS. Later, another open source initiative **GOES** (Geometry Engine, Open Source) was integrated with PostGIS to make it complete

## Tutorial
Follow tutorial from [postgis-intro](https://postgis.net/workshops/postgis-intro)

1. To enable postGIS, run `CREATE EXTENSION postgis;`. Run by hitting `F5`. Then confirm it is installed by running `SELECT postgis_full_version();`
2. To import data into postGIS, the tool `shp2pgis` extension does not seem available. Hence I did the import using QGIS. You can connect to the postGIS from qGIS using the same database server, port, db name. Then install the **DB Admin** QGIS extension to manage postGIS. The db manager looks like below:
   ![](img/qgis-to-postgis.jpg)

Once imported, you can query for the features from pgAdmin and also visualize the results like below:
![](img/postgis-query.jpg)