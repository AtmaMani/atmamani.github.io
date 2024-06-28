# How to build this site
This site is built using `mkdocs`, `mkdocs-jupyter` frameworks. Source is written in Jupyter Notebooks and in Markdown files. Plugins such as `mathjax` convert `LaTex` code into beautiful equations and math notations. Theming is using `mkdocs-material`. 

## Useful links
 - https://www.mkdocs.org/getting-started/
 - https://github.com/danielfrg/mkdocs-jupyter

## Set up instructions
### Environment & deps

```bash
micromamba env create -n mkdocs python=3.12 -c conda-forge

micromamba activate mkdocs

pip install mkdocs
pip install mkdocs-jupyter
pip install mkdocs-material
```

### Running the dev server
Use `mkdocs serve` to load server on [https://localhost:8000](https://localhost:8000). The server will auto reload on every save / update.

```bash
micromamba activate mkdocs
cd atmamani.github.io
mkdocs serve
```

### Building and deploying
The source code for the site is under `src` folder. The built output is in `docs` folder. This is set up so, to work better with GitHub User pages. So, to build run

```bash
cd atmamani.github.io
mkdocs build --site-dir docs
```

Then `add` and `commit` both the folders (the entire repo) and push to `master` branch. GitHub will take care of the rest.