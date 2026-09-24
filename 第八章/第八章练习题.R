library(ISLR2)
library(tree)
library(randomForest)
library(gbm)
library(glmnet)
library(BART)

# 第 1 题
# Draw an example of your own invention of a partition of two-dimensional
# feature space that could result from recursive binary splitting. Your example
# should contain at least six regions. Draw a decision tree corresponding to
# this partition. Be sure to label all aspects of your figures, including the
# regions R1, R2, ..., the cutpoints t1, t2, ..., and so forth.
#
# Hint: Your result should look something like Figures 8.1 and 8.2.
plot(
  NA,
  xlim = c(0, 7),
  ylim = c(0, 6),
  xlab = "X1",
  ylab = "X2"
)
abline(v = 3)
segments(0, 2, 3, 2)
segments(3, 3, 7, 3)
segments(5, 0, 5, 3)
segments(4.5, 3, 4.5, 6)

text(1.5, 1, "R1")
text(1.5, 4, "R2")
text(4, 1.5, "R3")
text(6, 1.5, "R4")
text(3.8, 4.5, "R5")
text(5.7, 4.5, "R6")









# 第 2 题
# It is mentioned in Section 8.2.3 that boosting using depth-one trees, or
# stumps, leads to an additive model: that is, a model of the form
#
# f(X) = sum(j = 1 to p) f_j(X_j).
#
# Explain why this is the case. You can begin with Equation (8.12) in
# Algorithm 8.2.

# depth-one tree只有一次分割，因此每一棵树只能选择一个变量X_j进行分割。
# 所以第b棵树可以写成：
# T_b(X) = f_b(X_j)
# boosting最终模型为：
# f(X) = sum(b = 1 to B) lambda * T_b(X)
# 将所有使用同一个X_j的树放在一起：
# f(X) = f_1(X_1) + f_2(X_2) + ... + f_p(X_p)
# 因此depth-one tree的boosting最终一定是additive model。
# 因为单棵树无法同时产生X1和X2之间的interaction。


# 第 3 题
# Consider the Gini index, classification error, and entropy in a simple
# classification setting with two classes. Create a single plot that displays
# each of these quantities as a function of p_m1_hat. The x-axis should display
# p_m1_hat, ranging from 0 to 1, and the y-axis should display the value of the
# Gini index, classification error, and entropy.
#
# Hint: In a setting with two classes, p_m1_hat = 1 - p_m2_hat. You could make
# this plot by hand, but it will be much easier to make in R.
p <- seq(0, 1, length = 1000)
gini <- 2 * p * (1 - p)
classification_error <- pmin(p, 1 - p)
entropy <- -(
  ifelse(p == 0, 0, p * log(p)) +
  ifelse(p == 1, 0, (1 - p) * log(1 - p))
)

plot(
  p, gini,
  type = "l",
  ylim = c(0, max(entropy)),
  xlab = "p_m1_hat",
  ylab = "Value"
)
lines(p, classification_error, lty = 2)
lines(p, entropy, lty = 3)
legend(
  "topright",
  legend = c("Gini", "Classification Error", "Entropy"),
  lty = c(1, 2, 3)
)

# 第 4 题
# This question relates to the plots in Figure 8.14.
#
# (a) Sketch the tree corresponding to the partition of the predictor space
# illustrated in the left-hand panel of Figure 8.14. The numbers inside the
# boxes indicate the mean of Y within each region.

# (b) Create a diagram similar to the left-hand panel of Figure 8.14, using the
# tree illustrated in the right-hand panel of the same figure. You should divide
# the predictor space into the correct regions and indicate the mean for each
# region.

plot(
  NA,
  xlim = c(-2, 2),
  ylim = c(-1, 3),
  xlab = "X1",
  ylab = "X2"
)
abline(h = 1)
segments(1, -1, 1, 1)
segments(-2, 2, 2, 2)
segments(0, 1, 0, 2)

text(-0.5, 0, "-1.80")
text(1.5, 0, "0.63")
text(-1, 1.5, "-1.06")
text(1, 1.5, "0.21")
text(0, 2.5, "2.49")


