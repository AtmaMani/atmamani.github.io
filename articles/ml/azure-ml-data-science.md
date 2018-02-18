# Building data science projects using Azure-ML stack
This wiki covers the steps involved in building a data science project using Azure Machine Learning Workbench product. This also covers the steps involved in productionizing the model as a web service and accessing it over HTTP using its REST API.

**ToC**
<!-- MarkdownTOC -->

- [What is Azure ML Workbench](#what-is-azure-ml-workbench)
	- [Runtime environments](#runtime-environments)

<!-- /MarkdownTOC -->

## What is Azure ML Workbench
Azure ML provides a cloud infrastructure to turn your machine learning projects into production code with the scalability and availability of its cloud infrastructure. As of this blog, Azure itself does not have ML as Service, but it allows you to turn your projects into one.

The Workbench is a **desktop application + Python libraries** with which you build your ML experiments, taking it from data cleaning, model building to refinement. It provides frameworks to 
 
 - access datasets
 - build models with defined inputs and outputs
 - refine models by tuning hyperparameters and export model parameters and learning artifacts

The Workbench has a **run history** that allows you to visualize the run results as a time-series and helps you visualize the effects of each run.

### Runtime environments
The Workbench supports at-least 3 different runtimes.
 
 - `local` - This is your local anaconda Python environment (or R env)
 - `docker-python` - This encapsulates the `local` environment as a Docker container and runs it with this container
 - `docker-pyspark` - similar, but is useful for distributed computation using Spark.
