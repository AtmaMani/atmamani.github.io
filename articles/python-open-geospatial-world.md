# A short tour of Open Geospatial Tools of the scientific Python ecosystem
One of my favorite statistics is that about 80% of data in the world, contain some element that is spatial. For instance, take the list of gas stations in a city or restaurants in a city, revenue from medical industry, there is always some element of this data that can be categorized as being spatial - be it locations, routes the products take, cost variations in gas prices etc.

This spatial relationship is of significant interest to me and I have been analyzing them for over a decade and have been building software to analyze them for more than half of the past decade. While majority of what I built were proprietary, this blog is a look at what is available in the open-source ecosystem and when to use which tool.

Something that is common and beautiful about the opensource Python data analysis ecosystem is, a number of these libraries have self-organized themselves around a common platform or standard of interoperability. You will find many libraries interchangeably using each other for parts they are good at, emphasizing the 'dont reinvent the wheel' philosophy. For then end user, even though the number of libraries is large, it is possible to mark a clear boundary of what lib does what functionality and why it is needed.

This blog is just a high level overview to navigate this python-open-geospatial community and packages. For any details, refer to my [cheatsheets](/cheatsheets/index.html).

## Data IO
**Fiona** is a **[GDAL](http://www.gdal.org/)** Python wrapper and is for reading vector data. Fiona is written to be a clean Pythonic wrapper at the cost of performance and memory usage.

An alternate is **[PyShape](https://github.com/GeospatialPython/pyshp)** which reads and writes Esri Shape files in **pure Python** vs Fiona which is a GDAL wrapper for libs in C.

## Geometry and projection engines
**[Geopandas](http://geopandas.org/)** provides a spatial extension to the famous [pandas](http://pandas.pydata.org/) library. It uses [shapely](http://toblerity.github.io/shapely) for **geometry**, [fiona](http://toblerity.github.io/fiona) for reading vector data, [descartes](https://pypi.python.org/pypi/descartes) and matplotlib ofr plotting. Geopandas allows spatial operations that would otherwise require **PostGIS**.

**Shapely** is a Python package for manipulation and analysis of geometries. Shapely cannot IO datasets, but can help in projections. Shapely is a Pythonic wrapper to [GEOS](https://trac.osgeo.org/geos/) (Geometry Engine, Open Source), which in turn is a `C++` port of [Java Topology Suite](https://trac.osgeo.org/geos/). You can already see a heavy re-use of libraries.

### Spatial indexing


## Data wrangling
Geopandas supports pretty much all data wrangling provided by pandas. Thus you can treat it as a regular data frame and work with its non-spatial columns.

## Visualization
**Descartes** uses Shapely to convert them to matplotlib paths and patches. Thus it uses matplotlib for plotting geometries.

**Folium** uses Leaflet.js to plot an interactive map on the Jupyter notebook. It is pretty slick and looks great. Folium, in its current release does not seem to support reading Geopandas dataframes. You need to serialize it to a GeoJSON and then add it to the map. Although this can happen in memory, it may become problematic for large datasets. Another option to look into is **IpyLeaflet**.

## Sharing - web GIS


## Spatial analysis
**Geopandas** allows for basic overlay and set operations. You can do
 - intersection, 
 - union, 
 - symmetrical difference, 
 - difference, 
 - buffer
 - dissolve
 - attribute and spatial joins
 - geocoding using google, bing, googlev3, yahoo, mapquest, openmapquest.


## Conclusion
By no means this is an exhaustive list, and that is the beauty of open source ecosystem. There are parallel efforts around the world to improve existing packages and building simpler and more powerful packages. Here is a blog that lists [a few more packages](https://automating-gis-processes.github.io/CSC18/lessons/L1/Intro-Python-GIS.html#what-tools-are-available-for-doing-gis-in-pure-python) for Python geospatial work.

**Learning resources**
 - [Geohackweek](https://geohackweek.github.io/) has a nice tutorial for vector, raster data processing using open source Python packages.
 - [Python GIS course by Henrikki Tenkanen](https://automating-gis-processes.github.io/CSC18/index.html)