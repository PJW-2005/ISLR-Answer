library(ISLR2)
attach(Wage)

fit <- lm(wage ~ poly(age, 4), data = Wage)
coef(summary(fit))
fit2 <- lm(wage ~ poly(age, 4, raw = T), data = Wage)
coef(summary(fit2))
fit2a <- lm(wage ~ age + I(age^2) + I(age^3) + I(age^4), data = Wage)
fit2b <- lm(wage ~ cbind(age, age^2, age^3, age^4), data = Wage)
agelims <- range(age)
print(agelims)
age.grid <- seq(from = agelims[1], to = agelims[2])
print(age.grid)
plot(age.grid)
preds <- predict(fit, newdata = list(age = age.grid), se = TRUE)
print(preds)
se.bands <- cbind(preds$fit + 2 * preds$se.fit, preds$fit - 2 * preds$se.fit)
par(mfrow = c(1, 2), mar = c(4.5, 4.5, 1, 1), oma = c(0, 0, 4, 0))
plot(age, wage, xlim = agelims, cex = .5, col = "darkgrey")
title("Degree -4 Polynomial", outer = T)
lines(age.grid, preds$fit, lwd = 2, col = "blue")
matlines(age.grid, se.bands, lwd = 1, col = "blue", lty = 3)
preds2 <- predict(fit2, newdata = list(age = age.grid),
se = TRUE)
max(abs(preds$fit - preds2$fit))
fit.1 <- lm(wage ~ age, data = Wage)
fit.2 <- lm(wage ~ poly(age, 2), data = Wage)
fit.3 <- lm(wage ~ poly(age, 3), data = Wage)
fit.4 <- lm(wage ~ poly(age, 4), data = Wage)
fit.5 <- lm(wage ~ poly(age, 5), data = Wage)
anova(fit.1, fit.2, fit.3, fit.4, fit.5)

fit.1 <- lm(wage ~ education + age, data = Wage)
fit.2 <- lm(wage ~ education + poly(age, 2), data = Wage)
fit.3 <- lm(wage ~ education + poly(age, 3), data = Wage)
anova(fit.1, fit.2, fit.3)

fit <- glm(I(wage > 250) ~ poly(age, 4), data = Wage,
family = binomial)
preds <- predict(fit, newdata = list(age = age.grid), se = T)
pfit <- exp(preds$fit) / (1 + exp(preds$fit))
se.bands.logit <- cbind(preds$fit + 2 * preds$se.fit,
preds$fit - 2 * preds$se.fit)
se.bands <- exp(se.bands.logit) / (1 + exp(se.bands.logit))

preds <- predict(fit, newdata = list(age = age.grid),
type = "response", se = T)


plot(age, I(wage > 250), xlim = agelims, type = "n", ylim = c(0, .2))
points(jitter(age), I((wage > 250) / 5), cex = .5, pch = "|", col
= "darkgrey")
lines(age.grid, pfit, lwd = 2, col = "blue")
matlines(age.grid, se.bands, lwd = 1, col = "blue", lty = 3)

table(cut(age, 4))

fit <- lm(wage ~ cut(age, 4), data = Wage) coef(summary(fit))
Estimate Std. Error t value Pr(>|t|)
(Intercept) 94.16 1.48 63.79 0.00e+00
cut(age, 4)(33.5,49] 24.05 1.83 13.15 1.98e-38
cut(age, 4)(49,64.5] 23.66 2.07 11.44 1.04e-29

table(cut(age, 4))
fit <- lm(wage ~ cut(age, 4), data = Wage)
coef(summary(fit))

library(splines)
fit <- lm(wage ~ bs(age, knots = c(25, 40, 60 )), data = Wage)
pred <- predict(fit, newdata = list(age = age.grid), se = T)
plot(age, wage, col = "gray")
lines(age.grid, pred$fit, lwd = 2)
lines(age.grid, pred$fit + 2 * pred$se, lty = "dashed")
lines(age.grid, pred$fit - 2 * pred$se, lty = "dashed")
summary(fit)
attr(bs(age, df = 6), "knots")
fit2 <- lm(wage ~ ns(age, df = 4), data = Wage)
pred2 <- predict(fit2, newdata = list(age = age.grid), se = T)
lines(age.grid, pred2$fit, col = "red", lwd = 2)

gam1 <- lm(wage ~ )

