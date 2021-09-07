Title: Deep Learning on imagery using `fastai.vision` module

## List of relevant functions and classes
 
### Getting sample data
 - `fastai.datasets` contains a set of curated datasets that sits on S3. You can get the list from `fastai.datasets.URLs`
 - `URLs.PETS` for example will return the download URL.
 - `fastai.datasets.untar_data()` will download to a `.fastai/data` folder under local user data and will return that path as a `Pathlib.Path` object

### Loading image data
 - `fastai.vision.data.get_image_files()` will scan a directory of image files and return a list of `Path` objects.
 - The next step is to create an **`ImageDataBunch`** instance. In FastAI, `DataBunch` objects form the main way to represent and hold training and test datasets.
 - **`fastai.vision.data.ImageDataBunch.from_name_re()`** is a static, factory method allows you to construct an `ImageDataBunch` and while doing that, it can extract labels from file names. It accepts a Python Regular Expression syntax for this. You also feed it with transformations, size to resize and batch size the GPU can handle.
 - `fastai.vision.transform.get_transforms()` is a utility func that is used to specify and get back a list of transformation that need to applied on the DataBunch object.
 - The `from_name_re()` will split the data into training and validation sets. These can be accessed via `data.valid_ds` and `data.train_ds` where, `data` is instance of `ImageDataBunch`.
 - `data.show_batch()` can be used to display training data in a notebook.
 - `data.classes` will return the label classes it has parsed using the regular expression earlier.
 - `data.batch_size` shows the batch size configured

### Training
 - `fastai.vision.models` module can list all models that are supported. For instance, `[mdl for mdl in dir(fastai.vision.models) if '__' not in mdl]` list comp will return `40` such models as of 2021.
 - `fastai.metrics.error_rate()` is a type of loss function, we use in training on images
 - **`fastai.vision.learner.cnn_learner()`** is a static, factory method that creates a convolutional neural network based on the backbone and loss function specified. For instance, `learn = cnn_learner(data, models.resnet34, metrics=error_rate)`.
    - Note, when creating the learner, you pass the whole data bunch - including both training and test data.
    - The error_rate function will help in evaluating the performance on both the training data as well as the validation data.
 - **`learn.fit_one_cycle(cyc_len=4)`** is used to train the restnet34 model. The cycle length parameter determines how many times to repeat the one cycle learning. The output of this cell shows the following:

```
epoch 	train_loss 	valid_loss 	error_rate 	time
0   	1.361700 	0.337071 	0.104195 	02:24
1 	    0.601790 	0.297722 	0.089310 	02:07
2 	    0.380089 	0.282888 	0.079838 	02:26
3 	    0.271350 	0.246164 	0.071719 	02:07

Wall time: 9min 6s
```

 - The output above shows at end of epoch 4, we have an error rate of `0.071` which means about `92.9%` accuracy.
