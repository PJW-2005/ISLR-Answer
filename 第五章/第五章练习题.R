# 第一道题
# Using basic statistical properties of the variance, as well as single-
# variable calculus, derive (5.6). In other words, prove that α given by
# (5.6) does indeed minimize Var(αX + (1 − α)Y).

# Var(alpha*X + (1-alpha)*Y)
# = alpha^2*Var(X) + (1-alpha)^2*Var(Y)
#   + 2*alpha*(1-alpha)*Cov(X,Y)
# = alpha^2*Var(X)
#   + (1 - 2*alpha + alpha^2)*Var(Y)
#   + 2*(alpha - alpha^2)*Cov(X,Y)
# = alpha^2*(Var(X) + Var(Y) - 2*Cov(X,Y))
#   + 2*alpha*(Cov(X,Y) - Var(Y))
#   + Var(Y)
# 求导当为0是出现最小解:
# 2*alpha*(Var(X) + Var(Y) - 2*Cov(X,Y))
# + 2*(Cov(X,Y) - Var(Y)) = 0

# 第二题
# We will now derive the probability that a given observation is part
# of a bootstrap sample. Suppose that we obtain a bootstrap sample
# from a set of n observations.

# (a) What is the probability that the first bootstrap observation is
# not the jth observation from the original sample? Justify your
# answer.

# 1 - 1/n 

# (b) What is the probability that the second bootstrap observation is
# not the jth observation from the original sample?
# 1 - 1/n

# (d) When n = 5, what is the probability that the jth observation is
# in the bootstrap sample?
# 1 - (4/5)^5

# (e) When n = 100, what is the probability that the jth observation
# is in the bootstrap sample?
# 1 - (99/100)^100

# (f) When n = 10,000, what is the probability that the jth observation
# is in the bootstrap sample?
# 1 - (9999/10000)^10000

# (g) Create a plot that displays, for each integer value of n from 1
# to 100,000, the probability that the jth observation is in the
# bootstrap sample. Comment on what you observe.

plot(
    x = 1 :100000,
    y = (1-1/1:100000)^(1:100000),
    type = "l",
    ylim = c(0.35, 0.40),
    xlab = "observation",
    ylab = "probility"
)

# (h) We will now investigate numerically the probability that a boot-
# strap sample of size n = 100 contains the jth observation. Here
# j = 4. We repeatedly create bootstrap samples, and each time we
# record whether or not the fourth observation is contained in the
# bootstrap sample.

store <- rep(NA, 10000)
for(i in 1:10000){
    store[i] <- sum(sample(1:100,100, replace = TRUE) == 4) > 0
}
table(store)

# 第三题
# We now review k-fold cross-validation.
# (a) Explain how k-fold cross-validation is implemented.

# 首先先将数据按照随机抽样的方法分成K个大小一致的子集
# 每次选取其中的一个作为验证集，其他的作为训练集
# 完成训练后，使用验证集进行计算test error。
# 上述流程重复k次，每一次选取不同的集作为验证集计算test error求平均作为最终结果

# (b) What are the advantages and disadvantages of k-fold cross-

# 优点：
# 1.相较于LOOCV可以大幅度的减少计算量
# 2.相较于validation set 这个方法看过了所有的数据集，可以减小方差

# 缺点：
# 相较于LOOCV的数据更少，偏差更大了
# 结果仍然受到随机划分的影响
# 最后还是要计算（k-1）次, 只能用（k-1）/k的数据用来训练



# 第四题
# Suppose that we use some statistical learning method to make a pre-
# diction for the response Y for a particular value of the predictor X.
# Carefully describe how we might estimate the standard deviation of
# our prediction.

# 我可能会考虑从原始数据中有放回抽样，得到一个bootstrap sample
# 然后用bootstrap sample去重新拟合模型、
# 对固定的 X = x0 进行预测，得到 Y_hat_1
# 重复上述过程 B 次，得到：
# Y_hat_1, Y_hat_2, ..., Y_hat_B
# 计算这 B 个预测值的标准差