# 第 5 题
# Suppose we produce ten bootstrapped samples from a data set containing red
# and green classes. We then apply a classification tree to each bootstrapped
# sample and, for a specific value of X, produce 10 estimates of
# P(Class is Red | X):
#
# 0.1, 0.15, 0.2, 0.2, 0.55, 0.6, 0.6, 0.65, 0.7, and 0.75.
#
# There are two common ways to combine these results into a single class
# prediction. One is the majority-vote approach discussed in this chapter.
# The second approach is to classify based on the average probability. In this
# example, what is the final classification under each of these two approaches?
prob <- c(0.1, 0.15, 0.2, 0.2, 0.55,
          0.6, 0.6, 0.65, 0.7, 0.75)
sum(prob > 0.5)
# 有6棵树认为Red，4棵树认为Green
# 因此majority vote最终预测为Red
# 平均概率 = 0.45 < 0.5
# 因此average probability方法预测为Green。
# 两种方法结果不同：
# Majority Vote -> Red
# Average Probability -> Green

# 第 6 题

# Provide a detailed explanation of the algorithm that is used to fit a
# regression tree.
# 首先对所有变量X_j以及所有可能的切分点s进行搜索。
# 将空间分成：
# R1(j,s) = {X | X_j < s}
# R2(j,s) = {X | X_j >= s}
# 对每一个候选(j,s)，计算：
# sum_{xi in R1}(yi - y_R1)^2 +
# sum_{xi in R2}(yi - y_R2)^2
# 其中y_R1和y_R2分别是两个区域中Y的平均值。


# 其次找到能够使RSS最小的变量X_j和切分点s，
# 将当前数据分成两个区域。

# 再对刚刚产生的两个区域分别重复相同过程。
# 每一次都寻找当前区域中使RSS下降最多的split，
# 这就是recursive binary splitting。


#因为一直分割会产生非常复杂的树，容易overfitting。
# 因此通常先生成一个比较大的tree，再进行pruning。

# Cost Complexity Pruning：
# RSS(tree) + alpha * |T|
# |T|表示terminal nodes数量。
# alpha越大，对复杂树的惩罚越大，
# 最终保留的tree越小。

# 最后用cross-validation选择最佳alpha或者tree size。
# 对新的X，找到它所属的terminal region R_m，
# 最终预测值就是：y_hat = mean(Y in R_m)



# 第 7 题
# In the lab, we applied random forests to the Boston data using mtry = 6 and
# using ntree = 25 and ntree = 500. Create a plot displaying the test error
# resulting from random forests on this data set for a more comprehensive range
# of values for mtry and ntree. You can model your plot after Figure 8.10.
# Describe the results obtained.

set.seed(1)
train <- sample(
  1:nrow(Boston),
  nrow(Boston) / 2
)
Boston.test <- Boston[-train, ]
mtry_values <- c(1, 2, 4, 6, 8, 10, 13)
ntree_values <- c(25, 50, 100, 200, 500, 1000)
test_mse <- matrix(
  NA,
  nrow = length(ntree_values),
  ncol = length(mtry_values)
)
for (i in 1:length(ntree_values)) {
  for (j in 1:length(mtry_values)) {
    rf.fit <- randomForest(
      medv ~ .,
      data = Boston,
      subset = train,
      mtry = mtry_values[j],
      ntree = ntree_values[i]
    )
    pred <- predict(rf.fit, Boston.test)
    test_mse[i, j] <-
      mean((Boston.test$medv - pred)^2)
  }
}
matplot(
  ntree_values,
  test_mse,
  type = "l",
  lty = 1,
  xlab = "Number of Trees",
  ylab = "Test MSE"
)
legend("topright",legend = paste("mtry =", mtry_values),lty = 1)
best <- which(test_mse == min(test_mse),arr.ind = TRUE)
mtry_values[best[1, 2]]
ntree_values[best[1, 1]]
min(test_mse)

# 第 8 题
# In the lab, a classification tree was applied to the Carseats data set after
# converting Sales into a qualitative response variable. Now we will seek to
# predict Sales using regression trees and related approaches, treating the
# response as a quantitative variable.
set.seed(1)
train <- sample(
  1:nrow(Carseats),
  nrow(Carseats) / 2
)
test <- -train

# (a) Split the data set into a training set and a test set.
Carseats.train <- Carseats[train, ]
Carseats.test <- Carseats[test, ]

# (b) Fit a regression tree to the training set. Plot the tree, and interpret
# the results. What test MSE do you obtain?
tree.carseats <- tree(Sales ~ .,data = Carseats.train)
summary(tree.carseats)
plot(tree.carseats)
text(tree.carseats, pretty = 0)
tree.pred <- predict(tree.carseats,Carseats.test)
mse.tree <- mean(
  (Carseats.test$Sales - tree.pred)^2
)

