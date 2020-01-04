Title: Deep Learning

## Prologue
GPUs are required to learn DL, this far seems clear. But why you ask.. [read this for more](https://www.fast.ai/2017/11/16/what-you-need/). At a high level, GPUs by Nvidia is optimal for DL as most libraries support this hardware. `CUDA` prog language developed by Nvidia is also the most developed in terms of features.

#### DL Libraries in the market
The libraries for DL come and go; `theano`, `caffe` to name a few. `fastai` library is built on top of `pyTorch` from Facebook. Why pyTorch you ask, Rachel reasons that "the speed at which programmers can experiment and iterate is more important than theoretical speedps". Hence pytorch which supports dynamic computation. **Dynamic computation** means the program is executed in the order you wrote it. Contrast this with **static computation** where you define the architecture of neural net and run code on it. Tensorflow famously uses static computation, but announced support for dynamic computation recently.

#### Uncommon wisdom
 - You don't need GPU in production. Rachel writes about a number of reasons why this is the case. Even if you need to train your model every day.
 - You don't need to be an expert in Math
 - You don't need to be an expert programmer. Knowing the above two will certainly help.
 - You don't need massive datasets... hold on. With techniques like transfer learning, data augmentation make it easy to take a pre-trained model and apply it to your problem.

## Setup - Google Colab, the free GPU notebook service
Google colab at this point lacks an interface to see what notebooks you have and the interface to import notebooks from GitHub and other sources is hidden somewhere deep. 

However, once you open, you need to run `!curl -s https://course.fast.ai/setup/colab | bash` to prepare the colab runtime to use Fast.ai and GPU. After this, you can run fastai course materials for free on GPU. THere are some notes about GPU availability, but this is yet to be seen by me.

## Detailed notes
 - [Neural network - concepts](coursera-neural-nets-concepts/)
 - [Deep learning concepts](dl-concepts/)
 - [Getting started with fast.ai](fastai/fastai-1/)
 - [Fast.ai course lesson 1 - classifying pets](fastai/lesson1-pets/)
 	- [lesson 1 mind map](/images/fastai-lesson1-mindmap.png) courtesy of Fast.ai community members.