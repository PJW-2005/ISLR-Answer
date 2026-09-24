# Lab
library(MASS)
library(ISLR2)
library(car)


head(Boston)
model <- lm(medv ~ lstat, data = Boston)
coefficients(model)
confint(model)
predict(model, data.frame(lstat = c(5, 10, 15)), interval = "confidence")
plot(Boston$lstat, Boston$medv)
abline(model)
abline(model, lwd = 3, col = "red")
plot(Boston$lstat, Boston$medv, col = "red")
plot(Boston$lstat, Boston$medv, pch = "+")
plot(1:20, 1:20, pch = 1:20)
par(mfrow = c(2, 2))
plot(model, pch = 20, col = "red")
plot(predict(model), residuals(model))
plot(predict(model), rstudent(model))
plot(hatvalues(model))

Mul_model <- lm(medv ~ lstat + age, data = Boston)
summary(Mul_model)
vif(Mul_model)
lm.fit1 <- lm(medv ~ . - age, data = Boston)
lm.fit1 <- update(Mul_model, ~ . - age)

summary(lm(medv ~ lstat * age, data = Boston))


summary(model)
plot(model, which = 1)
plot(model, which = 2)
plot(model, which = 3)


lm.fit2 <- lm(medv ~ lstat + I(lstat^2), data = Boston)
lm.fit3 <- lm(medv ~ lstat, data = Boston)
anova(lm.fit2, lm.fit3)

head(Carseats)
lm.fit <- lm(Sales ~ . + Income:Advertising + Price:Age,
data = Carseats)



# 第一题
# Describe the null hypotheses to which the p-values given in Table 3.4
# correspond. Explain what conclusions you can draw based on these
# p-values. Your explanation should be phrased in terms of sales, TV,
# radio, and newspaper, rather than in terms of the coefficients of the
# linear model.

# H_0: TV, radio, and newspaper 对于最终的价格没有影响，
# 其中TV和radio显示的与价格间具有线性相关性，并且在对最终价格无影响的情况下，出现现有的情况的概率极小，因此拒绝零假设。
# 而newspaper与sales不具有线性相关性，说明它是随机产生的概率极大，我们无法拒绝零假设。

# 第二题
# Carefully explain the differences between the KNN classifier and KNN
# regression methods.
# KNN classifier做的主要是分类问题对于一个大类的数据集，KNN会选择其中的K个最邻近的点
# ，这些点属于那种类别的多就判定为这一个预测点为哪一个类别，但是对于KNN的回归模型，
# 会认为讲这个点预测为K个最邻近的点的平均值作为预测值。这就导致了KNN分类器是离散的，
# 而KNN回归是连续的。KNN回归的每一个点对预测结果的影响是连续的，而KNN分类对于每一个点的
# 的预测结果的影响是离散的。



# 第三题
# Suppose we have a data set with five predictors, X1 = GPA, X2 =
# IQ, X3 = Level (1 for College and 0 for High School), X4 = Interac-
# tion between GPA and IQ, and X5 = Interaction between GPA and
# Level. The response is starting salary after graduation (in thousands
# of dollars). Suppose we use least squares to fit the model, and get
# βˆ0 = 50, βˆ1 = 20, βˆ2 = 0.07, βˆ3 = 35, βˆ4 = 0.01, βˆ5 = −10.
# (a) Which answer is correct, and why?
#   i. For a fixed value of IQ and GPA, high school graduates earn
#   more, on average, than college graduates.
# 错的，当GPA和IQ固定时，GPA小于3.5的情况下，College毕业生的工资要大于High school毕业生

#   ii. For a fixed value of IQ and GPA, college graduates earn
#   more, on average, than high school graduates.
# 错的，当GPA和IQ固定时，GPA小于3.5的情况下，College毕业生的工资要大于High school毕业生

#   iii. For a fixed value of IQ and GPA, high school graduates earn
#   more, on average, than college graduates provided that the
#   GPA is high enough.
# 对的 3.5 GPA就是那条分界线
#   iv. For a fixed value of IQ and GPA, college graduates earn
#   more, on average, than high school graduates provided that
#   the GPA is high enough
# 对的 3.5 GPA就是那条分界线
# (b) Predict the salary of a college graduate with IQ of 110 and a
# GPA of 4.0.
# 4.0 * 20 + 110 * 0.07 + 1 * 35 + 4.0 * 110 * 0.01 + 4.0 * 1 * -10 + 50 = 137.7
# (c) True or false: Since the coefficient for the GPA/IQ interaction
# term is very small, there is very little evidence of an interaction
# effect. Justify your answer.
# 错的，虽然系数很小，但是GPA和IQ的值都很大，所以这个交互项的影响还是很大的。