library(ISLR2)
set.seed(1)
train <- sample(392, 196) 
lm.fit <- lm(mpg ~ horsepower, data = Auto, subset = train)

attach(Auto)
mean((mpg - predict(lm.fit, Auto))[-train]^2) 
library(boot)
glm.fit <- glm(mpg ~ horsepower, data = Auto)
cv.err <- cv.glm(Auto, glm.fit)
summary(cv.err)

cv.error <- rep(0, 10)
for (i in 1:10) {
    glm.fit <- glm(mpg ~ poly(horsepower, i), data = Auto)
    cv.error <- cv.glm(Auto, glm.fit)$delta[1]
}
cv.error

set.seed(17)
cv.error.10 <- rep(0, 10)
for (i in 1:10) {
    glm.fit <- glm(mpg ~ poly(horsepower, i), data = Auto)
    cv.error.10[i] <- cv.glm(Auto, glm.fit, K = 10)$delta[1]
}
print(cv.error.10)

alpha_fn <- function(data, index) {
    X <- data$X[index]
    Y <- data$Y[index]
    (var(Y) - cov(X, Y)) / (var(X) + var(Y) - 2 * cov(X, Y))
}

alpha_fn(Portfolio, 1:100)
set.seed(7)
alpha_fn(Portfolio, sample(100, 100, replace = T))

boot(Portfolio, alpha_fn, R = 1000)
boot_fn <- function(data, index){
    coef(lm(mpg ~ horsepower, data = data, subset = index))
}
boot_fn(Auto, 1:392)
boot(Auto, boot_fn, 1000)
# 第五题

# In Chapter 4, we used logistic regression to predict the probability of
# default using income and balance on the Default data set. We will
# now estimate the test error of this logistic regression model using the
# validation set approach. Do not forget to set a random seed before
# beginning your analysis.
attach(Default)
set.seed(123)
log_lm <- glm(default ~ income + balance, data = Default, family = binomial)
# (a) Fit a logistic regression model that uses income and balance to
# predict default.
# (b) Using the validation set approach, estimate the test error of this
# model. In order to do this, you must perform the following steps:
# i. Split the sample set into a training set and a validation set.
dim(Default)
head(Default)
train <- sample(1:nrow(Default), nrow(Default) / 2)
log_glm <- glm(
    default ~ income + balance,
    data = Default,
    family = binomial,
    subset = train 
)
# ii. Fit a multiple logistic regression model using only the training
# observations.
# iii. Obtain a prediction of default status for each individual in
# the validation set by computing the posterior probability of
# default for that individual, and classifying the individual to
# the default category if the posterior probability is greater
# than 0.5.
prob <- predict(log_glm, Default[-train,], type = "response")

pred <- ifelse(prob > 0.5, "Yes", "No")
table(pred)
mean(pred != Default$default[-train])



# iv. Compute the validation set error, which is the fraction of the
# observations in the validation set that are misclassified.

# (c) Repeat the process in (b) three times, using three different splits
# of the observations into a training set and a validation set. Com
# ment on the results obtained.

for (i in 1:3){
    set.seed(i) 
    train <- sample(1:nrow(Default), nrow(Default) / 2)
    glm_fit <- glm(
        default ~ balance + income, 
        family = binomial,
        data = Default,
        subset = train 
    ) 
    prob <- predict(glm_fit, Default[-train,], type = "response")
    pred <- ifelse(prob > 0.5, "Yes", "No")
    error[i] <- mean(pred != Default$default[-train])

}

# (d) Now consider a logistic regression model that predicts the prob
# ability of default using income, balance, and a dummy variable
# for student. Estimate the test error for this model using the val
# idation set approach. Comment on whether or not including a
# dummy variable for student leads to a reduction in the test error
# rate.