# 第 1 题
# It was mentioned in the chapter that a cubic regression spline with one knot
# at ξ can be obtained using a basis of the form x, x^2, x^3, (x - ξ)^3_+,
# where (x - ξ)^3_+ = (x - ξ)^3 if x > ξ and equals 0 otherwise.
# We will now show that a function of the form
#
# f(x) = β0 + β1*x + β2*x^2 + β3*x^3 + β4*(x - ξ)^3_+
#
# is indeed a cubic regression spline, regardless of the values of
# β0, β1, β2, β3, and β4.
#
# (a) Find a cubic polynomial
#
# f1(x) = a1 + b1*x + c1*x^2 + d1*x^3
#
# such that f(x) = f1(x) for all x <= ξ. Express a1, b1, c1, and d1 in
# terms of β0, β1, β2, β3, and β4.
# 当 x <= ξ 时，(x-ξ)^3_+ = 0
# 因此：
# f1(x) = β0 + β1*x + β2*x^2 + β3*x^3
# 所以：
# a1 = β0；b1 = β1；c1 = β2；d1 = β3

# (b) Find a cubic polynomial
# f2(x) = a2 + b2*x + c2*x^2 + d2*x^3
# such that f(x) = f2(x) for all x > ξ. Express a2, b2, c2, and d2 in
# terms of β0, β1, β2, β3, and β4. We have now established that f(x) is
# a piecewise polynomial.

# 当 x > ξ 时：
# f2(x) = β0 + β1*x + β2*x^2 + β3*x^3 + β4*(x-ξ)^3
# 展开：
# (x-ξ)^3 = x^3 - 3ξ*x^2 + 3ξ^2*x - ξ^3
# 所以：
# a2 = β0 - β4*ξ^3；b2 = β1 + 3*β4*ξ^2；c2 = β2 - 3*β4*ξ；d2 = β3 + β4

# (c) Show that f1(ξ) = f2(ξ). That is, f(x) is continuous at ξ.
# 将 x=ξ 代入 f1 和 f2：
# f1(ξ) = f2(ξ)
# 因此函数在 knot ξ 处连续。


# (d) Show that f1'(ξ) = f2'(ξ). That is, f'(x) is continuous at ξ.
# f1'(x) = β1 + 2β2*x + 3β3*x^2
# f2'(x) = f1'(x) + 3β4*(x-ξ)^2
# x=ξ 时：
# f1'(ξ) = f2'(ξ)
# 因此一阶导连续。

# (e) Show that f1''(ξ) = f2''(ξ). That is, f''(x) is continuous at ξ.
# Therefore, f(x) is indeed a cubic spline.
# f1''(x) = 2β2 + 6β3*x
# f2''(x) = f1''(x) + 6β4*(x-ξ)
# x=ξ 时：
# f1''(ξ) = f2''(ξ)
# 因此二阶导连续。所以 f(x) 是 cubic regression spline。


# Hint: Parts (d) and (e) require knowledge of single-variable calculus.
# Given
#
# f1(x) = a1 + b1*x + c1*x^2 + d1*x^3,
#
# the first and second derivatives are
#
# f1'(x)  = b1 + 2*c1*x + 3*d1*x^2,
# f1''(x) = 2*c1 + 6*d1*x.

# 第 2 题
# Suppose that a curve g_hat is computed to smoothly fit a set of n points
# using the following formula:
#
# g_hat = arg min_g { sum(i = 1 to n) (y_i - g(x_i))^2
#                     + λ * integral [g^(m)(x)]^2 dx },
#
# where g^(m) represents the mth derivative of g, and g^(0) = g.
# Provide example sketches of g_hat in each of the following scenarios.
#
# (a) λ = Inf, m = 0.
# λ = Inf, m = 0
# 惩罚 g(x)^2，因此 g(x)=0。

# (b) λ = Inf, m = 1.
# (b) λ = Inf, m = 1
# 要求 g'(x)=0，因此 g(x) 为常数。

# (c) λ = Inf, m = 2.
# λ = Inf, m = 2
# 要求 g''(x)=0，因此 g(x) 为直线。

# (d) λ = Inf, m = 3.
# λ = Inf, m = 3
# 要求 g'''(x)=0，因此 g(x) 为二次函数。

# (e) λ = 0, m = 3.
# λ = 0, m = 3
# 没有平滑惩罚，只最小化 training RSS。
# 曲线会非常灵活，尽量穿过所有训练点，容易过拟合。

