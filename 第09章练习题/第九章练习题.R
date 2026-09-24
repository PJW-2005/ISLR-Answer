library(ISLR2)
library(e1071)
# 第 1 题
# This problem involves hyperplanes in two dimensions.
#
# (a) Sketch the hyperplane
#
# 1 + 3*X1 - X2 = 0.
#
# Indicate the set of points for which 1 + 3*X1 - X2 > 0, as well as
# the set of points for which 1 + 3*X1 - X2 < 0.
x <- seq(-3, 3, length = 100)
plot(
  x, 1 + 3*x,
  type = "l",
  xlab = "X1",
  ylab = "X2",
  xlim = c(-3, 3),
  ylim = c(-5, 7)
)
text(1.5, 2, "> 0")
text(-1, 4, "< 0")
# (b) On the same plot, sketch the hyperplane
#
# -2 + X1 + 2*X2 = 0.
#
# Indicate the set of points for which -2 + X1 + 2*X2 > 0, as well as
# the set of points for which -2 + X1 + 2*X2 < 0.
lines(
  x,
  1 - x/2,
  lty = 2
)
legend(
  "bottomleft",
  legend = c(
    "1 + 3X1 - X2 = 0",
    "-2 + X1 + 2X2 = 0"
  ),
  lty = c(1, 2)
)

# 第 2 题
# We have seen that in p = 2 dimensions, a linear decision boundary takes
# the form β0 + β1*X1 + β2*X2 = 0. We now investigate a non-linear decision
# boundary.
#
# (a) Sketch the curve
#
# (1 + X1)^2 + (2 - X2)^2 = 4.
symbols(
  -1, 2,
  circles = 2,
  inches = FALSE,
  xlim = c(-4, 3),
  ylim = c(-1, 5),
  xlab = "X1",
  ylab = "X2"
)

points(-1, 2, pch = 20)

# (b) On your sketch, indicate the set of points for which
#
# (1 + X1)^2 + (2 - X2)^2 > 4,
#
# as well as the set of points for which
#
# (1 + X1)^2 + (2 - X2)^2 <= 4.
text(-1, 2, "<= 4")
text(2, 4, "> 4")

# (c) Suppose that a classifier assigns an observation to the blue class if
#
# (1 + X1)^2 + (2 - X2)^2 > 4,
#
# and to the red class otherwise. To what class is each of the following
# observations classified: (0, 0), (-1, 1), (2, 2), and (3, 8)?
#
# (d) Argue that while the decision boundary in (c) is not linear in terms
# of X1 and X2, it is linear in terms of X1, X1^2, X2, and X2^2.

# X1^2 + 2X1 + 1 + X2^2 - 4X2 + 4 = 4
# 1 + 2X1 + X1^2 - 4X2 + X2^2 = 0
# 虽然对于X1和X2是non-linear，
# 但是如果把
# X1, X1^2, X2, X2^2
# 看成四个predictors，
# 那么这个decision boundary就是linear的。

# 第 3 题
# Here we explore the maximal margin classifier on a toy data set.
x1 <- c(3, 2, 4, 1, 2, 4, 4)
x2 <- c(4, 2, 4, 4, 1, 3, 1)
Class <- factor(
  c(
    "Red", "Red", "Red", "Red",
    "Blue", "Blue", "Blue"
  )
)
dat <- data.frame(x1, x2, Class)
# (a) We are given n = 7 observations in p = 2 dimensions. For each
# observation, there is an associated class label.
#
# Observation    X1    X2    Y
# 1               3     4    Red
# 2               2     2    Red
# 3               4     4    Red
# 4               1     4    Red
# 5               2     1    Blue
# 6               4     3    Blue
# 7               4     1    Blue
#
# Sketch the observations.
plot(
  x1, x2,
  col = ifelse(Class == "Red", "red", "blue"),
  pch = 20,
  xlim = c(0, 5),
  ylim = c(0, 5),
  xlab = "X1",
  ylab = "X2"
)
text(
  x1, x2,
  labels = 1:7,
  pos = 3
)