# (c) Use cross-validation in order to determine the optimal level of tree
# complexity. Does pruning the tree improve the test MSE?
set.seed(1)
cv.carseats <- cv.tree(tree.carseats)
plot(
  cv.carseats$size,
  cv.carseats$dev,
  type = "b"
)
best.size <-
  cv.carseats$size[
    which.min(cv.carseats$dev)
  ]
prune.carseats <- prune.tree(
  tree.carseats,
  best = best.size
)

prune.pred <- predict(
  prune.carseats,
  Carseats.test
)
mse.prune <- mean(
  (Carseats.test$Sales - prune.pred)^2
)

mse.tree
mse.prune

# (d) Use the bagging approach in order to analyze this data. What test MSE do
# you obtain? Use the importance() function to determine which variables are
# most important.
p <- ncol(Carseats) - 1
set.seed(1)
bag.carseats <- randomForest(
  Sales ~ .,
  data = Carseats.train,
  mtry = p,
  importance = TRUE
)
bag.pred <- predict(
  bag.carseats,
  Carseats.test
)

mse.bag <- mean(
  (Carseats.test$Sales - bag.pred)^2
)
importance(bag.carseats)
varImpPlot(bag.carseats)


# (e) Use random forests to analyze this data. What test MSE do you obtain?
# Use the importance() function to determine which variables are most important.
# Describe the effect of m, the number of variables considered at each split,
# on the error rate obtained.

set.seed(1)
rf.carseats <- randomForest(
  Sales ~ .,
  data = Carseats.train,
  mtry = 3,
  importance = TRUE
)
rf.pred <- predict(
  rf.carseats,
  Carseats.test
)
mse.rf <- mean(
  (Carseats.test$Sales - rf.pred)^2
)
importance(rf.carseats)
varImpPlot(rf.carseats)
rf.mse <- rep(NA, p)
for (m in 1:p) {
  set.seed(1)
  rf.temp <- randomForest(
    Sales ~ .,
    data = Carseats.train,
    mtry = m
  )
  pred <- predict(
    rf.temp,
    Carseats.test
  )
  rf.mse[m] <- mean(
    (Carseats.test$Sales - pred)^2
  )
}
plot(
  1:p,
  rf.mse,
  type = "l",
  xlab = "mtry",
  ylab = "Test MSE"
)
which.min(rf.mse)
min(rf.mse)

# (f) Now analyze the data using BART, and report your results.
x <- model.matrix(
  Sales ~ .,
  data = Carseats
)[, -1]
y <- Carseats$Sales
set.seed(1)
bart.carseats <- wbart(
  x.train = x[train, ],
  y.train = y[train],
  x.test = x[test, ],
  ntree = 200
)
bart.pred <- bart.carseats$yhat.test.mean
mse.bart <- mean(
  (y[test] - bart.pred)^2
)
c(
  Tree = mse.tree,
  Pruned_Tree = mse.prune,
  Bagging = mse.bag,
  Random_Forest = mse.rf,
  BART = mse.bart
)
# 第 9 题
# This problem involves the OJ data set, which is part of the ISLR2 package.
#
# (a) Create a training set containing a random sample of 800 observations, and
# a test set containing the remaining observations.
set.seed(1)
train <- sample(
  1:nrow(OJ),
  800
)
OJ.train <- OJ[train, ]
OJ.test <- OJ[-train, ]

# (b) Fit a tree to the training data, with Purchase as the response and the
# other variables as predictors. Use the summary() function to produce summary
# statistics about the tree, and describe the results obtained. What is the
# training error rate? How many terminal nodes does the tree have?

oj.tree <- tree(
  Purchase ~ .,
  data = OJ.train
)
summary(oj.tree)
pred.train <- predict(
  oj.tree,
  OJ.train,
  type = "class"
)
train.error <- mean(
  pred.train != OJ.train$Purchase
)
train.error
n.leaf <- sum(
  oj.tree$frame$var == "<leaf>"
)
n.leaf

# (c) Type in the name of the tree object in order to get detailed text output.
# Pick one of the terminal nodes, and interpret the information displayed.

oj.tree
# 输出形式：
# node) split, n, deviance, yval, (yprob)
# n表示落到这个node中的样本数量。
# yval表示这个node最终预测的类别。
# yprob表示两个类别分别占多少比例。
# *表示这个node已经是terminal node。