for(i in 1:3){
    set.seed(i)
    train <- sample(1:nrow(Default), nrow(Default)/2)
    glm_fit2 <- glm(
        default ~ income + balance + student,
        data = Default,
        family = binomial,
        subset = train
    )
    prob2 <- predict(glm_fit2, newdata = Default[-train, ], type = "response")
    pred2 <- ifelse(prob2 > 0.5, "Yes", "No")
    error2[i] <- mean(pred2 != Default$default[-train])
}
data.frame(
  without_student = error,
  with_student = error2
)
# 没有显著改善

# 第六题

# We continue to consider the use of a logistic regression model to
# predict the probability of default using income and balance on the
# Default data set. In particular, we will now compute estimates for
# the standard errors of the income and balance logistic regression coef
# ficients in two different ways: (1) using the bootstrap, and (2) using
# the standard formula for computing the standard errors in the glm()
# function. Do not forget to set a random seed before beginning your
# analysis.
set.seed(1)
# (a) Using the summary() and glm() functions, determine the esti
# mated standard errors for the coefficients associated with income
# and balance in a multiple logistic regression model that uses
# both predictors.
log_lm <- glm(default ~ balance + income, family = binomial, data = Default)
summary(log_lm)

# (b) Write a function, boot.fn(), that takes as input the Default data
# set as well as an index of the observations, and that outputs
# the coefficient estimates for income and balance in the multiple
# logistic regression model.

boot_fn <- function(data, index){
    coef(
        glm(
            default ~ income + balance,
            family =  binomial,
            data = data,
            subset = index
        )
    )[c("income", "balance")]
}

# (c) Use the boot() function together with your boot.fn() function to
# estimate the standard errors of the logistic regression coefficients
# for income and balance.

boot(
    Default,
    boot_fn,
    R = 1000
)

# (d) Comment on the estimated standard errors obtained using the
# glm() function and using your bootstrap function.

# Bootstrap 通过对原始数据进行重复有放回抽样，
# 得到大量不同的 beta 估计值，然后计算这些 beta 的标准差，
# 以此估计 beta 的 standard error。
# glm() 则利用最大似然估计，在 beta_hat 附近计算
# log-likelihood 的二阶导数（Hessian / Fisher information），
# 再利用其逆矩阵估计 beta 的方差和 standard error。
# 两种方法的目的相同：
# 都是在估计 beta_hat 如果重新抽样时会有多大的波动，
# 只是 Bootstrap 使用重抽样，glm 使用理论近似。


# 第七题

# In Sections 5.3.2 and 5.3.3, we saw that the cv.glm() function can be
# used in order to compute the LOOCV test error estimate. Alterna
# tively, one could compute those quantities using just the glm() and
# predict.glm() functions, and a for loop. You will now take this ap
# proach in order to compute the LOOCV error for a simple logistic
# regression model on the Weekly data set. Recall that in the context
# of classification problems, the LOOCV error is given in (5.4).

# (a) Fit a logistic regression model that predicts Direction using Lag1
# and Lag2.
attach(Weekly)
log_fit <- glm(Direction ~ Lag1 + Lag2, family = binomial, data = Weekly)

# (b) Fit a logistic regression model that predicts Direction using Lag1
# and Lag2 using all but the first observation.
log_fit2 <- glm(Direction ~ Lag1 + Lag2, family = binomial, data = Weekly, subset = -1)

# (c) Use the model from (b) to predict the direction of the first obser
# vation. You can do this by predicting that the first observation
# will go up if P(Direction = "Up"|Lag1, Lag2) > 0.5. Was this
# observation correctly classified?
pred <- ifelse(
  predict(log_fit2, newdata = Weekly[1, ], type = "response") > 0.5,
  "Up",
  "Down"
)

pred == Weekly$Direction[1]

