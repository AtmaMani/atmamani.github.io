title: Mamba cheat sheet

## Introduction
**What is mamba**: Mamba is a package and environment for Python. It is similar to Conda, but uses a C++ solver that is much faster. It can pick packages from regular Conda channels. It's syntax mirrors that of Conda quite closely.

**Installation**: You can install micromamba by itself, say in a Docker image. But on regular workstations, you first install Conda, then install mamba in the base env using `brew`

```
brew install --cask micromamba
```
Then, enable shell completion:
```
micromamba shell completion
source ~/.zshrc
```

## Operations
**Creating new env**:
```
micromamba create -n <name of env> <pkg list>
micromamba create -n stac jupyterlab
```
You will notice the resolution time is pretty fast and so is the speed of installs. The shell returns an output like so:

```bash

                                           __
          __  ______ ___  ____ _____ ___  / /_  ____ _
         / / / / __ `__ \/ __ `/ __ `__ \/ __ \/ __ `/
        / /_/ / / / / / / /_/ / / / / / / /_/ / /_/ /
       / .___/_/ /_/ /_/\__,_/_/ /_/ /_/_.___/\__,_/
      /_/

warning  libmamba 'root_prefix' set with default value: /Users/abharathi/micromamba
conda-forge/osx-arm64                                4.0MB @   3.0MB/s  1.5s
conda-forge/noarch                                  10.1MB @   3.9MB/s  2.9s

Transaction

  Prefix: /Users/abharathi/micromamba/envs/stac

  Updating specs:

   - jupyterlab


  Package                              Version  Build               Channel                    Size
─────────────────────────────────────────────────────────────────────────────────────────────────────
  Install:
─────────────────────────────────────────────────────────────────────────────────────────────────────

  + anyio                                3.6.2  pyhd8ed1ab_0        conda-forge/noarch         85kB
```

**Listing and Activating env**:
You can use regular `conda` to activate the env:

```
micromamba env list
micromamba activate <env name>
```

**Installing packages**
Once activated, then use the `micromamba install <pkg>` syntax, similar to conda.

```
micromamba install -c <channel> <pkg_name> -y
```