# 第四题
# I collect a set of data (n = 100 observations) containing a single
# predictor and a quantitative response. I then fit a linear regression
# model to the data, as well as a separate cubic regression, i.e. Y =
# β0 + β1X + β2X2 + β3X3 + ϵ.
# (a) Suppose that the true relationship between X and Y is linear,
#   i.e. Y = β0 + β1X + ϵ. Consider the training residual sum of
#   squares (RSS) for the linear regression, and also the training
#   RSS for the cubic regression. Would we expect one to be lower
#   than the other, would we expect them to be the same, or is there
#   not enough information to tell? Justify your answer.
# 我认为三元线性方程组的训练RSS会更低，因为它可能一定程度上能够拟合到随机误差的表达
# 因此相较于一元线性方程组的RSS会更低
#   (b) Answer (a) using test rather than training RSS.
# 我认为三元线性方程组的测试RSS通常会更高，因为它可能一定程度上能够拟合到随机误差的表达
#   (c) Suppose that the true relationship between X and Y is not linear,
#   but we don’t know how far it is from linear. Consider the training
#   RSS for the linear regression, and also the training RSS for the
#   cubic regression. Would we expect one to be lower than the
#   other, would we expect them to be the same, or is there not
#   enough information to tell? Justify your answer.
# 我认为三元线性方程组的训练误差更低，因为它表达出来的应该是一个平面和非线性点间的RSS，
# 我认为可能回校正到一些非线性点的误差，因此三元线性方程组的训练RSS会更低

#   (d) Answer (c) using test rather than training RSS.
# 我不知道它真实的情况到底有多非线性，因此无法判断，它对于bias和Variance的影响哪一个更大

# 第五题
# Consider the fitted values that result from performing linear 
# regression without an intercept. In this setting, the ith fitted value takes
# the form
# y_hat_{i} = x_i * beta1_hat,
# where
# beta1_hat <- sum^{n}_{i=1} (x_i * y_i) / sum^{n}_{i=1} (x_i^2)
# Show that we can write
# hat_{y_{i}} = sum^{n}_{i=1} a_i * y_i
# What is ai′?
# Note: We interpret this result by saying that the fitted values from
# linear regression are linear combinations of the response values.
# a_i' = x_i * x_i' / sum^{n}_{i=1} (x_i^2)

# 第六题
# Using (3.4), argue that in the case of simple linear regression, the
# least squares line always passes through the point (¯x, y¯).
# 对RSS求β0求偏导，就能得到这一个结论，RSS对β0求偏导为0时，得到的β0就是y的均值减去β1乘以
#x的均值，因此最小二乘法的直线一定会经过(x的均值，y的均值)这个点。

# 第七题
# It is claimed in the text that in the case of simple linear regression
# of Y onto X, the R2 statistic (3.17) is equal to the square of the
# correlation between X and Y (3.18). Prove that this is the case. For
# simplicity, you may assume that x¯ = ¯y = 0.
# 这个好证明，去掉hat_y和hat_x在简单线性方程组的情况下也成立，其中可能用到的sum_i^n {e_i} = 0，sum_i^n {e_i * x_i} = 0，sum_i^n {e_i * y_i} = 0，sum_i^n {hat_y_i * e_i} = 0，sum_i^n {hat_y_i * x_i} = 0，sum_i^n {hat_y_i * y_i} = sum_i^n {hat_y_i^2}，sum_i^n {hat_y_i * hat_x_i} = sum_i^n {hat_y_i^2}，sum_i^n {hat_x_i * e_i} = 0
# 这是来源于最小二乘法的性质，偏导处为零


# 第八题
# This question involves the use of simple linear regression on the Auto
# data set.
Auto <- read.csv("第二章\\Auto.csv")