# (b) Sketch the optimal separating hyperplane, and provide the equation for
# this hyperplane in the form of Equation (9.1).
abline(
  a = -0.5,
  b = 1
)


# (c) Describe the classification rule for the maximal margin classifier. It
# should be something along the lines of: classify to Red if
# β0 + β1*X1 + β2*X2 > 0, and classify to Blue otherwise. Provide the values
# for β0, β1, and β2.
# 红色：
# 1 - 2X1 + 2X2 > 0
# 蓝色:
# 1 - 2X1 + 2X2 < 0
# beta0 = 1
# beta1 = -2
# beta2 = 2

# (d) On your sketch, indicate the margin for the maximal margin hyperplane.
abline(
  a = 0,
  b = 1,
  lty = 2
)

abline(
  a = -1,
  b = 1,
  lty = 2
)

# (e) Indicate the support vectors for the maximal margin classifier.
points(
  x1[c(2, 3, 5, 6)],
  x2[c(2, 3, 5, 6)],
  pch = 1,
  cex = 2
)

# (f) Argue that a slight movement of the seventh observation would not affect
# the maximal margin hyperplane.
# Observation 7 = (4, 1)
# 它距离decision boundary较远，不是support vector。
# maximal margin hyperplane只由support vectors决定，
# 因此第7个点发生小范围移动不会改变hyperplane。


# (g) Sketch a hyperplane that is not the optimal separating hyperplane, and
# provide the equation for this hyperplane.
abline(
  a = -0.25,
  b = 1,
  lty = 3
)
# (h) Draw an additional observation on the plot so that the two classes are
# no longer separable by a hyperplane.
points(
  3, 1.5,
  col = "red",
  pch = 20
)

# 第 4 题
# Generate a simulated two-class data set with 100 observations and two
# features in which there is a visible but non-linear separation between the
# two classes. Show that in this setting, a support vector machine with a
# polynomial kernel of degree greater than 1, or a radial kernel, will
# outperform a support vector classifier on the training data. Which technique
# performs best on the test data? Make plots and report training and test error
# rates in order to support your assertions.
set.seed(1)
n <- 100
x1 <- runif(
  n,
  -2,
  2
)
x2 <- runif(
  n,
  -2,
  2
)
Class <- factor(
  ifelse(
    x1^2 + x2^2 > 2,
    "Blue",
    "Red"
  )
)
dat <- data.frame(
  x1,
  x2,
  Class
)
plot(
  x1, x2,
  col = ifelse(Class == "Blue", "blue", "red"),
  pch = 20
)

set.seed(1)
train <- sample(
  1:n,
  70
)
train.dat <- dat[train, ]
test.dat <- dat[-train, ]
svc.fit <- svm(
  Class ~ .,
  data = train.dat,
  kernel = "linear",
  cost = 10
)
poly.fit <- svm(
  Class ~ .,
  data = train.dat,
  kernel = "polynomial",
  degree = 2,
  cost = 10,
  gamma = 1,
  coef0 = 1
)
radial.fit <- svm(
  Class ~ .,
  data = train.dat,
  kernel = "radial",
  cost = 10,
  gamma = 1
)

svc.train <- mean(
  predict(svc.fit, train.dat) != train.dat$Class
)
poly.train <- mean(
  predict(poly.fit, train.dat) != train.dat$Class
)
radial.train <- mean(
  predict(radial.fit, train.dat) != train.dat$Class
)
svc.test <- mean(
  predict(svc.fit, test.dat) != test.dat$Class
)
poly.test <- mean(
  predict(poly.fit, test.dat) != test.dat$Class
)
radial.test <- mean(
  predict(radial.fit, test.dat) != test.dat$Class
)