# 第 3 题
# Suppose we fit a curve with basis functions
# b1(X) = X,
# b2(X) = (X - 1)^2 * I(X >= 1).
# Note that I(X >= 1) equals 1 for X >= 1 and 0 otherwise. We fit the
# linear regression model
# Y = β0 + β1*b1(X) + β2*b2(X) + ε,
# and obtain coefficient estimates β0_hat = 1, β1_hat = 1, and β2_hat = -2.
# Sketch the estimated curve between X = -2 and X = 2. Note the intercepts,
# slopes, and other relevant information.

x <- seq(-2, 2, length = 200)
y <- 1 + x - 2 * (x - 1)^2 * (x >= 1)
plot(x, y, type = "l", lwd = 2,
     xlab = "X", ylab = "Y_hat")
abline(v = 1, lty = 2)

# 第 4 题
# Suppose we fit a curve with basis functions
#
# b1(X) = I(0 <= X <= 2) - (X - 1)*I(1 <= X <= 2),
# b2(X) = (X - 3)*I(3 <= X <= 4) + I(4 < X <= 5).
#
# We fit the linear regression model
#
# Y = β0 + β1*b1(X) + β2*b2(X) + ε,
#
# and obtain coefficient estimates β0_hat = 1, β1_hat = 1, and β2_hat = 3.
# Sketch the estimated curve between X = -2 and X = 6. Note the intercepts,
# slopes, and other relevant information.

x <- seq(-2, 6, length = 1000)
b1 <- (0 <= x & x <= 2) -
      (x - 1) * (1 <= x & x <= 2)
b2 <- (x - 3) * (3 <= x & x <= 4) +
      (4 < x & x <= 5)
y <- 1 + b1 + 3 * b2
plot(x, y, type = "l", lwd = 2,
     xlab = "X", ylab = "Y_hat")

# 第 5 题
# Consider two curves, g1_hat and g2_hat, defined by
#
# g1_hat = arg min_g { sum(i = 1 to n) (y_i - g(x_i))^2
#                      + λ * integral [g^(3)(x)]^2 dx },
#
# g2_hat = arg min_g { sum(i = 1 to n) (y_i - g(x_i))^2
#                      + λ * integral [g^(4)(x)]^2 dx },
#
# where g^(m) represents the mth derivative of g.
#
# (a) As λ -> Inf, will g1_hat or g2_hat have the smaller training RSS?
# λ -> Inf 时：
# g1 的三阶导被压到 0，因此最多为二次函数。
# g2 的四阶导被压到 0，因此最多为三次函数。
# g2 更灵活，所以 training RSS 更小或相等。

# (b) As λ -> Inf, will g1_hat or g2_hat have the smaller test RSS?
# test RSS 无法确定。
# 要看真实关系以及 bias-variance trade-off。

# (c) For λ = 0, will g1_hat or g2_hat have the smaller training and test RSS?
# λ = 0 时两者都没有惩罚。
# training RSS 相同。
# test RSS 无法确定

# 第 6 题
# In this exercise, you will further analyze the Wage data set considered
# throughout this chapter.
library(ISLR2)
library(boot)
# (a) Perform polynomial regression to predict wage using age. Use
# cross-validation to select the optimal degree d for the polynomial.
# What degree was chosen, and how does this compare to the results of
# hypothesis testing using ANOVA? Make a plot of the resulting polynomial
# fit to the data.
set.seed(1)
cv.err <- rep(NA, 10)
for (d in 1:10) {
  fit <- glm(wage ~ poly(age, d), data = Wage)
  cv.err[d] <- cv.glm(Wage, fit, K = 10)$delta[1]
}
best.d <- which.min(cv.err)
best.d
fit <- lm(wage ~ poly(age, best.d), data = Wage)
age.grid <- seq(min(Wage$age), max(Wage$age), length = 200)
plot(Wage$age, Wage$wage, col = "grey")
lines(age.grid,predict(fit, data.frame(age = age.grid)),lwd = 2)

cv.err <- rep(NA, 9)
for (k in 2:10) {
  fit <- glm(wage ~ cut(age, k), data = Wage)
  cv.err[k - 1] <- cv.glm(Wage, fit, K = 10)$delta[1]
}