# (a) Use the lm() function to perform a simple linear regression with
#     mpg as the response and horsepower as the predictor. Use the
#     summary() function to print the results. Comment on the output.
model <- lm(mpg ~ as.numeric(horsepower), data = Auto)
summary(model)
#     For example:
#       i. Is there a relationship between the predictor and the response?
# 存在关系
#       ii. How strong is the relationship between the predictor and
#       the response?
# P_value<2e-16
#       iii. Is the relationship between the predictor and the response
#       positive or negative?
# 负相关
#       iv. What is the predicted mpg associated with a horsepower of
#       98? What are the associated 95 % confidence and prediction
#       intervals?
predict(model, data.frame(horsepower = 98), interval = "confidence")
#        fit      lwr      upr
# 1 24.46708 23.97308 24.96108
# (b) Plot the response and the predictor. Use the abline() function
#     to display the least squares regression line.
plot(Auto$horsepower, Auto$mpg)
abline(model, col = "red")
# (c) Use the plot() function to produce diagnostic plots of the least
#     squares regression fit. Comment on any problems you see with
#     the fit.
plot(model, which = 1)
#残差出现了显著的非线性，说明这个模型可能不适合
# 第九题
# This question involves the use of multiple linear regression on the
# Auto data set.
# (a) Produce a scatterplot matrix which includes all of the variables
#     in the data set.
# (b) Compute the matrix of correlations between the variables using
#     the function cor(). You will need to exclude the name variable,
#     which is qualitative.
Auto1 <- Auto
Auto1$horsepower <- as.numeric(Auto1$horsepower)
pairs(Auto1[,-c(9)] )
cor(Auto1[,-c(9)])
# (c) Use the lm() function to perform a multiple linear regression
#     with mpg as the response and all other variables except name as
#     the predictors. Use the summary() function to print the results.
model_Auto <- lm(mpg ~ . - name, data = Auto1)
summary(model_Auto)
#     Comment on the output. For instance:
#       i. Is there a relationship between the predictors and the response?
# displacement weight year origin有关其他无关
#       ii. Which predictors appear to have a statistically significant
#           relationship to the response?
# displacement weight year origin
#       iii. What does the coefficient for the year variable suggest?
# (d) Use the plot() function to produce diagnostic plots of the linear
#     regression fit. Comment on any problems you see with the fit.
#     Do the residual plots suggest any unusually large outliers? Does
#     the leverage plot identify any observations with unusually high
#     leverage?
plot(model_Auto, which = 1)
# (e) Use the * and : symbols to fit linear regression models with
#     interaction effects. Do any interactions appear to be statistically
#     significant?
lm(mpg ~ origin + weight + origin:weight, data = Auto1)
# (f) Try a few different transformations of the variables, such as
#     log(X), sqrt(X), X^2. Comment on your findings.

# 第十题
# This question should be answered using the Carseats data set.
# (a) Fit a multiple regression model to predict Sales using Price,
#     Urban, and US.

# (b) Provide an interpretation of each coefficient in the model. Be
#     careful—some of the variables in the model are qualitative!
# (c) Write out the model in equation form, being careful to handle
#     the qualitative variables properly.
# (d) For which of the predictors can you reject the null hypothesis
#      H0 : βj = 0?
# (e) On the basis of your response to the previous question, fit a
#     smaller model that only uses the predictors for which there is
#     evidence of association with the outcome.
# (f) How well do the models in (a) and (e) fit the data?
# (g) Using the model from (e), obtain 95 % confidence intervals for
#     the coefficient(s).
# (h) Is there evidence of outliers or high leverage observations in the
#     model from (e)?

# 第十一题
# In this problem we will investigate the t-statistic for the null hypothsis H0 : β = 0 in simple linear regression without an intercept. To
# begin, we generate a predictor x and a response y as follows.
set.seed(1)
x <- rnorm(100)
y <- 2 * x + rnorm(100)
# (a) Perform a simple linear regression of y onto x, without an 
#     intercept. Report the coefficient estimate βˆ, the standard error of
#     this coefficient estimate, and the t-statistic and p-value 
#     associated with the null hypothesis H0 : β = 0. Comment on these
#     results. (You can perform regression without an intercept using
#     the command lm(y∼x+0).)
reg_model <- lm(y ~ x + 0)
summary(reg_model)
#          Estimate Std. Error t value Pr(>|t|)    
#            1.9939     0.1065   18.73   <2e-16 
# (b) Now perform a simple linear regression of x onto y without an
#     intercept, and report the coefficient estimate, its standard error,
#     and the corresponding t-statistic and p-values associated with
#     the null hypothesis H0 : β = 0. Comment on these results.
reg_model2 <- lm(x ~ y + 0)
summary(reg_model2)# (c) What is the relationship between the results obtained in (a) and (b)?
# 在a中我们发现了y和x之间的关系，而在b中我们发现了x和y之间的关系，虽然他们的系数不同，但是他们的t值和p值是相同的。
# (d) For the regression of Y onto X without an intercept, the statistic for H0 : β = 0 takes the form βˆ/SE(βˆ), where βˆ is
#     given by (3.38), and where

#     SE(hat_{beta}) = sqrt{sum_{i=1}^{n} (y_i - x_iβˆ)^2 / (n − 1)} / sqrt{sum_{i=1}^{n} x_i^2}.

