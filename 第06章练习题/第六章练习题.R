library(ISLR2)
names(Hitters)
dim(Hitters)
sum(is.na(Hitters$Salary))
Hitters <- na.omit(Hitters)

library(leaps)
regfit_full <- regsubsets(Salary ~ ., Hitters) 
summary(regfit_full)
regfit_full <- regsubsets(Salary ~ ., data = Hitters, nvmax = 19)
reg_summary <- summary(regfit_full)
plot(
  x = 1 : 19,
  y = reg_summary$rsq)
which.max(reg_summary$adjr2)
which.min(reg_summary$cp)

par(mfrow = c(2, 2))
plot(reg_summary$rss, xlab = "Number of Variables",ylab = "RSS", type = "l")
plot(reg_summary$adjr2, xlab = "Number of Variables",ylab = "Adjusted RSq", type = "l")
points(11, reg_summary$adjr2[11], col = "red", cex = 2,
pch = 20)
plot(reg_summary$cp, xlab = "Number of Variables",
ylab = "Cp", type = "l")
plot(reg_summary$cp, xlab = "Number of Variables", ylab = "Adjusted Rsq", type = "l")
points(10, reg_summary$cp[10], col = "red", cex = 2, pch = 20)
plot(reg_summary$bic, xlab = "Number of Variables", ylab = "Adjusted Rsq", type = "l")
points(6, reg_summary$bic[6], col = "red", pch = 20)

regfit_fwd <- regsubsets(Salary ~ ., data = Hitters, nvmax = 19, method = "forward")
summary(regfit_fwd)

regfit_bwd <- regsubsets(Salary ~ ., data = Hitters, nvmax = 19, method = "backward")
summary(regfit_bwd)

coef(regfit_full, 7)
coef(regfit_fwd, 7)
coef(regfit_bwd, 7)

set.seed(1)
train <- sample(c(TRUE, FALSE), nrow(Hitters), replace = TRUE)
test <- (!train)

regfit.best <- regsubsets(Salary ~ .,
data = Hitters[train, ], nvmax = 19)
test.mat <- model.matrix(Salary ~ ., data = Hitters[test, ])

val.errors <- rep(NA, 19)
for (i in 1:19){
  coefi <- coef(regfit.best, id = i)
  pred <- test.mat[ , names(coefi)] %*% coefi
  val.errors[i] <- mean((Hitters$Salary[test] - pred)^2)
}
which.min(val.errors)

predict.regsubsets <- function(object, newdata , id, ...) {
form <- as.formula(object$call[[2]])
mat <- model.matrix(form, newdata)
coefi <- coef(object, id = id)
xvars <- names(coefi)
mat[, xvars] %*% coefi
}

regfit.best <- regsubsets(Salary ~ ., data = Hitters, nvmax = 19)

x <- model.matrix(Salary ~ .,Hitters)[ , -1]
y <- Hitters$Salary
library(glmnet)
install.packages("glmnet")
grid <- 10^seq(10, -2, length = 100)
ridge_mod <- glmnet(x, y, alpha = 0, lambda = grid)
summary(ridge_mod)
coef(ridge_mod)[ ,50]
predict(ridge_mod, s = 50, type = "coefficients")

set.seed(1)
train <- sample(1:nrow(x), nrow(x) / 2)
test <- (-train)
y.test <- y[test]
ridge.mod <- glmnet(
  x[train, ],
  y[train],
  alpha = 0,
  lambda = grid,
  control = list(thresh = 1e-12)
)

ridge.pred <- predict(ridge.mod, s = 4, newx = x[test, ])
mean((ridge.pred - y.test)^2)

set.seed(1)

cv.out <- cv.glmnet(x[train, ], y[train], alpha = 0)
plot(cv.out)
bestlam <- cv.out$lambda.min

lasso.mod <- glmnet(x[train, ], y[train], alpha = 1, lambda = grid)
windows()
cv.out <- cv.glmnet(x[train, ], y[train], alpha = 1)
plot(cv.out)

install.packages("pls")
library(pls)
set.seed(2)

pcr.fit <- pcr(Salary ~ ., data = Hitters, scale = TRUE, validation = "CV")
summary(pcr.fit)
validationplot(pcr.fit, val.type = "MSEP")

