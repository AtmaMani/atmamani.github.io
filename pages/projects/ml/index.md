Title: Machine Learning Projects

Today, we teach machines to learn. Tomorrow, we hope they'd return the favor ;-)

## Getting started

<img src='http://scipy-lectures.org/_images/scikit-learn-logo.png' width=300>

 - [Understanding Scikit-Learn syntax](sklearn-1/)
 - [Understanding Gradient Descent](coursera-gradient-descent/)
 - [A primer on linear algebra](linear-algebra/)
 - [Implementing Gradient descent in Python](gradient-descent-in-python/)
 - [Naive Bayes classification with `sklearn` - a work in progress](sklearn_naive_bayes_classifier/)

----------------------------------------------------
## Generalized linear models
<img src='https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Linear_regression.svg/1280px-Linear_regression.svg.png' width=300>

 - [Linear regression - stat concepts](/projects/stats/islr/03_linear_regression/)
 - [Linear regression with `sklearn` and `statmodels`](sklearn_statmodels_linear_regression/)
 - [Solving multivariate linear regression using Gradient Descent](coursera-gd-multivariate-linear-regression/)
 - [Analytical vs Gradient Descent methods of solving linear regression](coursera-linear-regression-analytical-solution/)
 - [Logistic regression, concepts](coursera-logistic-reg/)


-----------------------------------------------------
## ML at scale with PySpark

<img src='/images/ca-house-price-map.png' width=300>

 - [Getting started with PySpark](pyspark/getting-started-pyspark/)
 - [CA housing price prediction with PySpark](pyspark/spark-ml-ca-housing/)

-----------------------------------------------------
## House hunting the data scientist way

<img src="/images/house-hunting-slide1.jpeg" width=300>

 - [Recording of this talk and the slide deck](/talks/2018-portland-geodev-meetup/)
 - [Technical write up](/blog/house-hunting-the-datascientist-way/)
 - Notebooks: Get my notebooks from: [arcgis-python-api/talks/GeoDevPDX2018](https://github.com/Esri/arcgis-python-api/tree/master/talks/GeoDevPDX2018)
     - [Cleaning data](portland-house-hunting/01_clean-housing-data/)
     - [Exploratory data analysis](portland-house-hunting/02_housing-exploratory-data-analysis/)
     - [Feature engineering - neighboring facilities](portland-house-hunting/03_feature-engineering-neighboring-facilities/)
     - [Feature engineering - batch](portland-house-hunting/04_feature-engineering-neighboring-facilities-batch/)
     - [Ranking properties](portland-house-hunting/05-rank-properties-using-features/)
     - [Building a recommendation engine](portland-house-hunting/06-build-recommendation-engine-scaled/)

--------------------------------------------------------
## Analyzing over a century of global hurricane data

<img src="/images/hurricanes-how-we-did-it.jpg" width=300>

This study showcases applying spatial data science techniques to analyze weather data and impacts of climate change on natural disasters. It is featured as a technology spotlight in the book [GIS for Science](https://www.gisforscience.com/). To get a high level overview of this study and its results, read the [StoryMap webapp](https://geosaurus.maps.arcgis.com/apps/MapSeries/index.html?appid=c69ac5f6f66341aab979d5fadeb7d842). For detailed analysis, read the analysis notebooks below:

- [Part 1: Preparing larger-than-memory hurricane data using Dask and GeoAnalytics](hurricane-dask-analysis/part1_prepare_hurricane_data/)
- [Part 2: EDA on hurricane tracks](hurricane-dask-analysis/part2_explore_hurricane_tracks/)
- [Part 3: Does intensity of hurricanes increase over time?](hurricane-dask-analysis/part3_analyze_hurricane_tracks/)