result <- data.frame(
  Model = c(
    "Linear",
    "Polynomial",
    "Radial"
  ),
  Train_Error = c(
    svc.train,
    poly.train,
    radial.train
  ),
  Test_Error = c(
    svc.test,
    poly.test,
    radial.test
  )
)

result$Model[
  which.min(result$Test_Error)
]
par(
  mfrow = c(1, 3)
)
plot(
  svc.fit,
  train.dat,
  x2 ~ x1
)
plot(
  poly.fit,
  train.dat,
  x2 ~ x1
)
plot(
  radial.fit,
  train.dat,
  x2 ~ x1
)
par(
  mfrow = c(1, 1)
)

# 第 5 题
# We have seen that we can fit an SVM with a non-linear kernel in order to
# perform classification using a non-linear decision boundary. We will now see
# that we can also obtain a non-linear decision boundary by performing logistic
# regression using non-linear transformations of the features.
#
# (a) Generate a data set with n = 500 and p = 2, such that the observations
# belong to two classes with a quadratic decision boundary between them. For
# instance, you can do this as follows:
set.seed(1)

x1 <- runif(500) - 0.5
x2 <- runif(500) - 0.5
y <- 1 * (
  x1^2 - x2^2 > 0
)
Class <- factor(
  y,
  levels = c(0, 1),
  labels = c("Red", "Blue")
)
dat <- data.frame(x1, x2, y, Class)

# (b) Plot the observations, colored according to their class labels. Your
# plot should display X1 on the x-axis and X2 on the y-axis.
plot(
  x1,
  x2,
  col = ifelse(y == 1, "blue", "red"),
  pch = 20,
  xlab = "X1",
  ylab = "X2"
)
# (c) Fit a logistic regression model to the data, using X1 and X2 as
# predictors.
log.fit <- glm(
  y ~ x1 + x2,
  data = dat,
  family = binomial
)
summary(log.fit)


# (d) Apply this model to the training data in order to obtain a predicted
# class label for each training observation. Plot the observations, colored
# according to the predicted class labels. The decision boundary should be
# linear.
log.prob <- predict(
  log.fit,
  type = "response"
)

log.pred <- ifelse(
  log.prob > 0.5,
  1,
  0
)

plot(
  x1,
  x2,
  col = ifelse(log.pred == 1, "blue", "red"),
  pch = 20
)
# (e) Now fit a logistic regression model to the data using non-linear
# functions of X1 and X2 as predictors, such as X1^2, X1*X2, and log(X2).
log.fit2 <- glm(
  y ~ x1 + x2 +
    I(x1^2) +
    I(x2^2) +
    I(x1*x2),
  data = dat,
  family = binomial
)
summary(log.fit2)

# (f) Apply this model to the training data in order to obtain a predicted
# class label for each training observation. Plot the observations, colored
# according to the predicted class labels. The decision boundary should be
# obviously non-linear. If it is not, then repeat parts (a) through (e) until
# you obtain an example in which the predicted class labels are obviously
# non-linear.
log.prob2 <- predict(
  log.fit2,
  type = "response"
)
log.pred2 <- ifelse(
  log.prob2 > 0.5,
  1,
  0
)
plot(
  x1,
  x2,
  col = ifelse(log.pred2 == 1, "blue", "red"),
  pch = 20
)

# (g) Fit a support vector classifier to the data with X1 and X2 as predictors.
# Obtain a class prediction for each training observation. Plot the
# observations, colored according to the predicted class labels.
svc.fit <- svm(
  Class ~ x1 + x2,
  data = dat,
  kernel = "linear",
  cost = 10
)
svc.pred <- predict(
  svc.fit,
  dat
)
plot(
  x1,
  x2,
  col = ifelse(svc.pred == "Blue", "blue", "red"),
  pch = 20
)
mean(
  svc.pred != Class
)