set.seed(1)
pcr.fit <- pcr(Salary ~ ., data = Hitters, subset = train, scale = TRUE, validation = "CV")


# 第 1 题
# We perform best subset, forward stepwise, and backward stepwise selection on a
# single data set. For each approach, we obtain p + 1 models, containing 0, 1,
# 2, ..., p predictors. Explain your answers:
#
# (a) Which of the three models with k predictors has the smallest training RSS?
# 我认为是best subset
# (b) Which of the three models with k predictors has the smallest test RSS?
# 这我真不知道，你只能说选出来的可能是不同的变量，但是真不晓得匹配程度怎么样，没有数据的话。
# (c) True or False:
#     i.   The predictors in the k-variable model identified by forward stepwise
#          are a subset of the predictors in the (k + 1)-variable model identified
#          by forward stepwise selection. True 
#     ii.  The predictors in the k-variable model identified by backward stepwise
#          are a subset of the predictors in the (k + 1)-variable model identified
#          by backward stepwise selection. True
#     iii. The predictors in the k-variable model identified by backward stepwise
#          are a subset of the predictors in the (k + 1)-variable model identified
#          by forward stepwise selection. False，这两个没有必然的联系吧
#     iv.  The predictors in the k-variable model identified by forward stepwise
#          are a subset of the predictors in the (k + 1)-variable model identified
#          by backward stepwise selection. False
#     v.   The predictors in the k-variable model identified by best subset are a
#          subset of the predictors in the (k + 1)-variable model identified by
#          best subset selection. False

# 第 2 题
# For parts (a) through (c), indicate which of i. through iv. is correct.
# Justify your answer.
#
# (a) The lasso, relative to least squares, is:
#     i.   More flexible and hence will give improved prediction accuracy when its
#          increase in bias is less than its decrease in variance. False
#     ii.  More flexible and hence will give improved prediction accuracy when its
#          increase in variance is less than its decrease in bias. False
#     iii. Less flexible and hence will give improved prediction accuracy when its
#          increase in bias is less than its decrease in variance. True
#     iv.  Less flexible and hence will give improved prediction accuracy when its
#          increase in variance is less than its decrease in bias. False
#
# (b) Repeat (a) for ridge regression relative to least squares.
# False
# False
# True
# False
# (c) Repeat (a) for non-linear methods relative to least squares.
# False
# True
# False
# False

# 第 3 题
# Suppose we estimate the regression coefficients in a linear regression model by
# minimizing
#
#     sum_{i=1}^n (y_i - beta_0 - sum_{j=1}^p beta_j x_ij)^2
#
# subject to
#
#     sum_{j=1}^p |beta_j| <= s
#
# for a particular value of s. For parts (a) through (e), indicate which of i.
# through v. is correct. Justify your answer.
#
# (a) As we increase s from 0, the training RSS will:
#     i.   Increase initially, and then eventually start decreasing in an inverted
#          U shape. 
#     ii.  Decrease initially, and then eventually start increasing in a U shape.
#     iii. Steadily increase. 
#     iv.  Steadily decrease. True
#     v.   Remain constant.
#
# (b) Repeat (a) for test RSS.
#  Decrease initially, and then eventually start increasing in a U shape.

# (c) Repeat (a) for variance.
# increase

# (d) Repeat (a) for (squared) bias.
# decrease

# (e) Repeat (a) for the irreducible error.
# Remain constant

# 第 4 题
# Suppose we estimate the regression coefficients in a linear regression model by
# minimizing
#
#     sum_{i=1}^n (y_i - beta_0 - sum_{j=1}^p beta_j x_ij)^2
#     + lambda * sum_{j=1}^p beta_j^2
#
# for a particular value of lambda. For parts (a) through (e), indicate which of
# i. through v. is correct. Justify your answer.
#
# (a) As we increase lambda from 0, the training RSS will:
#     i.   Increase initially, and then eventually start decreasing in an inverted
#          U shape.
#     ii.  Decrease initially, and then eventually start increasing in a U shape.
#     iii. Steadily increase. iii 
#     iv.  Steadily decrease.
#     v.   Remain constant.
#
# (b) Repeat (a) for test RSS.
# ii