# (d) Create a plot of the tree, and interpret the results.
plot(oj.tree)
text(oj.tree, pretty = 0)
# (e) Predict the response on the test data, and produce a confusion matrix
# comparing the test labels to the predicted test labels. What is the test
# error rate?
oj.pred <- predict(
  oj.tree,
  OJ.test,
  type = "class"
)
confusion <- table(
  Predicted = oj.pred,
  Actual = OJ.test$Purchase
)
test.error <- mean(
  oj.pred != OJ.test$Purchase
)



# (f) Apply the cv.tree() function to the training set in order to determine
# the optimal tree size.

set.seed(1)
cv.oj <- cv.tree(
  oj.tree,
  FUN = prune.misclass
)

# (g) Produce a plot with tree size on the x-axis and cross-validated
# classification error rate on the y-axis.

plot(
  cv.oj$size,
  cv.oj$dev,
  type = "b",
  xlab = "Tree Size",
  ylab = "Cross-Validation Error"
)

# (h) Which tree size corresponds to the lowest cross-validated classification
# error rate?

best.size <- cv.oj$size[
  which.min(cv.oj$dev)
]
# (i) Produce a pruned tree corresponding to the optimal tree size obtained
# using cross-validation. If cross-validation does not lead to selection of a
# pruned tree, then create a pruned tree with five terminal nodes.
#

if (best.size == n.leaf) {
  prune.size <- 5
} else {
  prune.size <- best.size
}
oj.prune <- prune.misclass(
  oj.tree,
  best = prune.size
)
plot(oj.prune)
text(oj.prune, pretty = 0)

# (j) Compare the training error rates between the pruned and unpruned trees.
# Which is higher?

pred.train.prune <- predict(
  oj.prune,
  OJ.train,
  type = "class"
)
train.error.prune <- mean(
  pred.train.prune != OJ.train$Purchase
)

# (k) Compare the test error rates between the pruned and unpruned trees.
# Which is higher?
pred.test.prune <- predict(
  oj.prune,
  OJ.test,
  type = "class"
)
test.error.prune <- mean(
  pred.test.prune != OJ.test$Purchase
)


# 第 10 题
# We now use boosting to predict Salary in the Hitters data set.
#
# (a) Remove the observations for whom the salary information is unknown, and
# then log-transform the salaries.
Hitters2 <- na.omit(Hitters)
Hitters2$Salary <- log(
  Hitters2$Salary
)
# (b) Create a training set consisting of the first 200 observations, and a
# test set consisting of the remaining observations.
train <- 1:200
test <- 201:nrow(Hitters2)
# (c) Perform boosting on the training set with 1,000 trees for a range of
# values of the shrinkage parameter λ. Produce a plot with different shrinkage
# values on the x-axis and the corresponding training-set MSE on the y-axis.
lambda <- c(
  0.0001,
  0.0005,
  0.001,
  0.005,
  0.01,
  0.05,
  0.1
)

train.mse <- rep(
  NA,
  length(lambda)
)

test.mse <- rep(
  NA,
  length(lambda)
)

for (i in 1:length(lambda)) {

  set.seed(1)

  boost.fit <- gbm(
    Salary ~ .,
    data = Hitters2[train, ],
    distribution = "gaussian",
    n.trees = 1000,
    interaction.depth = 4,
    shrinkage = lambda[i],
    verbose = FALSE
  )

  pred.train <- predict(
    boost.fit,
    Hitters2[train, ],
    n.trees = 1000
  )

  pred.test <- predict(
    boost.fit,
    Hitters2[test, ],
    n.trees = 1000
  )

  train.mse[i] <- mean(
    (Hitters2$Salary[train] - pred.train)^2
  )

  test.mse[i] <- mean(
    (Hitters2$Salary[test] - pred.test)^2
  )
}

plot(
  lambda,
  train.mse,
  type = "b",
  log = "x",
  xlab = "Shrinkage",
  ylab = "Training MSE"
)

# (d) Produce a plot with different shrinkage values on the x-axis and the
# corresponding test-set MSE on the y-axis.
plot(
  lambda,
  test.mse,
  type = "b",
  log = "x",
  xlab = "Shrinkage",
  ylab = "Test MSE"
)
best.lambda <- lambda[
  which.min(test.mse)
]
best.lambda
min(test.mse)
# (e) Compare the test MSE of boosting to the test MSE that results from
# applying two of the regression approaches seen in Chapters 3 and 6.
lm.fit <- lm(
  Salary ~ .,
  data = Hitters2[train, ]
)

