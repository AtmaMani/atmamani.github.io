# Deep Learning

## Prologue
GPUs are required to learn DL, this far seems clear. But why you ask.. [read this for more](https://www.fast.ai/2017/11/16/what-you-need/). At a high level, GPUs by Nvidia is optimal for DL as most libraries support this hardware. `CUDA` prog language developed by Nvidia is also the most developed in terms of features.

#### DL Libraries in the market
The libraries for DL come and go; `theano`, `caffe` to name a few. `fastai` library is built on top of `pyTorch` from Facebook. Why pyTorch you ask, Rachel reasons that "the speed at which programmers can experiment and iterate is more important than theoretical speedps". Hence pytorch which supports dynamic computation. **Dynamic computation** means the program is executed in the order you wrote it. Contrast this with **static computation** where you define the architecture of neural net and run code on it. Tensorflow famously uses static computation, but announced support for dynamic computation recently.

#### Uncommon wisdom
 - You don't need GPU in production. Rachel writes about a number of reasons why this is the case. Even if you need to train your model every day.
 - You don't need to be an expert in Math
 - You don't need to be an expert programmer. Knowing the above two will certainly help.
 - You don't need massive datasets... hold on. With techniques like transfer learning, data augmentation make it easy to take a pre-trained model and apply it to your problem.