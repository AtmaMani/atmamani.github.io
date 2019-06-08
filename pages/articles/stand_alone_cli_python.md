# Building stand-alone command line tools using Python

You have built a neat little tool using Python. Following modern software building paradigms, you built your tool to be user friendly, used a number of FOSS libraries instead of reinventing the wheel, etc. Now you are ready to ship and you face the dilemma of whether to package it as a conda package or PyPI package or whether to send it as a GitHub repository. What if your user does not want to even install Python on their computer?

Fear not, you can build truly self-contained stand-alone applications using [PyInstaller](https://pyinstaller.readthedocs.io). The rest of this blog walks you through an example.

## What is PyInstaller
From PyInstaller's page: 
	PyInstaller bundles a Python application and all its dependencies into a single package. The user can run the packaged app without installing a Python interpreter or any modules. PyInstaller supports Python 2.7 and Python 3.3+, and correctly bundles the major Python packages such as numpy, PyQt, Django, wxPython, and others. PyInstaller is tested against Windows, Mac OS X, and Linux.

## How to install PyInstaller
Before using PyInstaller, you need to install it in your active Python environment. If you are not already using, I would highly recommend using `conda` to isolate your various dev environments. You can install [conda from here](https://conda.anaconda.org) and once installed, you can create a new environment using the command below:

```
conda create --name stand_alone_app_project python=3.5
```
Here, I am creating a new environment called `stand_alone_app_project` and installing a Python 3.5 kernel in it. To use this environment, I need to activate it - as shown below
```
source activate stand_alone_app_project
```
Environments are folders at the end of the day and activation pretty much adds the path to this folder to your system path. Activation is transient and is only applicable for the life of that terminal's session. Once activated, install all the packages you need for your script to work. Next, install PyInstaller using PIP (an older package manager for Python)
```
pip install PyInstaller
```

## Building stand-alone applications.
PyInstaller allows you to create apps in two formats - as folder with dependencies and an application or option 2 - is to create a fully packaged single executable file. I prefer the latter as it resembles closely what my end users would want and also allows to run the tool from a flash drive, without any installation. In both cases, you will package a Python runtime and all dependencies.

To build an app and package it into a folder, run
```
pyinstaller your_main_script.py
```
To build it as a single file executable, run
```
pyinstaller your_main_script.py --onefile
```
Upon running this, if there are no errors, PyInstaller creates a `dist` and a `build` folder. You ship the contents of the `dist` to your end users.

### Building for different OS
To build the executable for different OS, you need to run the steps on each OS of choice. I was able to build the same script tool into a Windows `exe` and a Unix `app` for Mac. Since Python is platform independent, doing this was a breeze and the app behaved identical on both platforms.

### Errors and what to do
Your first few times with PyInstaller will be rough. You will run into errors unless you are packaging a `hello world.py` kind of script. In my case, I was packaging a tool that relied on `requests` package and PyInstaller could not understand this package. After a brief search on Stack Exchange, I was able to figure out that I needed to install `urllib3` on Mac to get it working. Similarly, on Windows, I needed to install `pypiwin32`. The latter is true no matter what package you use.

Although PyInstaller aims to recursively parse the `import` statements in your script and all its dependencies to figure out the libraries to package, it might fall short if you are using irregular imports. In such cases, read their appropriately named [When things go wrong](https://pyinstaller.readthedocs.io/en/stable/when-things-go-wrong.html) article.

## Conclusion
Conda and Pip are excellent mechanisms to ship your Python code. Yet, they are suitable if you are building libraries and your audience is fellow developers. However, if you are creating an application for end users, then you need to ship it as an executable. Python still falls short in this area compared to other languages like C++, Java, .NET. We are yet to find an IDE that will build your script into an executable (similar to what visual studio does out of the box since ages). Tools like [py2exe](http://www.py2exe.org/) and [PyInstaller](https://pyinstaller.readthedocs.io/) are great as they attempt to solve this gap. Yet, this is only the beginning and I am sure the Python community would greatly benefit if we can expand this area.

If you are looking for an example project, checkout my command line app at [https://github.com/AtmaMani/vector_style_manager](https://github.com/AtmaMani/vector_style_manager)