# (h) Fit an SVM using a non-linear kernel to the data. Obtain a class
# prediction for each training observation. Plot the observations, colored
# according to the predicted class labels.
svm.fit <- svm(
  Class ~ x1 + x2,
  data = dat,
  kernel = "radial",
  cost = 10,
  gamma = 1
)
svm.pred <- predict(svm.fit, dat)
plot(
  x1,
  x2,
  col = ifelse(svm.pred == "Blue", "blue", "red"),
  pch = 20
)
mean(svm.pred != Class)

# (i) Comment on your results.

# 第 6 题
# At the end of Section 9.6.1, it is claimed that in the case of data that is
# just barely linearly separable, a support vector classifier with a small value
# of cost that misclassifies a couple of training observations may perform
# better on test data than one with a huge value of cost that does not
# misclassify any training observations. You will now investigate this claim.
#
# (a) Generate two-class data with p = 2 in such a way that the classes are
# just barely linearly separable.
set.seed(1)
x1 <- c(
  rnorm(50, -0.8, 0.2),
  rnorm(50, 0.8, 0.2)
)
x2 <- rnorm(100)
Class <- factor(
  c(
    rep("Blue", 50),
    rep("Red", 50)
  )
)
x1[50] <- 0.2
x2[50] <- -6
x1[51] <- -0.2
x2[51] <- 6
dat <- data.frame(x1, x2, Class)
plot(
  x1,
  x2,
  col = ifelse(Class == "Red", "red", "blue"),
  pch = 20
)

# 数据仍然linearly separable，
# 但是为了正确分类两个特殊点，
# hyperplane需要受到这两个点比较大的影响。


# (b) Compute the cross-validation error rates for support vector classifiers
# with a range of cost values. How many training observations are misclassified
# for each value of cost considered, and how does this relate to the
# cross-validation errors obtained?

cost.values <- c(
  0.01,
  0.1,
  1,
  10,
  100,
  1000
)
train.error <- rep(
  NA,
  length(cost.values)
)
for (i in 1:length(cost.values)) {
  fit <- svm(
    Class ~ .,
    data = dat,
    kernel = "linear",
    cost = cost.values[i],
    scale = FALSE
  )
  train.pred <- predict(
    fit,
    dat
  )
  train.error[i] <- mean(
    train.pred != dat$Class
  )
}
set.seed(1)
tune.fit <- tune(
  svm,
  Class ~ .,
  data = dat,
  kernel = "linear",
  ranges = list(
    cost = cost.values
  ),
  scale = FALSE,
  tunecontrol = tune.control(
    cross = 10
  )
)
tune.fit$performances
cv.error <- tune.fit$performances$error
result <- data.frame(
  Cost = cost.values,
  Train_Error = train.error,
  CV_Error = cv.error
)


# (c) Generate an appropriate test data set, and compute the test errors
# corresponding to each of the values of cost considered. Which value of cost
# leads to the fewest test errors, and how does this compare to the values of
# cost that yield the fewest training errors and the fewest cross-validation
# errors?
set.seed(2)
x1.test <- c(
  rnorm(500, -0.8, 0.35),
  rnorm(500, 0.8, 0.35)
)
x2.test <- rnorm(1000)
Class.test <- factor(
  c(
    rep("Blue", 500),
    rep("Red", 500)
  )
)
test.dat <- data.frame(
  x1 = x1.test,
  x2 = x2.test,
  Class = Class.test
)
test.error <- rep(
  NA,
  length(cost.values)
)
for (i in 1:length(cost.values)) {
  fit <- svm(
    Class ~ .,
    data = dat,
    kernel = "linear",
    cost = cost.values[i],
    scale = FALSE
  )
  test.pred <- predict(
    fit,
    test.dat
  )
  test.error[i] <- mean(
    test.pred != test.dat$Class
  )
}
result$Test_Error <- test.error
result$Cost[
  which.min(result$Train_Error)
]
result$Cost[
  which.min(result$CV_Error)
]
result$Cost[
  which.min(result$Test_Error)
]
# (d) Discuss your results.