# (c) Repeat (a) for variance.
#  iv

# (d) Repeat (a) for (squared) bias.
# iii

# (e) Repeat (a) for the irreducible error.
# v

# 第 5 题
# It is well-known that ridge regression tends to give similar coefficient values
# to correlated variables, whereas the lasso may give quite different coefficient
# values to correlated variables. We will now explore this property in a very
# simple setting.
#
# Suppose that n = 2, p = 2, x_11 = x_12, and x_21 = x_22. Furthermore, suppose
# that y_1 + y_2 = 0, x_11 + x_21 = 0, and x_12 + x_22 = 0, so that the estimate
# for the intercept in a least squares, ridge regression, or lasso model is zero:
# beta_hat_0 = 0.
#
# (a) Write out the ridge regression optimization problem in this setting.
# 2 * (y - x*(beta1 + beta2))^2 + lambda * (beta1^2 + beta2^2)

# (b) Argue that in this setting, the ridge coefficient estimates satisfy
#     beta_hat_1 = beta_hat_2.
# 2*lambda*(beta1 - beta2) = 0  beta1 = beta2

# (c) Write out the lasso optimization problem in this setting.
# 2 * (y - x*(beta1 + beta2))^2 + lambda * (abs(beta1) + abs(beta2))

# (d) Argue that in this setting, the lasso coefficients beta_hat_1 and beta_hat_2
#     are not unique—in other words, there are many possible solutions to the
#     optimization problem in (c). Describe these solutions.
# 假设最优时：
# beta1 + beta2 = c
# 如果 c > 0，
# 只要 beta1 >= 0, beta2 >= 0，
# 并且 beta1 + beta2 = c，

# 第 6 题

# We will now explore (6.12) and (6.13) further.
#
# (a) Consider (6.12) with p = 1. For some choice of y_1 and lambda > 0, plot
#     (6.12) as a function of beta_1. Your plot should confirm that (6.12) is
#     solved by (6.14).
y1 <- 2
lambda <- 1
beta1 <- seq(-2, 4, length = 1000)
ridge_obj <- (y1 - beta1)^2 + lambda * beta1^2
plot(beta1, ridge_obj, type = "l",
     xlab = "beta1",
     ylab = "Objective Function",
     main = "Ridge")
beta_ridge <- y1 / (1 + lambda)
abline(v = beta_ridge, lty = 2)

# (b) Consider (6.13) with p = 1. For some choice of y_1 and lambda > 0, plot
#     (6.13) as a function of beta_1. Your plot should confirm that (6.13) is
#     solved by (6.15).
lasso_obj <- (y1 - beta1)^2 + lambda * abs(beta1)
plot(beta1, lasso_obj, type = "l",
     xlab = "beta1",
     ylab = "Objective Function",
     main = "Lasso")
if (y1 > lambda / 2) {
  beta_lasso <- y1 - lambda / 2
} else if (y1 < -lambda / 2) {
  beta_lasso <- y1 + lambda / 2
} else {
  beta_lasso <- 0
}
abline(v = beta_lasso, lty = 2)


# 第 7 题
# We will now derive the Bayesian connection to the lasso and ridge regression
# discussed in Section 6.2.2.
#
# (a) Suppose that y_i = beta_0 + sum_{j=1}^p x_ij beta_j + epsilon_i, where
#     epsilon_1, ..., epsilon_n are independent and identically distributed from
#     an N(0, sigma^2) distribution. Write out the likelihood for the data.
# L(beta) ∝ exp(-RSS / (2*sigma^2))

# (b) Assume the following prior for beta: beta_1, ..., beta_p are independent and
#     identically distributed according to a double-exponential distribution with
#     mean 0 and common scale parameter b; i.e., p(beta) = (1 / (2b)) *
#     exp(-|beta| / b). Write out the posterior for beta in this setting.
# p(beta) ∝ exp( -1/b * sum_j(abs(betaj)))


