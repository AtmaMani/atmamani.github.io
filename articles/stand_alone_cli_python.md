# Building stand-alone command line tools using Python

You have built a neat little tool using Python. Following modern software building paradigms, you built your tool to be composable, used FOSS libraries, conda packages, etc. Now you are ready to ship and you face the dilemma of whether to package it as a conda package or PyPI package or whether to send it as a GitHub repository. What if your user does not want to even install Python on their computer?

Fear not, you can build truly self-contained stand-alone applications using [PyInstaller](https://pyinstaller.readthedocs.io). The rest of this blog walks you through an example.