# 第 7 题
# In this problem, you will use support vector approaches in order to predict
# whether a given car gets high or low gas mileage based on the Auto data set.
#
# (a) Create a binary variable that takes on a value of 1 for cars with gas
# mileage above the median and a value of 0 for cars with gas mileage below the
# median.
Auto$mpg01 <- factor(
  ifelse(
    Auto$mpg > median(Auto$mpg),
    "High",
    "Low"
  )
)
table(Auto$mpg01)
Auto.svm <- Auto[
  ,
  !names(Auto) %in% c(
    "mpg",
    "name"
  )
]

# (b) Fit a support vector classifier to the data with various values of cost,
# in order to predict whether a car gets high or low gas mileage. Report the
# cross-validation errors associated with different values of this parameter.
# Comment on your results. Note that you will need to fit the classifier without
# the gas mileage variable in order to produce sensible results.
set.seed(1)
tune.linear <- tune(
  svm,
  mpg01 ~ .,
  data = Auto.svm,
  kernel = "linear",
  ranges = list(
    cost = c(
      0.001,
      0.01,
      0.1,
      1,
      10,
      100
    )
  )
)
tune.linear$performances[, c("cost", "error")]
tune.linear$best.parameters

# (c) Repeat part (b), this time using SVMs with radial and polynomial kernels,
# with different values of gamma, degree, and cost. Comment on your results.
set.seed(1)

tune.radial <- tune(svm, mpg01 ~ ., data = Auto.svm, kernel = "radial", 
    ranges = list(cost = c(0.01, 0.1, 1, 10,100),
    gamma = c(0.01, 0.1, 1, 10))
)
tune.radial$performances
tune.radial$best.parameters
set.seed(1)
tune.poly <- tune(svm, mpg01 ~ ., data = Auto.svm, kernel = "polynomial", 
ranges = list(
    cost = c(0.01, 0.1, 1, 10),
    gamma = c(0.01, 0.1, 1),
    degree = c(2, 3)
    )
)
tune.poly$performances
tune.poly$best.parameters

c(
  Linear = min(tune.linear$performances$error),
  Radial = min(tune.radial$performances$error),
  Polynomial = min(tune.poly$performances$error)
)
# (d) Make some plots to support your assertions in parts (b) and (c).
#
# Hint: In the lab, we used the plot() function for svm objects only in cases
# with p = 2. When p > 2, you can use plot() to display pairs of variables at
# a time. Instead of typing
#
# plot(svmfit, dat)
#
# where svmfit contains your fitted model and dat is a data frame containing
# your data, you can type
#
# plot(svmfit, dat, x1 ~ x4)
#
# in order to plot just the first and fourth variables. However, you must
# replace x1 and x4 with the correct variable names. To find out more, type
# ?plot.svm.
plot(
  tune.linear$best.model,
  Auto.svm,
  horsepower ~ weight
)

plot(
  tune.radial$best.model,
  Auto.svm,
  horsepower ~ weight
)

plot(
  tune.poly$best.model,
  Auto.svm,
  horsepower ~ weight
)

plot(
  tune.radial$best.model,
  Auto.svm,
  weight ~ displacement)

# 第 8 题
# This problem involves the OJ data set, which is part of the ISLR2 package.
#
# (a) Create a training set containing a random sample of 800 observations, and
# a test set containing the remaining observations.
#
# (b) Fit a support vector classifier to the training data using cost = 0.01,
# with Purchase as the response and the other variables as predictors. Use the
# summary() function to produce summary statistics, and describe the results
# obtained.
#
# (c) What are the training and test error rates?
#
# (d) Use the tune() function to select an optimal cost. Consider values in the
# range 0.01 to 10.
#
# (e) Compute the training and test error rates using this new value for cost.
#
# (f) Repeat parts (b) through (e) using a support vector machine with a radial
# kernel. Use the default value for gamma.
#
# (g) Repeat parts (b) through (e) using a support vector machine with a
# polynomial kernel. Set degree = 2.
#
# (h) Overall, which approach seems to give the best results on this data?