# (c) Argue that the lasso estimate is the mode for beta under this posterior
#     distribution.
# posterior mode 的意思是找到让 posterior 最大的 beta。
# 最大化 posterior等价于最大化 log(posterior)
# 也等价于最小化 negative log posterior。
# 所以需要最小化RSS/(2*sigma^2) + 1/b * sum_j(abs(betaj))
# 整个目标函数乘以 2*sigma^2，不会改变最优 beta 的位置。
# 因此等价于最小化RSS + (2*sigma^2/b) * sum_j(abs(betaj))
# 令lambda = 2*sigma^2 / b
# 得到RSS + lambda * sum_j(abs(betaj))
# 这正是 Lasso 的目标函数。所以Lasso estimate = posterior mode

# (d) Now assume the following prior for beta: beta_1, ..., beta_p are independent
#     and identically distributed according to a normal distribution with mean zero
#     and variance c. Write out the posterior for beta in this setting.

posterior ∝ exp[-RSS/(2*sigma^2) - sum(beta_j^2)/(2*c)]

# (e) Argue that the ridge regression estimate is both the mode and the mean for
#     beta under this posterior distribution.
# 最大化 posterior 等价于最小化 RSS + lambda * sum(beta_j^2)，即 Ridge
# 又因为 posterior 是 Gaussian，所以 posterior mean = mode = Ridge estimate

# 第 8 题（Applied）

# In this exercise, we will generate simulated data, and will then use this data
# to perform best subset selection.
#
# (a) Use the rnorm() function to generate a predictor X of length n = 100, as well
#     as a noise vector epsilon of length n = 100.
epsilon <- rnorm(100)
# (b) Generate a response vector Y of length n = 100 according to the model
x <- 1 :100
y <- 2 + 3*x + 4*(x^2) +5*(x^3) 
#     Y = beta_0 + beta_1 X + beta_2 X^2 + beta_3 X^3 + epsilon,
#
#     where beta_0, beta_1, beta_2, and beta_3 are constants of your choice.
#
# (c) Use the regsubsets() function to perform best subset selection in order to
#     choose the best model containing the predictors X, X^2, ..., X^10. What is
#     the best model obtained according to C_p, BIC, and adjusted R^2? Show plots
#     to provide evidence for your answer, and report the coefficients of the best
#     model obtained. Note: you will need to use data.frame() to create a single
#     data set containing both X and Y.
data <- data.frame(x = x, y = y)
subset_model <- regsubsets(y ~ poly(x, 10, raw = TRUE), data = data, nvmax = 10)
subset_summary <- summary(subset_model)

which.min(subset_summary$cp)
which.min(subset_summary$bic)
which.max(subset_summary$adjr2)
dev.off()
windows()
par(mfrow = c(2,2))
plot(subset_summary$cp, type = "b")
plot(subset_summary$bic, type = "b")
plot(subset_summary$adjr2, type = "b")

# (d) Repeat (c), using forward stepwise selection and also using backward stepwise
#     selection. How does your answer compare to the results in (c)?
fwd_model <- regsubsets(y ~ poly(x, 10, raw = TRUE), data = data, nvmax = 10, method = "forward")
bwd_model <- regsubsets(y ~ poly(x, 10, raw = TRUE), data = data, nvmax = 10, method = "backward")
fwd_summary <- summary(fwd_model)
bwd_summary <- summary(bwd_model)
par(mfrow = c(3,2))
plot(fwd_summary$cp, type = "b")
plot(bwd_summary$cp, type = "b")
plot(fwd_summary$bic, type = "b")
plot(bwd_summary$bic, type = "b")
plot(fwd_summary$adjr2, type = "b")
plot(bwd_summary$adjr2, type = "b")


# (e) Now fit a lasso model to the simulated data, again using X, X^2, ..., X^10 as
#     predictors. Use cross-validation to select the optimal value of lambda.
#     Create plots of the cross-validation error as a function of lambda. Report
#     the resulting coefficient estimates, and discuss the results obtained.
x_mat <- model.matrix(~ poly(x, 10, raw = TRUE))[, -1]

set.seed(1)
dev.off()
windows()
cv_lasso <- cv.glmnet(x_mat, y, alpha = 1)
plot(cv_lasso)

best_lambda <- cv_lasso$lambda.min
coef(cv_lasso, s = "lambda.min")