#     (These formulas are slightly different from those given in Sec
#      tions 3.1.1 and 3.1.2, since here we are performing regression
#     without an intercept.) Show algebraically, and confirm numerically in R, that the t-statistic can be written as

sqrt(99) * sum(x * y) / sqrt(sum(x^2) * sum(y^2) - (sum(x * y))^2)

# (e) Using the results from (d), argue that the t-statistic for the regression of y onto x is the same as the t-statistic for the regression
#     of x onto y.
# 当我们将t值换算最简式时能够发现这里的x和y的位置能够任意调换，不会影响到最后t的取值
# (f) In R, show that when regression is performed with an intercept,
#     the t-statistic for H0 : β1 = 0 is the same for the regression of y
#     onto x as it is for the regression of x onto y.
reg_model3 <- lm(y ~ x)
reg_model4 <- lm(x ~ y)
summary(reg_model3)$coefficients[2, "t value"] == summary(reg_model4)$coefficients[2, "t value"]

# 第十二题
# This problem involves simple linear regression without an intercept.
# (a) Recall that the coefficient estimate βˆ for the linear regression of
#     Y onto X without an intercept is given by (3.38). Under what
#     circumstance is the coefficient estimate for the regression of X
#     onto Y the same as the coefficient estimate for the regression of
#     Y onto X?
# (b) Generate an example in R with n = 100 observations in which
#     the coefficient estimate for the regression of X onto Y is different
#     from the coefficient estimate for the regression of Y onto X.
# (c) Generate an example in R with n = 100 observations in which
#     the coefficient estimate for the regression of X onto Y is the
#     same as the coefficient estimate for the regression of Y onto X.

# 第十三题
# In this exercise you will create some simulated data and will fit simple
# linear regression models to it. Make sure to use set.seed(1) prior to
# starting part (a) to ensure consistent results.
set.seed(1)
# (a) Using the rnorm() function, create a vector, x, containing 100
#     observations drawn from a N(0, 1) distribution. This represents
#     a feature, X.
x <- rnorm(100, 0, 1)

# (b) Using the rnorm() function, create a vector, eps, containing 100
#     observations drawn from a N(0, 0.25) distribution—a normal
#     distribution with mean zero and variance 0.25.
eps <- rnorm(100, mean = 0, sd = 0.25)

# (c) Using x and eps, generate a vector y according to the model
#     Y = −1+0.5X + ϵ. (3.39)
#     What is the length of the vector y? What are the values of β0
#     and β1 in this linear model?
y <- -1 + 0.5*x + eps
# β^0 = -1, β^1 = 0.5
# (d) Create a scatterplot displaying the relationship between x and
#     y. Comment on what you observe.
plot(x, y)
# (e) Fit a least squares linear model to predict y using x. Comment
#     on the model obtained. How do βˆ0 and βˆ1 compare to β0 and
#     β1?
linear_model <- lm(y ~ x)
# (f) Display the least squares line on the scatterplot obtained in (d).
#     Draw the population regression line on the plot, in a different
#     color. Use the legend() command to create an appropriate legend.
abline(linear_model, col = "red")
abline(a = -1, b = 0.5, col = "blue")
# (g) Now fit a polynomial regression model that predicts y using x
#     and x2. Is there evidence that the quadratic term improves the
#     model fit? Explain your answer.
square_model <- lm(y ~ x + I(x^2))
summary(square_model)
# 我认为没有，其中的X^2项主要是去拟合了误差项
# (h) Repeat (a)–(f) after modifying the data generation process in
#     such a way that there is less noise in the data. The model (3.39)
#     should remain the same. You can do this by decreasing the variance of the normal distribution used to generate the error term
#     ϵ in (b). Describe your results.
eps_less <- rnorm(100, mean = 0, sd = 0.01)
y_less <- -1 + 0.5 * x + eps_less
model_less <- lm(y_less ~ x)

plot(
  x, y_less,
  pch = 20,
  col = "red",
  main = "Less Noise",
  xlab = "x",
  ylab = "y"
)
abline(a = -1, b = 0.5, col = "black", lwd = 2)
abline(model_less, col = "blue", lwd = 2)
# (i) Repeat (a)–(f) after modifying the data generation process in
#     such a way that there is more noise in the data. The model
#     (3.39) should remain the same. You can do this by increasing
#     the variance of the normal distribution used to generate the
#     error term ϵ in (b). Describe your results.
eps_more <- rnorm(100, mean = 0, sd = 1)
y_more <- -1 + 0.5 * x + eps_more
model_more <- lm(y_more ~ x)