best.k <- which.min(cv.err) + 1
fit <- lm(wage ~ cut(age, best.k), data = Wage)
plot(Wage$age, Wage$wage, col = "grey")
points(Wage$age, fitted(fit), col = "red")



# (b) Fit a step function to predict wage using age, and perform
# cross-validation to choose the optimal number of cuts. Make a plot of
# the fit obtained.

# 第 7 题
# The Wage data set contains a number of other features not explored in this
# chapter, such as marital status (maritl), job class (jobclass), and others.
# Explore the relationships between some of these other predictors and wage,
# and use non-linear fitting techniques in order to fit flexible models to
# the data. Create plots of the results obtained, and write a summary of your
# findings.
library(gam)
fit <- gam(
  wage ~ s(age, 5) + s(year, 4) + maritl + jobclass,
  data = Wage
)
par(mfrow = c(2, 2))
plot(fit, se = TRUE)
summary(fit)


# 第 8 题
# Fit some of the non-linear models investigated in this chapter to the Auto
# data set. Is there evidence for non-linear relationships in this data set?
# Create some informative plots to justify your answer.
fit <- gam(
  mpg ~ s(horsepower, 4) +
        s(weight, 4) +
        s(displacement, 4) +
        s(acceleration, 4),
  data = Auto
)
par(mfrow = c(2, 2))
plot(fit, se = TRUE)
summary(fit)
# 第 9 题
# This question uses the variables dis (the weighted mean of distances to five
# Boston employment centers) and nox (nitrogen oxides concentration in parts
# per 10 million) from the Boston data. We will treat dis as the predictor and
# nox as the response.
library(splines)
# (a) Use the poly() function to fit a cubic polynomial regression to predict
# nox using dis. Report the regression output, and plot the resulting data and
# polynomial fits.
fit <- lm(nox ~ poly(dis, 3), data = Boston)
summary(fit)
dis.grid <- seq(min(Boston$dis),
                max(Boston$dis),
                length = 200)
plot(Boston$dis, Boston$nox)
lines(dis.grid,
      predict(fit, data.frame(dis = dis.grid)),
      lwd = 2)
# (b) Plot the polynomial fits for a range of different polynomial degrees
# (say, from 1 to 10), and report the associated residual sum of squares.

rss <- rep(NA, 10)
for (d in 1:10) {
  fit <- lm(nox ~ poly(dis, d), data = Boston)
  rss[d] <- sum(resid(fit)^2)
}
rss
plot(1:10, rss, type = "b")

# (c) Perform cross-validation or another approach to select the optimal
# degree for the polynomial, and explain your results.
set.seed(1)
cv.err <- rep(NA, 10)
for (d in 1:10) {
  fit <- glm(nox ~ poly(dis, d), data = Boston)
  cv.err[d] <- cv.glm(Boston, fit, K = 10)$delta[1]
}
best.d <- which.min(cv.err)
best.d
plot(1:10, cv.err, type = "b")

# (d) Use the bs() function to fit a regression spline to predict nox using
# dis. Report the output for the fit using four degrees of freedom. How did
# you choose the knots? Plot the resulting fit.

fit <- lm(nox ~ bs(dis, df = 4), data = Boston)
summary(fit)
plot(Boston$dis, Boston$nox)
lines(dis.grid,
      predict(fit, data.frame(dis = dis.grid)),
      lwd = 2)

# (e) Now fit a regression spline for a range of degrees of freedom, plot the
# resulting fits, and report the resulting RSS. Describe the results obtained.
dfs <- 3:10
rss <- rep(NA, length(dfs))
for (i in seq_along(dfs)) {
  fit <- lm(nox ~ bs(dis, df = dfs[i]), data = Boston)
  rss[i] <- sum(resid(fit)^2)
}

plot(dfs, rss, type = "b")
# (f) Perform cross-validation or another approach in order to select the best
# degrees of freedom for a regression spline on this data. Describe your
# results.
cv.err <- rep(NA, length(dfs))

for (i in seq_along(dfs)) {
  fit <- glm(nox ~ bs(dis, df = dfs[i]), data = Boston)
  cv.err[i] <- cv.glm(Boston, fit, K = 10)$delta[1]
}