# (f) Now generate a response vector Y according to the model
#
#     Y = beta_0 + beta_7 X^7 + epsilon,
#
#     and perform best subset selection and the lasso. Discuss the results obtained.

# 重新生成 response
beta_0 <- 1
beta_7 <- 2
eps <- rnorm(length(x))

y_2 <- beta_0 + beta_7 * x^7 + eps

data_2 <- data.frame(x = x, y2 = y_2)

best_2 <- regsubsets(
  y_2 ~ poly(x, 10, raw = TRUE),
  data = data_2,
  nvmax = 10
)

best_2sum <- summary(best_2)

which.min(best_2sum$cp)
which.min(best_2sum$bic)
which.max(best_2sum$adjr2)

# 例如查看 BIC 选出的模型
coef(best2, id = which.min(best2_sum$bic))


# Lasso
x_mat2 <- model.matrix(
  ~ poly(x, 10, raw = TRUE),
  data = data_2
)[, -1]

set.seed(1)

cv_lasso2 <- cv.glmnet(
  x_mat2,
  y_2,
  alpha = 1
)

plot(cv_lasso2)

best_lambda2 <- cv_lasso2$lambda.min
best_lambda2

coef(cv_lasso2, s = "lambda.min")

# 第 9 题

# In this exercise, we will predict the number of applications received using the
# other variables in the College data set.

# (a) Split the data set into a training set and a test set.
library(ISLR2)
library(glmnet)
library(pls)
set.seed(1)

x <- model.matrix(App ~ ., data = College)[, -1]
y <- College$Apps

train <- sample(
  1:nrow(College),
  nrow(College) / 2
)

test <- -train

# (b) Fit a linear model using least squares on the training set, and report the
#     test error obtained.

lm.fit <- lm(
  Apps ~.,
  data = College,
  subset = train
)

lm.pred <- predict(
  lm.fit,
  newdata = College[test, ]
)

mean((College$Apps[test] - lm.pred)^2)

# (c) Fit a ridge regression model on the training set, with lambda chosen by
#     cross-validation. Report the test error obtained.
set.seed(1)
cv.ridge <- cv.glmnet(x[train, ], y[train], alpha = 0)
best.ridge.lambda <- cv.ridge$lambda.min
ridge.pred <- predict(cv.ridge, s = "lambda.min", newx = x[test, ])
ridge.test.mse <- mean((y[test] - ridge.pred)^2)
best.ridge.lambda
ridge.test.mse

# (d) Fit a lasso model on the training set, with lambda chosen by cross-validation.
#     Report the test error obtained, along with the number of non-zero coefficient
#     estimates.

cvset.seed(1)
cv.lasso <- cv.glmnet(x[train, ], y[train], alpha = 1)
best.lasso.lambda <- cv.lasso$lambda.min
lasso.pred <- predict(cv.lasso, s = "lambda.min", newx = x[test, ])
lasso.test.mse <- mean((y[test] - lasso.pred)^2)
lasso.coef <- coef(cv.lasso, s = "lambda.min")
lasso.nonzero <- sum(lasso.coef[-1, ] != 0)
best.lasso.lambda
lasso.test.mse
lasso.nonzero

# (e) Fit a PCR model on the training set, with M chosen by cross-validation.
#     Report the test error obtained, along with the value of M selected by
#     cross-validation.

set.seed(1)
pcr.fit <- pcr(Apps ~ ., data = College, subset = train, scale = TRUE, validation = "CV")
pcr.rmsep <- RMSEP(pcr.fit, estimate = "CV")$val[1, 1, -1]
best.pcr.M <- which.min(pcr.rmsep)
pcr.pred <- predict(pcr.fit, newdata = College[test, ], ncomp = best.pcr.M)
pcr.test.mse <- mean((College$Apps[test] - pcr.pred)^2)
best.pcr.M
pcr.test.mse

# (f) Fit a PLS model on the training set, with M chosen by cross-validation.
#     Report the test error obtained, along with the value of M selected by
#     cross-validation.
set.seed(1)
pls.fit <- plsr(Apps ~ ., data = College, subset = train, scale = TRUE, validation = "CV")
pls.rmsep <- RMSEP(pls.fit, estimate = "CV")$val[1, 1, -1]
best.pls.M <- which.min(pls.rmsep)
pls.pred <- predict(pls.fit, newdata = College[test, ], ncomp = best.pls.M)
pls.test.mse <- mean((College$Apps[test] - pls.pred)^2)
best.pls.M
pls.test.mse

