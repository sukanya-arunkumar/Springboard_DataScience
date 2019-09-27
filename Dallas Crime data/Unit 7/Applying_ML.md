**Dallas Crime data - Applying Machine Learning**
=================================================

1.**How do you frame your main question as a machine learning problem?
Is it a supervised or unsupervised problem? If it is supervised, is it a
regression or a classification?**

The main objective of this project is to predict the crime rate (for
every crime type) for the future year. Our dataset fits right in the
supervised learning technique.

Supervised learning is a learning where it takes a sample of input and
desired outputs(training data), analyses them and effectively produces
correct output data. The correct output produced is entirely based on
the training data. Supervised learning can be of two categories:

-   Classification : When the output variable is a category
-   Regression : When the output variable is a real or continuous value

Clearly, our problem falls under the regression category.

2.**What are the main features (also called independent variables or
predictors) that you'll use?**

The Independent variables or predictors to solve the above stated
problem are

-   Year of Incident
-   Month1 of Occurence
-   Hour of the Day
-   Crime Type

3.**Which machine learning technique will you use?**

The machine learning technique that will be used to solved this problem
is **Linear Regression**

Linear Regression - A method that predicts the value of an outcome
variable Y based on one or more predictor (input) variables. The aim is
to establish a linear relationship (a formula) betweent the predictor
variables and the outcome variable, so that the formula can be used to
predict the value of the outcome Y, when only the predictor variables
are known.

In our case, the precitor varaibles can be Month1 of Occurence, Hour of
the Day and the outcome variable is the number of crimes (best
approximate) that can happen in the future.

4.**How will you evaluate the success of your machine learning
technique? What metric will you use?**

Cross Validation technique will be used to evaluate the perfomance of
the predictive model.

The cross validation is a method of measuring the performance of a given
predictive model on a new data set. The basic idea consists of dividing
the data into two sets

-   Training Set : The dataset used to build a model
-   Testing Set : The dataset used to test the model by measuring the
    prediction error
