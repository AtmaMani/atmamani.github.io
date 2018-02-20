# Building data science projects using Azure-ML stack
This wiki covers the steps involved in building a data science project using Azure Machine Learning Workbench product. This also covers the steps involved in productionizing the model as a web service and accessing it over HTTP using its REST API.

**ToC**
<!-- MarkdownTOC -->

- [Azure ML Workbench](#azure-ml-workbench)
	- [Runtime environments](#runtime-environments)
	- [Deployment environments](#deployment-environments)
- [Azure ML portal](#azure-ml-portal)
- [Walk through](#walk-through)
	- [Initialization](#initialization)
	- [Model development](#model-development)
		- [Notes](#notes)

<!-- /MarkdownTOC -->

Azure ML consists of two major parts
 - Azure ML portal
 - Azure ML Workbench

## Azure ML Workbench
Azure ML provides a cloud infrastructure to turn your machine learning projects into production code with the scalability and availability of its cloud infrastructure. As of this blog, Azure itself does not have ML as Service, but it allows you to turn your projects into one.

The Workbench is a **desktop application + Python libraries** with which you build your ML experiments, taking it from data cleaning, model building to refinement. It provides frameworks to 
 
 - access datasets
 - build models with defined inputs and outputs
 - refine models by tuning hyperparameters and export model parameters and learning artifacts

The Workbench has a **run history** that allows you to visualize the run results as a time-series and helps you visualize the effects of each run.

### Runtime environments
The Workbench supports at-least 3 different runtimes.
 
 - `local` - This is your local anaconda Python environment (or R env)
 - `docker-python` - This encapsulates the `local` environment as a Docker container and runs it with this container. This container could run locally, on host OS, or can run on a remote machine as well (such as a VM or HDInsights cluster).
 - `docker-pyspark` - similar, but is useful for distributed computation using Spark.

### Deployment environments
The output from Workbench is your Docker image. Azure ML helps you to deploy this image on **Azure Container Services** and get a `REST` API for predictions and inference during production.

The ML model consists of 
 - model file (or dir of such files)
 - Python file implementing model scoring function
 - Conda dependency file (.yml)
 - runtime environment file
 - schema file for REST API parameters
 - manifest file (auto generated) for building Docker image

![schematic](https://docs.microsoft.com/en-us/azure/machine-learning/preview/media/model-management-overview/modelmanagement.png)

Azure ML Model Management console allows your register and track your models like a version control system.

## Azure ML portal
[Azure dashboard](https://portal.azure.com/) contains all Azure sub products, including the ML services. Sign in with free Outlook account or Office 365 account and you get `$200` in free credits.

In the console, search for [Machine learning experimentation](https://portal.azure.com/#blade/HubsExtension/Resources/resourceType/Microsoft.MachineLearningExperimentation) (which is in preview at the time of this article). This service / dashboard provides an environment for the rest of this article.

## Walk through
An important process is to write the Python code (in scripts and notebooks) by using **`azureml` Python library** for data access, logging and printing. This is the hook for the Workbench UX to interpret model refinement and display them in the dashboard.

### Initialization
 1. Log into the ML portal, create a new experiment. [Help image](https://docs.microsoft.com/en-us/azure/machine-learning/preview/media/quickstart-installation/portal-create-experimentation.png)
 2. Install Workbench. Note: You need macOS, Win 10 or higher for Docker to run. Then sign into the workbench using the same account. Your experimentation account shows up on Workbench. [Help image](https://docs.microsoft.com/en-us/azure/machine-learning/preview/media/quickstart-installation/run_view.png)
 3. Create a new project, pick from a template if necessary. [Help image](https://docs.microsoft.com/en-us/azure/machine-learning/preview/media/tutorial-classifying-iris/new_project.png)

### Model development
Your Azure ML projects are primarily `git` repositories. When you open an existing template project, the `home` tab renders the `readme.md` file.

 1. **Add datasets** - Click on the data tab and plus sign. Use wizard to add data sources. If data is tabular, the Workbench attempts to display it as a table and provide some preliminary statistics.

ML Workbench wants to keep a record of all your EDA and data wrangling steps, to aid reproducibility. Hence it stores a `.dsource` to record how data is input and a `.dprep` to record the transformations performed on the data.

 2. A `.dsource` file gets created that contains connections to your dataset and how your file is read.

 3. Any data preparation performed by using the built-in **prepare** tool is stored in `.dprep` file.

At any time, you can do the same actions in Python, or turn the UX actions into Python code by right clicking the `.dprep` or `.dsource` file and generating code file. The sample code that reads from `.dsource` and returns a pandas DataFrame is below. Script proceeds to run data preparation using `.dprep` file.

```python
from azureml.dataprep import datasource
from azureml.dataprep import package

df = datasource.load_datasource('iris.dsource')
# df.head(10)

# column-prep.dprep is my data prep file name.
df = package.run('column-prep.dprep', dataflow_idx=0)
df.head(10)
```

 4. Serialize your model and its weights using `pickle` library
```python
with open('./outputs/model.pkl', 'wb') as mh:
	pickle.dump(classifier, mh)
```

 5. Save your plots as `.png` files into the `./outputs` folder. The Workbench picks this up automatically. For each run, the Workbench stores the outputs within the run numbered folder. From the run dashboard, you can download a file later for any run.

 6. Choose runtime as `docker-python`. The Docker base image is specified in the `aml_config/docker.compute` and run configurations, Python dependencies in `docker-python.runconfig` files. Workbench first builds a Docker image from base image, installs dependencies and then runs the file.

#### Notes
 - It appears that using Workbench UX to read and clean data into DataFrames is optional. You can as well do all in Python in standard way and create a DF from a .csv file.
 - You accept script parameters as **command line arguments**. The Workbench UX provides a generic args text box into which you can type the values when running from UX.
 - The text you want persisted in the logs should be sent to Azure ML logger

```python
from azureml.logging import get_azureml_logger
run_logger = get_azureml_logger()

run_logger.log('text')
```
 
 - Write your scripts such that there is `1` main Python file which in turn calls other files that are necessary.

 - `control_log` file contains the running log of the job with details injected by Workbench
 - `driver_log` file contains the print statements
 
--------------------------------------------------------------------------------
**Sources**
 - [Azure ML help](https://docs.microsoft.com/en-us/azure/machine-learning/preview)