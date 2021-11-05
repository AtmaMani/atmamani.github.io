Title: Machine Learning Concepts

Machine Learning (ML) is the art and science of teaching machines with large amounts of data to perform a given task. Unlike typical programming, where the developer defines the methods, we leave it to the machines / algorithms to figure out the patterns from the data itself.

## Classifications of ML systems
ML algorithms can be classified using the following categories:

 - Level of supervision - supervised, unsupervised, reinforcement learning
    - **Supervised Learning** - training data that is labeled is fed to the algorithm. Examples: KNN, Linear Regression, Logistic Regression, SVM, Decision Trees, RF, Neural Networks
    
    - **Unsupervised learning** - unlabeled data is fed to the algorithm and it figures out natural groupings in the data. Some examples include - 
        - Clustering: K-means, Hierarchical cluster analysis (HCA), Expectation maximization. Unlike K-means, HCA can have subdivide each cluster into sub-clusters allowing for better grouping of data.
        - Visualization & Dimensionality reduction: PCA, Kernel PCA, Locally-Linear Embedding (LLE), t-distributed Stochastic Neighbor Embedding (t-SNE)
        - Association rule learning: Apriori, Eclat. Here the goal is to dig into large amounts of data to discover relationships between attributes.
    - **Reinforcement learning**: RL is a type of learning where instead of providing labeled data, the algorithm is given either a reward or penalty for its output. The learner (called agent) will attempt multiple attempts (called policies) until it maximizes the reward. RL is used train machines to perform some highly complex tasks such as walking. *AlphaGo* is an example.
 
 - Incremental learning - online vs batch learning
    - **Batch or offline learning**: The system is trained using all available data and then put into production for inference. Here it does not learn any more. To retrain, it needs to be taken offline and fed the new data.
    - **Online learning**: Data is fed incrementally in mini-batches and the model progressively gets refined. The concept of mini-batches allows th model to learn on data that is larger than what can be fit in memory. This is also called *out-of-core learning*. An important concept in online learning is **Learning Rate** - which controls how much should the model adapt to new data. A high LR will cause it to forget old data, a low LR will add inertia causing it to not fit new data well.

 - Model generalization: Instance based vs Model based.
    - **Instance based learning**: The model learns to find similarities in input data and uses a similarity score to predict on new data. Example: KNN.
    - **Model based learning**: Here the algorithm generates a model (a math function) that minimizes the loss and uses that model to perform predictions. Example: Linear regression.

## Challenges in ML
Below are come common challenges in machine learning.

 - **Poor quality data**: Training data might be non-representative - with under or oversampled for certain classes. Certain times this is unavoidable, other times it could be due to sampling bias.
 - **Overfitting training data**: Overfitting happens when the model is too complex relative to the amount and noise in training data. When a model overfits, it starts to use noise (such as coincidences) in data as predictors. A classic sign of overfitting is very low training error, but high test error.
    - Overfitting can be avoided by either increasing the size of training data (to include diverse data which averages out the noise) or by reducing the complexity of the model through **regularization**.
    - The amount of regularization is controlled by a **hyperparameter**. A hyperparameter is a parameter which is set prior to training and remains constant for that training run. Unlike model weights, it is not updated as a result of the training itself.
    - A high regularization value will oversimplify the model, leading to reduced Variance. But can result in a high error of Bias.
    - A low regularization value can lead to a model that overfits - leading to high variability, but low training bias and high test bias.
    - This relationship is called the **bias-variance** trade-off in machine learning.

## A Machine Learning checklist
*Adapted from [Hands-on ML from Scikit-Learn and TensorFlow](https://github.com/ageron/handson-ml2/)*.

 1. Frame the problem & look at the big picture
    - Define the problem in business terms.
    - Define it in ML terms (which type of ML will be used, what are the metrics)
    - How should performance be measured, what's minimum performance
    - Look for similar problems
    - If you were to solve without ML, how would the solution be?
2. Get the data
    - Plan how much of the data is needed
    - Plan where data will be stored and how it will be accessed (data workspace)
    - Verify access privileges and permissions / licenses
    - Remove PII
    - Make test set and put it aside. Do everything else including EDA on remaining train set.
    - Make a back-up copy that will not be touched at anytime. If you have to recover from back-up, make another back-up copy.
    - Automate this process so it can be repeated if new data comes along.
3. EDA
    - Use an interface like Jupyter Notebooks for this process.
    - Study each attribute and its characteristics (distribution, type, missing values, noise)
    - Visualize using plots and maps
    - Study correlations b/w attributes
    - Identify useful transformations that can be applied
    - Identify how data can be enriched (bringing in ancillary data sources)
4. Prepare the data
    - Write all transformations as functions that can be repeated on any data
    - data cleaning - fix outliers, missing data
    - feature selection - make new features, drop irrelevant features
    - feature engineering - discretize continuous features, decompose complex features (datetime, categories etc.), apply transformations
    - feature scaling - normalize / standardize features
5. Short-list promising models
    - Take a quick & dirty approach and train several models on a subset
    - Measure and compare the performance - for each model, use N-fold cross-validation and collect performance by computing mean and SD of performance metric
    - Collect most significant variables for each model
    - Iterate to feature selection / engineering
    - Retrain
    - Short-list top 3 models
6. Fine-tune the system
    - Bring back the full train set for this step
    - Fine tune hyperparameters using cross-validation
    - try ensemble methods
    - measure performance on test set (**generalization error**). Don't tune the model beyond this step (if you tune to perform on test set, you end up with an overfit model)
7. Present the solution
    - Document and clean up the code
    - Make a business presentation - explaining how business objective is being met / exceeded.
    - Highlight interesting / hidden info that was discovered. Use as viz lavishly.