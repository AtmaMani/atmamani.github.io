title: Understanding backpropagation in neural networks
has_math: true

This page talks about the formula, intuition and the mechanics of the backpropagation optimization function. 

A neural network is composed of several layers of neurons connected to one another. Each neuron is activated when the sum of weights multiplied by the values of the neurons in previous layer is over a threshold when you pass it through a sigmoid / logit function. The threshold is usually `0.5`. In order for a neural network to get trained, the weights of all the different neurons need to be adjusted to yield the minimal loss. **Backpropagation** is the process by which the weights are adjusted during the training process. To understand how this works, we need to understand how to calculate the **loss/cost function** of a neural network.

## Cost function of a neural network
The cost function of a NN builds on the cost function of a logistic regression. Recall from [Logistic regression page](/projects/ml/coursera-logistic-reg/), the cost function of a logistic regression is

$$
J(\theta) = -\frac{1}{m}\left[\sum_{i=1}^{m}y^{(i)}log(h_{\theta}(x^{(i)})) + (1-y^{(i)})log(1-h_{\theta}(x^{(i)}))\right] + \frac{\lambda}{2m}\sum_{j=1}^{n}\theta_{j}^{2}
$$

where $m$ is number of training samples and $n$ is number of parameters.

A neural network is like a multi-class logistic regression. Thus, we need to sum over $K$ classes. In reality, $K$ refers to the number of nodes in the output layer. Thus, in binary classification, although the number of classes is `2`, the number of nodes in output layer is just `1`. Thus `K=1`. The cost function is given as

<img src="/images/coursera-neural-nets-backprop1.png" width=500>

where 

 - $m$ is number of training samples. $i=1\;to\;m$
 - $K$ is number of nodes in output layer and $k=1 \; to \; K$
 - $L$ is number of layers in the network and $l=1 \; to \; L-1$ as we exclude the input layer
 - $s_{l}$ is number of nodes in a given layer $l$ and in the penalty term, $i=1 \; to \; s_{l}$ and $j=1 \; to \; s_{l+1}$ `j` and `i` represent the rows and columns of the cost matrix for each layer.

The $\Theta$ (weight) matrix is 2D for each layer. When you stack all layers together, it becomes a 3D matrix.

## Backpropagation
The objective of backpropagation is to minimize the cost function described above using partial derivatives. For each training sample, we compute an error matrix, which reflects the difference between predicted and output values. It is straightforward to compute the error for the last layer, which is the difference between expected and predicted outputs. Progressively, we compute the error for each of the previous layers.

Let us start by reviewing the steps in forward propagation. The vectorized implementation of it is given in the slide below:

<img src='/images/coursera-neural-nets-backprop2.png' width=500>

Next, we start by computing the error in the last layer. 

$$
\delta_{j}^{(4)} = a_{j}^{(4)} - y_{j}
$$$$
in \; vectorized \; terms
$$$$
\delta^{(4)} = a^{(4)} - y
$$


The error vector is now simply the difference between the expected and predicted vectors. We can compute the delta terms for the earlier layers of the network as follows:

$$
\delta^{(3)} = (\Theta^{(3)})^{T}\delta^{(4)}.*g'(z^{(3)})
$$
and so on..

We don't calculate error for layer 1. Thus no $\delta^{(1)}$. The equations above give the formulae to calculate error for one training sample. When calculating the backprop for many training samples, we first perform forward propagation, compute the weights, then immediately, perform backprop to calculate the error terms and update the weights immediately. Next, we proceed to the next training sample.

<img src='/images/coursera-neural-nets-backprop3.png' width=500>

The figure above shows the vectorized implementations of calculating the error term for all samples as a 2D matrix $\Delta_{ij}^{(l)}$.

### Backpropagation Intuition
Consider the following example of a simple neural net.

<img src='/images/coursera-neural-nets-backprop4.png' width=500>

The error term for last layer is calculated as $\delta_{1}^{(4)} = y^{(i)} - a_{1}^{(4)}$. Then, the error term for previous layers is given by

$$
\delta_{1}^{(3)} = \Theta_{1,1}^{(3)}\delta_{1}^{(4)}
$$
$$
\delta_{2}^{(3)} = \Theta_{1,2}^{(3)}\delta_{1}^{(4)}
$$

Similarly, for the previous layer,
$$
\delta_{1}^{(2)} = \Theta_{1,1}^{(2)}\delta_{1}^{(3)} + \Theta_{2,1}^{(2)}\delta_{2}^{(3)}
$$

Thus, to calculate the errors in each of the nodes, we need to errors in the terms to the right. In other words, we calculate the error terms from the right to the left, in reverse of the network direction, thus the name backpropagation (of errors).