lm.pred <- predict(
  lm.fit,
  Hitters2[test, ]
)

mse.lm <- mean(
  (Hitters2$Salary[test] - lm.pred)^2
)

mse.lm


# Ridge Regression

x <- model.matrix(
  Salary ~ .,
  data = Hitters2
)[, -1]

y <- Hitters2$Salary

set.seed(1)

cv.ridge <- cv.glmnet(
  x[train, ],
  y[train],
  alpha = 0
)

ridge.pred <- predict(
  cv.ridge,
  newx = x[test, ],
  s = "lambda.min"
)

mse.ridge <- mean(
  (y[test] - ridge.pred)^2
)

mse.ridge

c(
  Boosting = min(test.mse),
  Linear = mse.lm,
  Ridge = mse.ridge
)


# (f) Which variables appear to be the most important predictors in the
# boosted model?
set.seed(1)

boost.best <- gbm(
  Salary ~ .,
  data = Hitters2[train, ],
  distribution = "gaussian",
  n.trees = 1000,
  interaction.depth = 4,
  shrinkage = best.lambda,
  verbose = FALSE
)

importance.boost <- summary(
  boost.best,
  plotit = FALSE
)

head(importance.boost)
# (g) Now apply bagging to the training set. What is the test-set MSE for this
# approach?
p <- ncol(Hitters2) - 1

set.seed(1)

bag.hitters <- randomForest(
  Salary ~ .,
  data = Hitters2[train, ],
  mtry = p
)

bag.pred <- predict(
  bag.hitters,
  Hitters2[test, ]
)

mse.bag <- mean(
  (Hitters2$Salary[test] - bag.pred)^2
)

mse.bag

c(
  Boosting = min(test.mse),
  Bagging = mse.bag
)

# 第 11 题
# This question uses the Caravan data set.
#
# (a) Create a training set consisting of the first 1,000 observations, and a
# test set consisting of the remaining observations.
Caravan2 <- Caravan

Caravan2$Purchase01 <- ifelse(
  Caravan2$Purchase == "Yes",
  1,
  0
)

Caravan2$Purchase <- NULL

train <- 1:1000
test <- 1001:nrow(Caravan2)


# (b)
set.seed(1)

boost.caravan <- gbm(
  Purchase01 ~ .,
  data = Caravan2[train, ],
  distribution = "bernoulli",
  n.trees = 1000,
  shrinkage = 0.01,
  interaction.depth = 1,
  verbose = FALSE
)

importance.caravan <- summary(
  boost.caravan,
  plotit = FALSE
)

head(importance.caravan)


# (b) Fit a boosting model to the training set with Purchase as the response
# and the other variables as predictors. Use 1,000 trees and a shrinkage value
# of 0.01. Which predictors appear to be the most important?

prob <- predict(
  boost.caravan,
  Caravan2[test, ],
  n.trees = 1000,
  type = "response"
)
pred <- ifelse(
  prob > 0.2,
  "Yes",
  "No"
)
actual <- Caravan$Purchase[test]
confusion <- table(
  Predicted = pred,
  Actual = actual
)

precision.boost <-
  confusion["Yes", "Yes"] /
  sum(confusion["Yes", ])

precision.boost
# (c) Use the boosting model to predict the response on the test data. Predict
# that a person will make a purchase if the estimated probability of purchase
# is greater than 20%. Form a confusion matrix. What fraction of the people
# predicted to make a purchase do in fact make one? How does this compare with
# the results obtained from applying KNN or logistic regression to this data
# set?
prob <- predict(
  boost.caravan,
  Caravan2[test, ],
  n.trees = 1000,
  type = "response"
)
pred <- ifelse(
  prob > 0.2,
  "Yes",
  "No"
)
actual <- Caravan$Purchase[test]
confusion <- table(
  Predicted = pred,
  Actual = actual
)
precision.boost <-
  confusion["Yes", "Yes"] /
  sum(confusion["Yes", ])

# 第 12 题
# Apply boosting, bagging, random forests, and BART to a data set of your choice.
# Be sure to fit the models on a training set and to evaluate their performance
# on a test set. How accurate are the results compared to simple methods like
# linear or logistic regression? Which of these approaches yields the best
# performance?