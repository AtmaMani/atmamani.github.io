Title: Set up Windows OS for Fastai v2

## Preparation - Set up GPU drivers

Follow the instructions in [Configure GPU on windows](../configure-gpu-windows) page first.

## Install Fastai v2.
**What did not work:**
 - The **Fastbook** install instructions don't work as the automatic Pip install steps fail. Manually running Pip install also results in conflicts.
 - Running `conda install -c fastchan fastai` will not resolve as conda satsolver takes forever without results.

**What worked**:
 - Install Anaconda individual edition
 - Create a new env: `conda create -n fastaiv2` without any packages. This provides conda a fresh start and makes it easy for the solver
 - Then run `conda install -c fastai -c pytorch fastai` to install all fastaiv2 and all of its dependencies.
 - If you want to run the notebooks, then run `conda install jupyter` to install Jupyter
 - **Optional**: Clone the v2 book repo: https://github.com/fastai/fastbook
 - Run `pip install -U fastbook` to install the book's deps and files on disk.


## Verify GPU is picked up
From terminal or Notebook, run the following

```python
import torch
torch.cuda.is_available()
```
If you get a `True`, you are good to go. Else revisit the config doc page listed above.


## Verify FastAI v2 can be imported
Run the quickstart example from the book (or copy below):

```python
from fastai.vision.all import *
path = untar_data(URLs.PETS)/'images'

def is_cat(x): return x[0].isupper()
dls = ImageDataLoaders.from_name_func(
    path, get_image_files(path), valid_pct=0.2, seed=42,
    label_func=is_cat, item_tfms=Resize(224))

learn = cnn_learner(dls, resnet34, metrics=error_rate)
learn.fine_tune(1)
```

As you run the above, open the Task Manager and monitor the GPU usage. You should see a spike while the CPU rate seems constant. The training should go much faster. Instead if you notice CPU peaking to 95-100%, then verify if `torch.cuda.is_available()` returns `True`. If it does not, then recheck the driver and OS version steps from above.

Congrats! You are all set to use fastaiv2 on Windows OS without needing a dual boot for Linux or installing the Windows subsystem for linux options.



