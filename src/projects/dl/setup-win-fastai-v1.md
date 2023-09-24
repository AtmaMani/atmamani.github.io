Title: Set up Windows OS for Fastai v1

## Preparation - Set up GPU drivers

Follow the instructions in [Configure GPU on windows](../configure-gpu-windows) page first.

## Install Fastai v1

The steps to install v1 of Fastai is made simpler if you use the **ArcGIS Deep Learning Essentials** conda meta package. The steps are, from your terminal / Anaconda bash run

```cmd
conda create env -n agslearn python=3.8
conda activate agslearn

conda install -c esri arcgis_learn
```

The [`ags_learn` conda meta-package](https://anaconda.org/Esri/arcgis_learn) contains a list of all necessary Fastai and related libs for making Deep Learning and Geospatial deep learning possible on Windows and Linux.

## Verify GPU is picked up
From terminal or Notebook, run the following

```python
import torch
torch.cuda.is_available()
```
If you get a `True`, you are good to go. Else revisit the config doc page listed above.

Additionally, you can time how long it takes between CPU and GPU to run the same compute operation:

```python
import torch
t_cpu = torch.rand(800,800,800)  # uses CPU
%timeit t_cpu @ t_cpu

>>> 4.29 s ± 778 ms per loop (mean ± std. dev. of 7 runs, 1 loop each)

import torch
t_gpu = torch.rand(800,800,800).cuda()  # uses GPU
%timeit t_gpu @ t_gpu

>>> 56.7 µs ± 13.7 µs per loop (mean ± std. dev. of 7 runs, 1 loop each)
```