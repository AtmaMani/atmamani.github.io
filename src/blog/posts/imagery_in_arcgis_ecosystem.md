---
date: 2018-03-30
category:
  - arcgis
  - esri
slug: imagery-in-arcgis-ecosystem
---
# Imagery in ArcGIS ecosystem
ArcGIS apps give you access to work imagery data from a variety of file formats. The goal is to unify the differences in image characteristics (spatial, spectral, temportal resolutions), file formats (local - different types of image formats, mosaic and web). However, it is useful to understand the basics. This page does not teach you remote sensing or spatial analysis, it just gives you a roadmap to navigate the software.

<!-- more -->

## File formats
ArcGIS with the help of GDAL system, supports over 400 file formats. ArcGIS Pro extends this support by giving you templates for common imagery providers and satellite/aerial platforms. Thus you can access imagery from
 - local file on disk (.tiff, .img, .fgdb raster etc)
 - local file from mosaic dataset (a collection of images)
 - from an Image service (consider this as a mosaic dataset served over HTTP).

## ArcGIS Imagery products and terms
### Mosaic dataset
You can create a MD inside your fgdb, then add rasters to it. During this process, you can choose templates to adapt it for different types of satellite images. During this step, you will build `pyramids` which build tiles for different scales for display purposes and you will build `overviews` which or low resolution snapshots of the images for viewing them at full extent.

A MD consists of 
 - boundary - extent of all images (union)
 - footprint - extent of individual images
 - image - images with data

A MD is like a catalog of all relevant images. MD is highly scalable, you can dynamically change the mosaic order. 

### Raster Products
This is a virtual product. For well known satellite images, Pro will dynamically create a new file in the `catalog`\`project` pane that appears to be a composite of all the bands. This is virtual, but can be used like a regular file on disk within Pro. If you expand, you will notice some commonly used band combinations and specific names for those (like cloud, water, vegetation, soil cover etc.)