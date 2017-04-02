K means clustering
------

It's actually the quantization of the vector from the signal which has
been termed as clustering in data mining. It aims to partition n
observation into k clusters where each cluster has the observation
closest to the mean.

Given a set of observations (x1, x2, …, x*n*), where each observation is
a *d*-dimensional real vector, *k*-means clustering aims to partition
the *n* observations into *k* (≤ *n*) sets S = {*S*1, *S*2, …, *Sk*} so
as to minimize the within-cluster sum of squares (WCSS) (sum of distance
functions of each point in the cluster to the K center).

<div align="center"><br><img src="http://i.imgur.com/syng6fM.png" width="200"" /> </div><br>



where *μi* is the mean of points in *Si*.

The main idea is to define k centers one for each clusters. The clusters
should be placed in a more effective way because different placement
location placement causes different results. Hence it is better to place
them as far as possible. The next step is to take each point belonging
to a given data set and associate it to the nearest center. At this
point re-calculate k's new centroids as barycenter of  the clusters
resulting from the previous step. After the k's new centroids, a new
binding has to be done  between  the same data set points  and  the
nearest new center. A loop has been generated. As a result of  this loop
we  may  notice that the k centers change their location step by step
until no more changes  are done or  in  other words centers do not move
any more.

Cross Validation
-----

Cross validation is a model evaluation method that is better than
residuals. The problem with residual evaluations is that they do not
give an indication of how well the learner will do when it is asked to
make new predictions for data it has not already seen. One way to
overcome this problem is to not use the entire data set when training a
learner. Some of the data is removed before training begins. Then when
training is done, the data that was removed can be used to test the
performance of the learned model on new data. This is the basic idea for
a whole class of model evaluation methods called *cross validation*.

The **holdout method** is the simplest kind of cross validation. The
data set is separated into two sets, called the training set and the
testing set. The function approximator fits a function using the
training set only. Then the function approximator is asked to predict
the output values for the data in the testing set (it has never seen
these output values before). The errors it makes are accumulated as
before to give the mean absolute test set error, which is used to
evaluate the model. The advantage of this method is that it is usually
preferable to the residual method and takes no longer to compute.
However, its evaluation can have a high variance. The evaluation may
depend heavily on which data points end up in the training set and which
end up in the test set, and thus the evaluation may be significantly
different depending on how the division is made.

**K-fold cross validation** is one way to improve over the holdout
method. The data set is divided into *k* subsets, and the holdout method
is repeated *k* times. Each time, one of the *k* subsets is used as the
test set and the other *k-1* subsets are put together to form a training
set. Then the average error across all *k* trials is computed. The
advantage of this method is that it matters less how the data gets
divided. Every data point gets to be in a test set exactly once, and
gets to be in a training set *k-1* times. The variance of the resulting
estimate is reduced as *k* is increased. The disadvantage of this method
is that the training algorithm has to be rerun from scratch *k* times,
which means it takes *k* times as much computation to make an
evaluation. A variant of this method is to randomly divide the data into
a test and training set *k* different times. The advantage of doing this
is that you can independently choose how large each test set is and how
many trials you average over.

**Leave-one-out cross validation** is K-fold cross validation taken to
its logical extreme, with K equal to N, the number of data points in the
set. That means that N separate times, the function approximator is
trained on all the data except for one point and a prediction is made
for that point. As before the average error is computed and used to
evaluate the model. The evaluation given by leave-one-out cross
validation error (LOO-XVE) is good, but at first pass it seems very
expensive to compute. Fortunately, locally weighted learners can make
LOO predictions just as easily as they make regular predictions. That
means computing the LOO-XVE takes no more time than computing the
residual error and it is a much better way to evaluate models. We will
see shortly that Vizier relies heavily on LOO-XVE to choose its
metacodes.

Previous Section : [Regression Methods ](met-regression2)<br>
Next Chapter : [Data Processing](dp-intro)