# (d) Write a for loop from i = 1 to i = n, where n is the number of
# observations in the data set, that performs each of the following
# steps:
LOOCV <- function(data_set, predictor, response){
    formula <- reformulate(predictor, response = response)
    for (i in  1:nrow(data_set)){
        log_fit <- glm(formula, family = binomial, data = data_set, subset = -i)
        prob <- predict(log_fit, data_set[i, ], type = "response")
        pred <- ifelse(prob > 0.5, "Up", "Down")
        error[i] <- ifelse(pred == data_set[[response]][i], 0, 1)
    }
    mean(error)
}
# i. Fit a logistic regression model using all but the ith obser
# vation to predict Direction using Lag1 and Lag2.

# ii. Compute the posterior probability of the market moving up
# for the ith observation.

# iii. Use the posterior probability for the ith observation in order
# to predict whether or not the market moves up.

# iv. Determine whether or not an error was made in predicting
# the direction for the ith observation. If an error was made,
# then indicate this as a 1, and otherwise indicate it as a 0.

# (e) Take the average of the n numbers obtained in (d)iv in order to
# obtain the LOOCV estimate for the test error. Comment on the
# results.

# 第八题

# We will now perform cross-validation on a simulated data set.
# (a) Generate a simulated data set as follows:

set.seed(1)
x <- rnorm(100)
y <- x - 2 * x^2 + rnorm(100)

# In this data set, what is n and what is p? Write out the model
# used to generate the data in equation form.

n = 100
p = 1

# (b) Create a scatterplot of X against Y. Comment on what you find.
plot(x, y, type = "p")

# (c) Set a random seed, and then compute the LOOCV errors that
# result from fitting the following four models using least squares:

# i. Y = β0 + β1X + ε
# ii. Y = β0 + β1X + β2X^2 + ε
# iii. Y = β0 + β1X + β2X^2 + β3X^3 + ε
# iv. Y = β0 + β1X + β2X^2 + β3X^3 + β4X^4 + ε.

# Note you may find it helpful to use the data.frame() function
# to create a single data set containing both X and Y.

# (d) Repeat (c) using another random seed, and report your results.
# Are your results the same as what you got in (c)? Why?
set.seed(1)
data <- data.frame(
    x = x,
    y = y
)
library(boot)
cv.error <- rep(0, 4)

for(i in 1:4){
    fit <- glm(
        y ~ poly(x, i, raw = TRUE),
        data = data
    )

cv.error[i] <- cv.glm(
    data,
    fit
)$delta[1]
}



# (e) Which of the models in (c) had the smallest LOOCV error? Is
# this what you expected? Explain your answer.
print(cv.error)
# 符合很明显二次项有着最小的test error
# (f) Comment on the statistical significance of the coefficient esti
# mates that results from fitting each of the models in (c) using
# least squares. Do these results agree with the conclusions drawn
# based on the cross-validation results?

# 第九题

# We will now consider the Boston housing data set, from the ISLR2
# library.

# (a) Based on this data set, provide an estimate for the population
# mean of medv. Call this estimate μ̂.

# (b) Provide an estimate of the standard error of μ̂. Interpret this
# result.
# Hint: We can compute the standard error of the sample mean by
# dividing the sample standard deviation by the square root of the
# number of observations.

# (c) Now estimate the standard error of μ̂ using the bootstrap. How
# does this compare to your answer from (b)?

# (d) Based on your bootstrap estimate from (c), provide a 95 %
# confidence interval for the mean of medv. Compare it to the
# results obtained using t.test(Boston$medv).
# Hint: You can approximate a 95 % confidence interval using the
# formula [μ̂ − 2SE(μ̂), μ̂ + 2SE(μ̂)].

# (e) Based on this data set, provide an estimate, μ̂med, for the median
# value of medv in the population.

# (f) We now would like to estimate the standard error of μ̂med. Unfor
# tunately, there is no simple formula for computing the standard
# error of the median. Instead, estimate the standard error of the
# median using the bootstrap. Comment on your findings.

# (g) Based on this data set, provide an estimate for the tenth per
# centile of medv in Boston census tracts. Call this quantity μ̂0.1.

# (You can use the quantile() function.)
# (h) Use the bootstrap to estimate the standard error of μ̂0.1. Com
# ment on your findings.





