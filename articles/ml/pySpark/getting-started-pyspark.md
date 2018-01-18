# Getting started with PySpark
PySpark library gives you a Python API to read and work with your RDDs in HDFS through Apache spark. This tutorial explains the caveats in installing and getting started with PySpark.

## Installing PySpark, Scala, Java, Spark
[Follow this tutorial](https://medium.com/@josemarcialportilla/getting-spark-python-and-jupyter-notebook-running-on-amazon-ec2-dec599e1c297). The overall steps are

 - get a linux VM ready. It could be an EC2 instance on AWS
 - get SSH ability into this VM
 - install anaconda. **Note**: Spark 2.0.0 cannot work with Python 3.6 and needs 3.5. So you can get a version of anaconda that installs 3.5 by default or you can get a higher version of Spark.
 - change the default system Python to use Anaconda python
 - install pip and `py4j` lib that allows you to run java via Python.
 - download and extract Spark. Here if you get `spark-2.0.0-bin-hadoop2.7.tgz`, then you need Python 3.5 and not higher. I am getting `spark-2.2.1-bin-hadoop2.7.tgz` and it works well. [Spark JIRA issue for reference](https://issues.apache.org/jira/browse/SPARK-19019)

To premanently store the SPARK path store this in the `.bashrc` file on the home dir of the user account

```shell
export PATH="your default path output"

# anaconda bin dir - this replaces default Python to anaconda python
export PATH="/home/USERNAME/anaconda3/bin:$PATH"

# linux uses : for path separators
# now add Spark home to Path and PythonPath
export SPARK_HOME="/home/USERNAME/spark-2.2.1-bin-hadoop2.7"
export PATH=$SPARK_HOME:$PATH
export PYTHONPATH=$SPARK_HOME/python #this adds pyspark to python path.
```

### Scala vs Python
**Advantages of using Scala**
 - concurrency as Scala supports async.
 - Type safety during compile time
 - User Defined Functions (UDF) are more efficient in Scala
 - type safety - Scala is suitable for bigger projects as its hassle free when you are refactoring a large codebase.
 - due to absence of type safety, it does not make sense to with spark Datasets in Python. You can only work with RDD and DataFrames.

**Advantages of using Python**
 - easy to learn and use
 - suitable for ad-hoc and small projects
 - SparkMLib for ML.

**tie points**
 - Spark streaming is equally good in both
 - DataFrames are similar in both

## RDDs, DataFrames, Datasets
For an overview on RDDs, refer [here](the-big-data-ecosystem.html#rdd). RDDs are compile-time type-safe and evaluate lazily. RDDs can slow in non-JVM langs like Python, cannot be optimized by spark. DataFrames are built on top of RDDs and you let Spark figure out how to work with RDDs. Hence DF is optimized. The only downside is compile-time type-safety. To rectify this, Spark built Datasets.

In Spark 2.0, DataFrames and Datasets are merged. Conceptually, if you work with untyped data (as in Python, R), you can use a DataFrame where as if you work in typed languages (Scala), you can work with DataSets.

## Actions and transformations
Transformations create a new dataset. Actions return a value (like a summary statistic). All transformations in Spark are lazy. You can also persist RDDs on disk if you expect to read it later.

When working with Spark, you use lambda functions a lot. Lambda plays well with Spark's motto of lazy evaluations.

### Some Spark commands
 - `rdd.textFile()` to read text files, csv files etc.
 - `rdd.collect()` brings entire RDD to a single machine for processing and displays the result. This is mem intensive and can overwhelm the master if you use it on a large dataset.
 - `rdd.take(n)` on the other hand will only collect and return `n` lines.
 - `rdd.toDF()` to convert RDD to Spark DF
 - `df.first()` and `df.top(n)` also work like take.
 - `df.printSchema()` to list the columns and their types. 
 - You can also use `df.describe().show()` to get summary stats.
 - `df.select('column1','column2').show(m)` to select a couple of columns and show their first m rows.
 - `df.withColumn('colname', transformation_expression)` is the primary way you to update values in a DataFrame column.

### Resources
 * [A tale of 3 Apache Spark APIs - RDDs, DataFrames, Datasets](https://databricks.com/blog/2016/07/14/a-tale-of-three-apache-spark-apis-rdds-dataframes-and-datasets.html)
 * [Datacamp - Apache Spark and Python](https://www.datacamp.com/community/tutorials/apache-spark-python)
 * [Datacamp - Predict CA housing prices using SparkMLib and PySpark](https://www.datacamp.com/community/tutorials/apache-spark-tutorial-machine-learning#install)