best.df <- dfs[which.min(cv.err)]
best.df
# 第 10 题
# This question relates to the College data set.
library(leaps)
# (a) Split the data into a training set and a test set. Using out-of-state
# tuition as the response and the other variables as the predictors, perform
# forward stepwise selection on the training set in order to identify a
# satisfactory model that uses just a subset of the predictors.
set.seed(1)
id <- sample(1:nrow(College), nrow(College) / 2)
train <- College[id, ]
test <- College[-id, ]
regfit <- regsubsets(
  Outstate ~ .,
  data = train,
  method = "forward",
  nvmax = 17
)
reg.sum <- summary(regfit)
best.size <- which.min(reg.sum$bic)
vars <- names(coef(regfit, best.size))[-1]

# (b) Fit a GAM on the training data, using out-of-state tuition as the
# response and the features selected in the previous step as the predictors.
# Plot the results, and explain your findings.
num <- sapply(train[vars], is.numeric)
terms <- c(
  paste0("s(", vars[num], ", 4)"),
  vars[!num]
)
form <- as.formula(
  paste("Outstate ~", paste(terms, collapse = " + "))
)
gamfit <- gam(form, data = train)
plot(gamfit, se = TRUE)
summary(gamfit)

# (c) Evaluate the model obtained on the test set, and explain the results.
pred <- predict(gamfit, newdata = test)
mean((test$Outstate - pred)^2)

# (d) For which variables, if any, is there evidence of a non-linear
# relationship with the response?

# 第 11 题
# In Section 7.7, it was mentioned that GAMs are generally fit using a
# backfitting approach. The idea behind backfitting is actually quite simple.
# We will now explore backfitting in the context of multiple linear regression.
#
# Suppose that we would like to perform multiple linear regression, but we do
# not have software to do so. Instead, we only have software to perform simple
# linear regression. Therefore, we take the following iterative approach: we
# repeatedly hold all but one coefficient estimate fixed at its current value,
# and update only that coefficient estimate using a simple linear regression.
# The process is continued until convergence—that is, until the coefficient
# estimates stop changing. We now try this out on a toy example.
#
# (a) Generate a response Y and two predictors X1 and X2, with n = 100.
set.seed(1)
n <- 100
x1 <- rnorm(n)
x2 <- rnorm(n)
y <- 1 + 2*x1 + 3*x2 + rnorm(n)


# (b) Initialize β1_hat to take on a value of your choice. It does not matter
# what value you choose.
beta1 <- 0
beta2 <- 0

# (c) Keeping β1_hat fixed, fit the model
#
# Y - β1_hat*X1 = β0 + β2*X2 + ε.
#
# You can do this as follows:
#
# a <- y - beta1 * x1
# beta2 <- lm(a ~ x2)$coef[2]
#
# (d) Keeping β2_hat fixed, fit the model
#
# Y - β2_hat*X2 = β0 + β1*X1 + ε.
#
# You can do this as follows:
#
# a <- y - beta2 * x2
# beta1 <- lm(a ~ x1)$coef[2]
#
# (e) Write a for loop to repeat (c) and (d) 1,000 times. Report the estimates
# of β0_hat, β1_hat, and β2_hat at each iteration of the for loop. Create a
# plot in which each of these values is displayed, with β0_hat, β1_hat, and
# β2_hat each shown in a different color.B <- matrix(NA, 1000, 3)

for (i in 1:1000) {
  a <- y - beta1*x1
  beta2 <- coef(lm(a ~ x2))[2]
  a <- y - beta2*x2
  beta1 <- coef(lm(a ~ x1))[2]
  beta0 <- mean(y - beta1*x1 - beta2*x2)
  B[i, ] <- c(beta0, beta1, beta2)
}
matplot(B, type = "l", lty = 1)

# (f) Compare your answer in (e) to the results of simply performing multiple
# linear regression to predict Y using X1 and X2. Use the abline() function to
# overlay those multiple linear regression coefficient estimates on the plot
# obtained in (e).
ols <- coef(lm(y ~ x1 + x2))
abline(h = ols[1], lty = 2)
abline(h = ols[2], lty = 2)
abline(h = ols[3], lty = 2)
# (g) On this data set, how many backfitting iterations were required in order
# to obtain a "good" approximation to the multiple regression coefficient
# estimates?

# 第 12 题
# This problem is a continuation of the previous exercise. In a toy example
# with p = 100, show that one can approximate the multiple linear regression
# coefficient estimates by repeatedly performing simple linear regression in
# a backfitting procedure. How many backfitting iterations are required in
# order to obtain a "good" approximation to the multiple regression
# coefficient estimates? Create a plot to justify your answer.