# (g) Comment on the results obtained. How accurately can we predict the number of
#     college applications received? Is there much difference among the test errors
#     resulting from these five approaches?

# 第 10 题

# We have seen that as the number of features used in a model increases, the
# training error will necessarily decrease, but the test error may not. We will now
# explore this in a simulated data set.
#
# (a) Generate a data set with p = 20 features, n = 1,000 observations, and an
#     associated quantitative response vector generated according to the model
#
#     Y = X beta + epsilon,
#
#     where beta has some elements that are exactly equal to zero.
set.seed(1)
n <- 1000
p <- 20
X <- matrix(rnorm(n * p), nrow = n, ncol = p)
beta <- c(3, 2, -2, 1.5, -1, rep(0, 15))
eps <- rnorm(n, sd = 2)
Y <- X %*% beta + eps
data <- data.frame(Y = as.vector(Y), X)

# (b) Split your data set into a training set containing 100 observations and a
#     test set containing 900 observations.
set.seed(1)
train <- sample(1:n, 100)
test <- -train

# (c) Perform best subset selection on the training set, and plot the training-set
#     MSE associated with the best model of each size.
regfit <- regsubsets(Y ~ ., data = data[train, ], nvmax = 20, method = "exhaustive")
reg.summary <- summary(regfit)
train.mse <- reg.summary$rss / length(train)
plot(1:20, train.mse, type = "b", xlab = "Number of Predictors", ylab = "Training MSE")


# (d) Plot the test-set MSE associated with the best model of each size.
test.mat <- model.matrix(Y ~ ., data = data[test, ])
test.mse <- rep(NA, 20)
for(i in 1:20){coefi <- coef(regfit, id = i); pred <- test.mat[, names(coefi)] %*% coefi; test.mse[i] <- mean((data$Y[test] - pred)^2)}
plot(1:20, test.mse, type = "b", xlab = "Number of Predictors", ylab = "Test MSE")

# (e) For which model size does the test-set MSE take on its minimum value? Comment
#     on your results. If it takes on its minimum value for a model containing only
#     an intercept or a model containing all of the features, then adjust the data
#     generation in (a) until the test-set MSE is minimized for an intermediate
#     model size.
best.size <- which.min(test.mse)
best.size
min(test.mse)


# (f) How does the model at which the test-set MSE is minimized compare to the true
#     model used to generate the data? Comment on the coefficient values.
coef(regfit, id = best.size)
beta


# (g) Create a plot displaying
#
#     sum_{j=1}^p (beta_j - beta_hat_j^r)^2
#
#     for a range of values of r, where beta_hat_j^r is the jth coefficient estimate
#     for the best model containing r coefficients. Comment on what you observe. How
#     does this compare to the test MSE plot from (d)?
beta.error <- rep(NA, 20)
for(r in 1:20){
  coef.r <- coef(regfit, id = r)
  beta.hat <- rep(0, 20)
  names(beta.hat) <- paste0("X", 1:20)
  selected <- names(coef.r)[-1]
  beta.hat[selected] <- coef.r[-1]
  beta.error[r] <- sum((beta - beta.hat)^2)
  }
plot(1:20, beta.error, type = "b", xlab = "Number of Predictors", ylab = "Coefficient Estimation Error")
which.min(beta.error)

# 第 11 题

# We will now try to predict per capita crime rate in the Boston data set.
#
# (a) Try out some of the regression methods explored in this chapter, such as best
#     subset selection, the lasso, ridge regression, and PCR. Present and discuss
#     results for the approaches that you consider.
#
# (b) Propose a model (or set of models) that seems to perform well on this data set,
#     and justify your answer. Make sure that you are evaluating model performance
#     using validation-set error, cross-validation, or some other reasonable
#     alternative, as opposed to using training error.
#
# (c) Does your chosen model involve all of the features in the data set? Why or why
#     not?