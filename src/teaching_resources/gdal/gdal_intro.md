title: GDAL an Introduction

Course link: https://courses.spatialthoughts.com/gdal-tools.html

[GDAL](https://www.gdal.org) is a FOSS4G library for raster and vector geospatial data IO and manipulation. GDAL is usually the foundational library behind several desktop applications such as ArcGIS, QGIS, Google Earth etc.

## Installation
GDAL is a binary CLI. As such, it can be installed using `conda` or `mamba`

```bash
$ micromamba install -c conda-forge gdal

# Verify
(stac) ➜  gis_data gdalinfo --version
GDAL 3.5.3, released 2022/10/21
```

## Clif notes

- gdal vs ogr
- gdalinfo
- gdalinfo stats
- virtual raster