plot(
  x, y_more,
  pch = 20,
  col = "red",
  main = "More Noise",
  xlab = "x",
  ylab = "y"
)
abline(model_more, col = "blue", lwd = 2)
bline(a = -1, b = 0.5, col = "black", lwd = 2)
# (j) What are the confidence intervals for β0 and β1 based on the
#     original data set, the noisier data set, and the less noisy data
#     set? Comment on your results.
ci_original <- confint(model_original)
ci_less <- confint(model_less)
ci_more <- confint(model_more)

# 第十四题
# (a) Perform the following commands in R:
set.seed(1)
x1 <- runif(100)
x2 <- 0.5 * x1 + rnorm(100) / 10
y <- 2 + 2 * x1 + 0.3 * x2 + rnorm(100)
#    The last line corresponds to creating a linear model in which y is
#     a function of x1 and x2. Write out the form of the linear model.
#     What are the regression coefficients?
# interceptions = 2 β^1 = 2 β^2 = 0.3

# (b) What is the correlation between x1 and x2? Create a scatterplot
#     displaying the relationship between the variables.
Mul_model <-  lm(y ~ x1 + x2)
plot(x1, x2, pch = 20, col = "red")
cor(x1, x2)
# (c) Using this data, fit a least squares regression to predict y using
#     x1 and x2. Describe the results obtained. What are βˆ0, βˆ1, and
#     βˆ2? How do these relate to the true β0, β1, and β2? Can you
#     reject the null hypothesis H0 : β1 = 0? How about the null
#     hypothesis H0 : β2 = 0?
# > x1            1.4396     0.7212   1.996   0.0487 *  
# > x2            1.0097     1.1337   0.891   0.3754 
# 我无法拒绝这个零假设   
# (d) Now fit a least squares regression to predict y using only x1.
#     Comment on your results. Can you reject the null hypothesis
#     H0 : β1 = 0?
Mul_model1 <- lm(y ~ x1)
# 具有显著性
# (e) Now fit a least squares regression to predict y using only x2.
#     Comment on your results. Can you reject the null hypothesis
#     H0 : β1 = 0?
Mul_model2 <- lm(y ~ x2)
# (f) Do the results obtained in (c)–(e) contradict each other? Explain
#     your answer.
# 不矛盾。(d) 和 (e) 中的简单回归衡量的是每个变量与 \(Y\) 的总体关联，没有控制另一个变量；
# (c) 中的多元回归衡量的是控制另一个变量后的独立关联。由于 \(x_1\) 和 \(x_2\) 高度相关，
#共线性使得两个变量各自的独立作用难以区分，从而增大标准误，使某些 p-value 变大。
# (g) Now suppose we obtain one additional observation, which was
#     unfortunately mismeasured.
x1 <- c(x1, 0.1)
x2 <- c(x2, 0.8)
y <- c(y, 6)
#     Re-fit the linear models from (c) to (e) using this new data. What
#     effect does this new observation have on the each of the models?
#     In each model, is this observation an outlier? A high-leverage
#     point? Both? Explain your answers.
Mul_model_new <-  lm(y ~ x1 + x2)
summary(Mul_model_new)
rstudent(Mul_model_new)[101]
hatvalues(Mul_model_new)[101]
which.max(hatvalues(Mul_model_new))
Mul_model1_new <- lm(y ~ x1)
summary(Mul_model1_new)
Mul_model2_new <- lm(y ~ x2)
summary(Mul_model2_new)
# 这会导致杠杆更多的向这个点去倾斜

# 第十五题
# This problem involves the Boston data set, which we saw in the lab
# for this chapter. We will now try to predict per capita crime rate
# using the other variables in this data set. In other words, per capita
# crime rate is the response, and the other variables are the predictors.
# (a) For each predictor, fit a simple linear regression model to predict
#     the response. Describe your results. In which of the models is
#     there a statistically significant association between the predictor
#     and the response? Create some plots to back up your assertions.
# (b) Fit a multiple regression model to predict the response using
#     all of the predictors. Describe your results. For which predictors
#     can we reject the null hypothesis H0 : βj = 0?
# (c) How do your results from (a) compare to your results from (b)?
#     Create a plot displaying the univariate regression coefficients
#     from (a) on the x-axis, and the multiple regression coefficients
#     from (b) on the y-axis. That is, each predictor is displayed as a
#     single point in the plot. Its coefficient in a simple linear regression model is shown on the x-axis, and its coefficient estimate
#     in the multiple linear regression model is shown on the y-axis.
# (d) Is there evidence of non-linear association between any of the
#     predictors and the response? To answer this question, for each
#     predictor X, fit a model of the form
#     Y = β0 + β1X + β2X2 + β3X3 + ϵ.