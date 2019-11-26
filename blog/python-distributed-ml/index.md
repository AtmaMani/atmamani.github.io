title: Python and distributed machine learning
Date: 2019-11-26 10:25
Category: python
Tags: data-science, python, distributed-computing
Slug: python-distributed-ml
Status: draft

In today's computing world, machine learning is hitting a performance block. More and more companies want to run them on-demand, instead of as batch processes and want their ML models to deliver results in real-time. Often, the datasets are big-data. Thus, the ML frameworks that data scientsits learnt (`pandas`, `scikit-learn`, `pyTorch`, `keras`) and know to use don't scale well in this fast production environment or is too cumbersome to implement. This blog explores the approaches the ML, DevOps, HPC industry has arrived at in 2019.

We can broadly categorize the efforts into two buckets depending on processor architecture. Companies that are vested in CPU (such as Intel) have their own solution and companies vested in GPU (such as NVIDIA) have their own solutions. Let us explore them:

## Category 1: distributed CPU processing
Intel has the [BigDL](https://software.intel.com/en-us/articles/bigdl-distributed-deep-learning-on-apache-spark) that allows running DL models on CPUs using a Spark cluster.

## Category 2: distributed GPU processing
NVIDIA has created [RapidsAI](https://rapids.ai/start.html) which allows running end-to-end ML on GPUs. Running DL on NVIDIA GPU is well known. How RapidsAI differs is, it provides GPU optimized versions of most popular traditional ML models that can see termendous speed-ups on GPU infrastrucure. Below are some of the components of Rapids AI.

### cuSpatial
**Summary**: cuSpatial is a Python library that allows you to perform highly performant spatial computations on GPUs. At the moment, it only has about 10 capabilities / tools. When compared with FOSS4G Python libraries, it provides 1000x to 100,000x fold speed improvements on millions of records.

**Details**: [`cuSpatial`](https://github.com/rapidsai/cuspatial) is a `C++` library accelerated on GPUs using NVIDIA `CUDA`, `cuDF` the RAPIDS DataFrame library. It provides GPU acceleration to common spatial, spatio-temporal ops such as point-in-polygon tests, distances, trajectory clustering etc. Speed-ups are in the order of 10x to 10,000x.

<img src="https://miro.medium.com/max/960/1*TwG-HJBJ6zShWtLUV6xYmA.png" width=500>
<center>cuSpatial technology stack</center>

cuSpatial data is laid out as columns in GPU memory for fast data processing using GPU data parallelism. cuSpatial data can seamlessly interoperate with cuDF. Thus, for ETL, users will use cuDF to first clean non-spatial fields and then pass it to cuSpatial for spatial filtering.

The example quoted in the [medium blog](https://medium.com/rapids-ai/releasing-cuspatial-to-accelerate-geospatial-and-spatiotemporal-processing-b686d8b32a9) article explains how cuDF and cuSpatial is used to identify objects in video camera feeds, geolocate the objects from image frame to spatial coordinates for downstream GIS analysis.

cuSpatial allows reading of data from relational formats - CSV, Parquet etc. and GIS formats like shapefiles. It also allows CPU datastructures like NumPy Arrays to flow into GPU data structures in a transparent fashion.
