# 第一题 
# Using a little bit of algebra, prove that (4.2) is equivalent to (4.3). In
# other words, the logistic function representation and logit represen￾tation for the logistic regression model are equivalent.
#将e^(β0+β1X) / (1 + e^(β0+β1X)) = p(X)代入logit(p(X)) = log(p(X)/(1-p(X)))，化简即可得到logit(p(X)) = β0 + β1X

# 第二题
# It was stated in the text that classifying an observation to the class
# for which (4.17) is largest is equivalent to classifying an observation
# to the class for which (4.18) is largest. Prove that this is the case. In
# other words, under the assumption that the observations in the kth
# class are drawn from a N(µk, σ2) distribution, the Bayes classifier
# assigns an observation to the class for which the discriminant function
# is maximized.
#求一个log(pk(x))，其中pk(x)为第k类的概率密度函数，化简后得到log(p(X|Y=k)πk) = -1/2log(2πσ^2) - (X-µk)^2/(2σ^2) + log(πk)，
#这里我假设了所有的数据都遵循着同一个σ的分布，因此去掉常数项后得到log(πk) - (X-µk)^2/(2σ^2)，即为判别函数。

# 第三题
# This problem relates to the QDA model, in which the observations
# within each class are drawn from a normal distribution with a class specific mean
# vector and a class specific covariance matrix. We consider the simple case where
# p = 1; i.e. there is only one feature.
# Suppose that we have K classes, and that if an observation belongs
# to the kth class then X comes from a one-dimensional normal distribution, 
# X ∼ N(µk, σk^2). Recall that the density function for the
# one-dimensional normal distribution is given in (4.16). Prove that in
# this case, the Bayes classifier is not linear. Argue that it is in fact
# quadratic.
# Hint: For this problem, you should follow the arguments laid out in
# Section 4.4.1, but without making the assumption that σ1
# 2 = ... = σK
# 2 .
# QDA 不假设所有类别具有相同的方差，
# 因此对于第 k 类：
# X | Y = k ~ N(mu_k, sigma_k^2)
# 正态分布的概率密度函数为：
# f_k(x) = 1 / sqrt(2*pi*sigma_k^2) *
#          exp(-(x-mu_k)^2 / (2*sigma_k^2))
# 根据 Bayes 定理，分类时比较 pi_k * f_k(x)。
# 取对数，并去掉与类别 k 无关的常数 -1/2*log(2*pi)，得到：
# delta_k(x) =
#   -1/2*log(sigma_k^2)
#   -(x-mu_k)^2/(2*sigma_k^2)
#   +log(pi_k)
# 展开平方项：
# delta_k(x) =
#   -x^2/(2*sigma_k^2)
#   +mu_k*x/sigma_k^2
#   -mu_k^2/(2*sigma_k^2)
#   -1/2*log(sigma_k^2)
#   +log(pi_k)
# 因为不同类别的 sigma_k^2 不同，
# 所以 x^2 项不能被消掉。
# 因此决策边界 delta_k(x) = delta_l(x)
# 是关于 x 的二次方程。
# 所以 QDA 的 Bayes classifier 不是线性的，而是二次的。

# 第四题
# When the number of features p is large, there tends to be a deterioration in the performance of KNN and other local approaches that
# perform prediction using only observations that are near the test observation for which a prediction must be made. This phenomenon is
# known as the curse of dimensionality, and it ties into the fact that curse of di- non-parametric approaches often perform poorly when p is large. We mensionality
# will now investigate this curse.
# (a) Suppose that we have a set of observations, each with measurements on p = 1 feature, X. We assume that X is uniformly
#     (evenly) distributed on [0, 1]. Associated with each observation
#     is a response value. Suppose that we wish to predict a test obser￾vation’s response using only observations that are within 10 % of
#     the range of X closest to that test observation. For instance, in
#     order to predict the response for a test observation with X = 0.6,
#     we will use observations in the range [0.55, 0.65]. On average,
#     what fraction of the available observations will we use to make
#     the prediction?
# 在这里每个特征我使用了10%的数据来进行预测，因此平均来说，我将使用10%的可用观测值来进行预测。

# (b) Now suppose that we have a set of observations, each with
#     measurements on p = 2 features, X1 and X2. We assume that
#     (X1, X2) are uniformly distributed on [0, 1] × [0, 1]. We wish to
#     190 4. Classification
#     predict a test observation’s response using only observations that
#     are within 10 % of the range of X1 and within 10 % of the range
#     of X2 closest to that test observation. For instance, in order to
#     predict the response for a test observation with X1 = 0.6 and
#     X2 = 0.35, we will use observations in the range [0.55, 0.65] for
#     X1 and in the range [0.3, 0.4] for X2. On average, what fraction
#     of the available observations will we use to make the prediction?
# 这里每个特征我使用了10%的数据来进行预测，但是由于有两个特征，因此我将使用10% * 10% = 1%的可用观测值来进行预测。

# (c) Now suppose that we have a set of observations on p = 100 fea￾tures. Again the observations are uniformly distributed on each
#     feature, and again each feature ranges in value from 0 to 1. We
#     wish to predict a test observation’s response using observations
#     within the 10 % of each feature’s range that is closest to that test
#     observation. What fraction of the available observations will we
#     use to make the prediction?
# 这里每个特征我使用了10%的数据来进行预测，但是由于有100个特征，因此我将使用10%^100 = 1e-100的可用观测值来进行预测。

# (d) Using your answers to parts (a)–(c), argue that a drawback of
#     KNN when p is large is that there are very few training obser￾vations “near” any given test observation.
# 当你使用了100个特征时，你将使用10%^100 = 1e-100的可用观测值来进行预测，这意味着几乎没有训练观测值“接近”任何给定的测试观测值。
# 维度越高，数据点之间的距离就越大，这使得KNN在高维空间中难以找到足够的邻近点来进行有效的预测，从而导致性能下降。但是需要考虑到你数据分布会有聚集和疏散区的区别，不一定所有的数据都是均匀规律分布的？

# (e) Now suppose that we wish to make a prediction for a test obser￾vation by creating a p-dimensional hypercube centered around
#     the test observation that contains, on average, 10 % of the train￾ing observations. For p = 1, 2, and 100, what is the length of each
#     side of the hypercube? Comment on your answer.
#     Note: A hypercube is a generalization of a cube to an arbitrary
#     number of dimensions. When p = 1, a hypercube is simply a line
#     segment, when p = 2 it is a square, and when p = 100 it is a
#     100-dimensional cube.
# 对于d维超立方体，边长为l，则体积为l^d。我们希望体积包含10%的训练观测值，因此我们有：
# l^p = 0.1


# 第五题
# We now examine the differences between LDA and QDA.
# (a) If the Bayes decision boundary is linear, do we expect LDA or
#     QDA to perform better on the training set? On the test set?
#我会认为LDA在训练集和测试集上都表现更好，因为LDA假设所有类别具有相同的协方差矩阵，这使得它在数据量较小的情况下更稳定。而QDA由于其灵活性，可能会过拟合训练数据，从而在测试集上表现不佳。

# (b) If the Bayes decision boundary is non-linear, do we expect LDA
#     or QDA to perform better on the training set? On the test set?
#我会认为QDA在训练集上表现更好，因为它可以捕捉到非线性边界的复杂性。然而，在测试集上，我无法判段LDA和QDA的表现，因为这取决于数据的分布和样本量。如果样本量足够大，QDA可能会在测试集上表现更好；但如果样本量较小，QDA可能会过拟合，从而在测试集上表现不佳。

# (c) In general, as the sample size n increases, do we expect the test
#     prediction accuracy of QDA relative to LDA to improve, decline,
#     or be unchanged? Why?
# 随着样本量 n 增大，QDA 相对于 LDA 的测试预测准确率通常会提高。
# 因为 QDA 需要估计更多参数，样本量较小时参数估计不稳定，方差较大，容易过拟合。
# 当 n 增大后，QDA 的参数估计更加稳定，因此 QDA 的灵活性能够得到更好的发挥。

# (d) True or False: Even if the Bayes decision boundary for a given
#     problem is linear, we will probably achieve a superior test er￾ror rate using QDA rather than LDA because QDA is flexible
#     enough to model a linear decision boundary. Justify your an￾swer.
# False。
# 虽然 QDA 也能够拟合线性决策边界， 但如果真实的 Bayes decision boundary 是线性的，
# QDA 的额外灵活性没有必要。QDA 需要估计更多参数，方差更大，因此更容易过拟合。
# 所以测试集上通常 LDA 表现更好。

# 第六题 
# Suppose we collect data for a group of students in a statistics class 
# with variables X1 = hours studied, X2 = undergrad GPA, and Y = 
# receive an A. We fit a logistic regression and produce estimated 
# coefficient, βˆ0 = −6, βˆ1 = 0.05, βˆ2 = 1. 
# (a) Estimate the probability that a student who studies for 40 h and 
#     has an undergrad GPA of 3.5 gets an A in the class. 
# 这里 p = exp(-6 + 0.05 * 40 + 1 * 3.5) / (1 + exp(-6 + 0.05 * 40 + 1 * 3.5))
#   ≈ 0.378
# (b) How many hours would the student in part (a) need to study to 
#     have a 50 % chance of getting an A in the class? 
# 带入 p = 0.5，解方程：
# 0.5 = exp(-6 + 0.05 * x + 1 * 3.5) / (1 + exp(-6 + 0.05 * x + 1 * 3.5))
# 得到 x ≈ 46.1 小时。

# 第七题 
# Suppose that we wish to predict whether a given stock will issue a 
# dividend this year (“Yes” or “No”) based on X, last year’s percent 
# profit. We examine a large number of companies and discover that the 
# mean value of X for companies that issued a dividend was X¯ = 10, 
# while the mean for those that didn’t was X¯ = 0. In addition, the 
# variance of X for these two sets of companies was σˆ2 = 36. Finally, 
# 80 % of companies issued dividends. Assuming that X follows a normal 
# distribution, predict the probability that a company will issue a 
# dividend this year given that its percentage profit was X = 4 last 
# year. 
# Hint: Recall that the density function for a normal random variable 
# is f(x) = 1 / sqrt(2πσ²) * e^(-(x-µ)²/(2σ²)). 
# You will need to use Bayes’ theorem. 
# 已知：
# P(Yes) = 0.8，P(No) = 0.2
# X | Yes ~ N(10, 36)
# X | No  ~ N(0, 36)
# 现在要求 P(Yes | X = 4)
# 计算 X = 4 在两类中的概率密度：
# f_yes = dnorm(4, mean = 10, sd = 6)
# f_no  = dnorm(4, mean = 0, sd = 6)
# 根据 Bayes 定理：
# P(Yes | X = 4) =
#     f_yes * 0.8 /
#     (f_yes * 0.8 + f_no * 0.2)
# 计算得到：
# P(Yes | X = 4) ≈ 0.614
# 因此，当去年利润率为 4% 时，
# 该公司今年发放股息的概率约为 61.4%。

# 第八题 
# Suppose that we take a data set, divide it into equally-sized training 
# and test sets, and then try out two different classification procedures. 
# First we use logistic regression and get an error rate of 20 % on the 
# training data and 30 % on the test data. Next we use 1-nearest neighbors 
# (i.e. K = 1) and get an average error rate (averaged over both test and 
# training data sets) of 18 %. Based on these results, which method should 
# we prefer to use for classification of new observations? Why? 
# 1-NN 在训练集上的错误率为 0%， 因为每个训练样本最近的邻居就是它自己。
# 已知 1-NN 在训练集和测试集上的平均错误率为 18%，且训练集和测试集大小相同：
# (0% + Test Error) / 2 = 18%因此：Test Error = 36%
# Logistic Regression 的测试错误率为 30%，
# 而 1-NN 的测试错误率为 36%。
# 因此应该选择 Logistic Regression，
# 因为它在测试集上的错误率更低，
# 对新观测值的预测效果更好。
# 不能仅根据这些结果判断决策边界一定是非线性的。

# 第九题 
# This problem has to do with odds. 
# (a) On average, what fraction of people with an odds of 0.37 of 
#     defaulting on their credit card payment will in fact default? 
# (b) Suppose that an individual has a 16 % chance of defaulting on 
#     her credit card payment. What are the odds that she will default? 
# (a)
# 已知 defaulting 的 odds = 0.37
# 因此：
# p = 0.37 / (1 + 0.37)
#   ≈ 0.270
# 所以平均约有 27.0% 的人会违约。
# (b)
# 已知 defaulting 的概率 p = 16% = 0.16
# odds = p / (1 - p)
#      = 0.16 / 0.84
#      ≈ 0.1905
# 所以违约的 odds 约为 0.19。

# 第十题 
# Equation 4.32 derived an expression for 
# log(Pr(Y = k | X = x) / Pr(Y = K | X = x)) 
# in the setting where p > 1, so that the mean for the kth class, µk, 
# is a p-dimensional vector, and the shared covariance Σ is a p × p matrix. 
# However, in the setting with p = 1, (4.32) takes a simpler form, since 
# the means µ1,...,µK and the variance σ² are scalars. In this simpler 
# setting, repeat the calculation in (4.32), and provide expressions for 
# ak and bkj in terms of πk, πK, µk, µK, and σ². 
# 对于 p = 1 的情况，(4.32) 可以简化为：
# log(Pr(Y = k | X = x) / Pr(Y = K | X = x)) = log(πk / πK) - (x - µk)² / (2σ²) + (x - µK)² / (2σ²)
# 因为在 p = 1 的情况下，协方差矩阵 Σ 变为一个标量 σ²。
# log(Pr(Y = k | X = x) / Pr(Y = K | X = x)) = log(πk / πK) +  x*µk / σ² + µk^2 / 2σ²  - x*µK)² / σ² + x*µK / σ² - µK^2 / 2σ²
# 可以观察到该式子由一关于k的常数项和关于x的线性项组成，因此可以将其表示为：
# log(Pr(Y = k | X = x) / Pr(Y = K | X = x)) = ak + bkj * x


# 第十一题 
# Work out the detailed forms of ak, bkj, and bkjl in (4.33). Your answer 
# should involve πk, πK, µk, µK, Σk, and ΣK. 
# (4.33) QDA:
# LDA: Σ is shared by all classes
# log(Pr(Y=k|X=x) / Pr(Y=K|X=x))
# = log(πk / πK)
#   - 1/2 * (x - µk)^T Σ^(-1) (x - µk)
#   + 1/2 * (x - µK)^T Σ^(-1) (x - µK)
# 展开并消去相同的二次项 x^T Σ^(-1) x：
# = log(πk / πK)
#   - 1/2 * (µk + µK)^T Σ^(-1) (µk - µK)
#   + x^T Σ^(-1) (µk - µK)
# 因此：
# ak =
# log(πk / πK)
# - 1/2 * (µk + µK)^T Σ^(-1) (µk - µK)
# bkj =
# [Σ^(-1) (µk - µK)]_j
# 最终：
# log(Pr(Y=k|X=x) / Pr(Y=K|X=x))
# = ak + sum_j bkj*xj
# 因为所有类别共享 Σ，所以二次项 xj*xl 消失，
# 因此 LDA 的决策边界是线性的。

# 第十二题 
# Suppose that you wish to classify an observation X ∈ R into apples 
# and oranges. You fit a logistic regression model and find that 
# Pr(Y = orange | X = x) =
# exp(βˆ0 + βˆ1x) / (1 + exp(βˆ0 + βˆ1x)).
# Your friend fits a logistic regression model to the same data using the 
# softmax formulation in (4.13), and finds that 
# Pr(Y = orange | X = x) =
# exp(αˆorange0 + αˆorange1x) /
# (exp(αˆorange0 + αˆorange1x) + exp(αˆapple0 + αˆapple1x)).
#
# (a) What is the log odds of orange versus apple in your model? 
# β^0 + β^1x

# (b) What is the log odds of orange versus apple in your friend’s model?
# alpha^orange0 + alpha^orange1x - alpha^apple0 - alpha^apple1x

# (c) Suppose that in your model, βˆ0 = 2 and βˆ1 = −1. What are 
#     the coefficient estimates in your friend’s model? Be as specific 
#     as possible. 
# 因此朋友模型的参数不唯一。
# 例如可以取：
# αorange0 = 2, αapple0 = 0
# αorange1 = -1, αapple1 = 0

# (d) Now suppose that you and your friend fit the same two models 
#     on a different data set. This time, your friend gets the coefficient 
#     estimates αˆorange0 = 1.2, αˆorange1 = −2, αˆapple0 = 3, 
#     αˆapple1 = 0.6. What are the coefficient estimates in your model?已知：
# β0 = αorange0 - αapple0
#    = 1.2 - 3
#    = -1.8
# β1 = αorange1 - αapple1
#    = -2 - 0.6
#    = -2.6 

# (e) Finally, suppose you apply both models from (d) to a data set 
#     with 2,000 test observations. What fraction of the time do you 
#     expect the predicted class labels from your model to agree with 
#     those from your friend’s model? Explain your answer. 
# 两个模型的log odds完全相同，
# 因此对每一个X都给出完全相同的预测概率和分类结果。
# 所以2000个测试样本中预测类别完全一致，
# 预期一致比例 = 100%。

library(ISLR2)
names(Smarket)
dim(Smarket)
summary(Smarket)
pairs(Smarket)
 
 glm.fit <- glm(
    Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume, data=Smarket, family=binomial
    )
summary(glm.fit)

glm.probs <- predict(glm.fit, type="response")
glm.probs[1:10]
contrasts(Smarket$Direction)
glm.pred <- rep("Down", 1250)
glm.pred[glm.probs > 0.5] <- "Up"
table(glm.pred, Smarket$Direction)
train <- (Smarket$Year < 2005)
Smarket.2005 <- Smarket[!train,]
dim(Smarket.2005)
glm.fit <- glm(
    Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume, data=Smarket, family=binomial, subset=train
    )
glm.probs <- predict(glm.fit, Smarket.2005, type="response")
glm.pred <- rep("Down", 252)
glm.pred[glm.probs > 0.5] <- "Up"
table(glm.pred, Smarket.2005$Direction)

library(MASS)
lda.fit <- lda(Direction ~ Lag1 + Lag2, data = Smarket, subset = train)
plot(lda.fit)
summary(lda.fit)
lda.fit$prior
lda.fit$counts
lda.fit$means
lda.fit$scaling

lda.pred <- predict(lda.fit, Smarket.2005)
names(lda.pred)
lda.class <- lda.pred$class
table(lda.class, Smarket.2005$Direction)

qda.fit <- qda(Direction ~ Lag1 + Lag2, data = Smarket, subset = train)
qda.class <- predict(qda.fit, Smarket.2005)$class
table(qda.class, Smarket.2005$Direction)

library(e1071)
nb.fit <- naiveBayes(Direction ~ Lag1 + Lag2, data = Smarket, subset = train)
nb.

library(class)
train.X <- cbind(Smarket$Lag1, Smarket$Lag2)[train,]
test.X <- cbind(Smarket$Lag1, Smarket$Lag2)[!train,]
train.Direction <- Smarket$Direction[train]
set.seed(1)
knn.pred <- knn(train.X, test.X, train.Direction, k=1)
table(knn.pred, Smarket.2005$Direction)
knn.pred <- knn(train.X, test.X, train.Direction, k=3)
table(knn.pred, Smarket.2005$Direction)
mean(knn.pred == Smarket.2005$Direction)

dim(Bikeshare)
names(Bikeshare)
mod.lm <- lm(
    bikers ~ mnth + hr + workingday + temp + weathersit , data = Bikeshare
    )
summary(mod.lm)
contrasts(Bikeshare$mnth) = contr.sum(12)
contrasts(Bikeshare$hr) = contr.sum(24)
mod.lm2 <- lm(
    bikers ~ mnth + hr + workingday + temp + weathersit , data = Bikeshare
    )
summary(mod.lm2)







# 第十三题 
# This question should be answered using the Weekly data set, which 
# is part of the ISLR2 package. This data is similar in nature to the 
# Smarket data from this chapter’s lab, except that it contains 1,089 
# weekly returns for 21 years, from the beginning of 1990 to the end 
# of 2010. 
library(ISLR2)
# (a) Produce some numerical and graphical summaries of the Weekly 
#     data. Do there appear to be any patterns? 
plot(Weekly)
# volum和year之间可能有指数级的关系，我看大部分数据的关联似乎对另一个数据解释性一般，没有较好的解释性啊

# (b) Use the full data set to perform a logistic regression with 
#     Direction as the response and the five lag variables plus Volume 
#     as predictors. Use the summary function to print the results. Do 
#     any of the predictors appear to be statistically significant? If so, 
#     which ones? 
logistics <- glm(
    Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume, data=Weekly, family=binomial
    )
summary(logistics)
只能观察到Lag2的p值小于0.05，其他变量的p值都大于0.05，因此只有Lag2是统计显著的。
# (c) Compute the confusion matrix and overall fraction of correct 
#     predictions. Explain what the confusion matrix is telling you 
#     about the types of mistakes made by logistic regression. 

glm.probs <- predict(logistics, type = "response")
glm.pred <- rep("Down", nrow(Weekly))
glm.pred[glm.probs > 0.5] <- "Up"

table(glm.pred, Weekly$Direction)
efficent <- list()
efficent$glm <- mean(glm.pred == Weekly$Direction)
# (d) Now fit the logistic regression model using a training data period 
#     from 1990 to 2008, with Lag2 as the only predictor. Compute the 
#     confusion matrix and the overall fraction of correct predictions 
#     for the held out data (that is, the data from 2009 and 2010).
train <- (Weekly$Year < 2009)
test <- (!train)
lag2_logistics <- glm(
    Direction ~ Lag2, data = Weekly, family = binomial, subset = train
)
probs <- predict(lag2_logistics, Weekly[test,], type = "response")
pred <- rep("Down", nrow(Weekly[test,]))
pred[probs > 0.5] <- "Up"
table(pred, Weekly[test,]$Direction)
efficent <-  list()
efficent$logistics <- mean(pred == Weekly[test,]$Direction)

# (e) Repeat (d) using LDA.
library(MASS)

LDA.fit <- lda(
    Direction ~ Lag2, data = Weekly, subset = train
)

probs <- predict(LDA.fit, Weekly[test,], type = "response")
predi <- rep("Down", nrow(Weekly[test,]))
predi[probs$posterior[,2] > 0.5] <- "Up"
table(predi, Weekly[test,]$Direction)
efficent$lda <- mean(predi == Weekly[test,]$Direction)

# (f) Repeat (d) using QDA. 
QDA.fit <- qda(
    Direction ~ Lag2, data = Weekly, subset = train
)
probs <- predict(QDA.fit, Weekly[test,], type = "response")
predq <- rep("Down", nrow(Weekly[test,]))
predq[probs$posterior[,2] > 0.5] <- "Up"
table(predq, Weekly[test,]$Direction)
efficent$qda <- mean(predq == Weekly[test,]$Direction)

# (g) Repeat (d) using KNN with K = 1. 
library(class)
KNN.fit <- knn(
    train = as.matrix(Weekly[train,]$Lag2),
    test = as.matrix(Weekly[test,]$Lag2),
    cl = Weekly[train,]$Direction,
    k = 3
)
predk <- KNN.fit
efficent$knn <- mean(predk == Weekly[test,]$Direction)

# (h) Repeat (d) using naive Bayes. 
library(e1071)
NB.fit <- naiveBayes(
    Direction ~ Lag2, data = Weekly, subset = train
)
probnb <- predict(NB.fit, Weekly[test,], type = "raw")
prednb <- rep("Down", nrow(Weekly[test,]))
prednb[probnb[,2] > 0.5] <- "Up"
efficent$nb <- mean(prednb == Weekly[test,]$Direction)

# (i) Which of these methods appears to provide the best results on 
#     this data? 
print(efficent)
# (j) Experiment with different combinations of predictors, including 
#     possible transformations and interactions, for each of the methods. 
#     Report the variables, method, and associated confusion matrix that 
#     appears to provide the best results on the held out data. Note that 
#     you should also experiment with values for K in the KNN classifier. 
for (i in 1:10) {
   knn.fit <- knn(
        train = as.matrix(Weekly[train,c("Lag1")]),
        test = as.matrix(Weekly[test,]),
        cl = Weekly[train,]$Direction,
        k = i
    )
    predk <- knn.fit
    efficent$knn[i] <- mean(predk == Weekly[test,]$Direction)
}
print(efficent)

# 第十四题 
# In this problem, you will develop a model to predict whether a given 
# car gets high or low gas mileage based on the Auto data set. 
summary(Auto)

# (a) Create a binary variable, mpg01, that contains a 1 if mpg contains 
#     a value above its median, and a 0 if mpg contains a value below 
#     its median. You can compute the median using the median() function. 
#     Note you may find it helpful to use the data.frame() function to 
#     create a single data set containing both mpg01 and the other Auto 
#     variables. 
median_mpg <- median(Auto$mpg)
mpg01 <- data.frame(mpg01 = ifelse(Auto$mpg > median_mpg, 1, 0), Auto)
print(head(mpg01))

# (b) Explore the data graphically in order to investigate the association 
#     between mpg01 and the other features. Which of the other features 
#     seem most likely to be useful in predicting mpg01? Scatterplots and 
#     boxplots may be useful tools to answer this question. Describe your 
#     findings. 
par(mfrow = c(2, 4))
boxplot(cylinders ~ mpg01, data = mpg01, main = "Cylinders vs mpg01")
boxplot(displacement ~ mpg01, data = mpg01, main = "Displacement vs mpg01")
boxplot(horsepower ~ mpg01, data = mpg01, main = "Horsepower vs mpg01")
boxplot(weight ~ mpg01, data = mpg01, main = "Weight vs mpg01")
boxplot(acceleration ~ mpg01, data = mpg01, main = "Acceleration vs mpg01")
boxplot(year ~ mpg01, data = mpg01, main = "Year vs mpg01")
boxplot(origin ~ mpg01, data = mpg01, main = "Origin vs mpg01")

# (c) Split the data into a training set and a test set. 
set.seed(123)
train_indices <- sample(1:nrow(mpg01), size = 0.7 * nrow(mpg01))
train <- mpg01[train_indices, ]
test <- mpg01[-train_indices, ]

# (d) Perform LDA on the training data in order to predict mpg01 using 
#     the variables that seemed most associated with mpg01 in (b). What 
#     is the test error of the model obtained? 
LDA.fit <- lda(mpg01 ~ cylinders + displacement + horsepower + weight + year, data = train)
probLD <- predict(LDA.fit, newdata = test)
predLD <- rep("0", nrow(test)) 
predLD[probLD$class == 1] <- "1"
efficent <- list() 
efficent$LDA <- mean(predLD == mpg01[-train_indices,]$mpg01)
table(Predicted = predLD, Actual = test$mpg01)

# (e) Perform QDA on the training data in order to predict mpg01 using 
#     the variables that seemed most associated with mpg01 in (b). What 
#     is the test error of the model obtained? 
qda.fit <- qda(mpg01 ~ cylinders + displacement + horsepower + weight + year, data = train)
probqda <- predict(qda.fit, test)
predqda <- rep("0",nrow(test))
predqda[probqda$class == 1] <- "1" 
efficent$qda <- mean(predqda == mpg01[-train_indices, ]$mpg01)
table(predicted = predqda, Actual = test$mpg01)

# (f) Perform logistic regression on the training data in order to predict 
#     mpg01 using the variables that seemed most associated with mpg01 
#     in (b). What is the test error of the model obtained?
log.fit <- glm(mpg01 ~ cylinders + displacement + horsepower +weight +year, data = train, family = binomial) 
problog <- predict(log.fit, test, type = "response")
predlog <- rep("0", nrow(test))
predlog[problog > 0.5] <- "1" 
efficent$log <- mean(predlog == mpg01[-train_indices, ]$mpg01)
table(predicted = predlog, Actual = test$mpg01)

# (g) Perform naive Bayes on the training data in order to predict mpg01 
#     using the variables that seemed most associated with mpg01 in (b). 
#     What is the test error of the model obtained?

nb.fit <- naiveBayes(
    mpg01 ~ cylinders + displacement + horsepower + weight + year, data = train
)
probnb <- predict(nb.fit, test)
prednb <- rep("0", nrow(test))
prednb[probnb == 1 ] <- "1"
efficent$nb <- mean(predlog == mpg01[-train_indices, ]$mpg01)
table(prdicted = prednb, Actual = test$mpg01)

# (h) Perform KNN on the training data, with several values of K, in order 
#     to predict mpg01. Use only the variables that seemed most associated 
#     with mpg01 in (b). What test errors do you obtain? Which value of K 
#     seems to perform the best on this data set? 

for (i in 1:100) {
   knn.fit <- knn(
        train = as.matrix(train[c("cylinders", "displacement", "horsepower", "weight", "year")]),
        test = as.matrix(test[c("cylinders", "displacement", "horsepower", "weight", "year")]),
        cl = mpg01[train_indices,]$mpg01,
        k = i
    )
    predk <- knn.fit
    efficent$knn[i] <- mean(predk == test$mpg01)
}
print(efficent)
plot(
    1:100,
    efficent$knn,
    type = "b",
    xlab = "K",
    ylab = "Accuracy"
)
dev.off()
lines(
    lowess(1:100, efficent$knn),
    lwd = 2
)
# 第十五题 
# This problem involves writing functions. 
#
# (a) Write a function, Power(), that prints out the result of raising 2 
#     to the 3rd power. In other words, your function should compute 2^3 
#     and print out the results. 
#     Hint: Recall that x^a raises x to the power a. Use the print() 
#     function to output the result.
Power <- function(){
    result <- 2^3
    print(result)
}
# (b) Create a new function, Power2(), that allows you to pass any two 
#     numbers, x and a, and prints out the value of x^a. You can do this 
#     by beginning your function with the line 
#     Power2 <- function(x, a) {
#     You should be able to call your function by entering, for instance, 
#     Power2(3, 8)
#     on the command line. This should output the value of 3^8, namely, 
#     6,561.
Power2 <- function(x, a){
    result <- x^a
    print(result)
}
Power2(3,8) 


# (c) Using the Power2() function that you just wrote, compute 10^3, 
#     8^17, and 13^3.
Power2(10, 3)
Power2(8, 17)
Power2(13, 3)

# (d) Now create a new function, Power3(), that actually returns the 
#     result x^a as an R object, rather than simply printing it to the 
#     screen. That is, if you store the value x^a in an object called 
#     result within your function, then you can simply return() this result 
#     using the following line:
#     return(result)
#     The line above should be the last line in your function, before the 
#     } symbol. 
Power3 <- function(x, a){
    result <- x^a
    return(result)
}

# (e) Now using the Power3() function, create a plot of f(x) = x^2. 
#     The x-axis should display a range of integers from 1 to 10, and 
#     the y-axis should display x^2. Label the axes appropriately, and 
#     use an appropriate title for the figure. Consider displaying either 
#     the x-axis, the y-axis, or both on the log-scale. You can do this 
#     by using log = "x", log = "y", or log = "xy" as arguments to the 
#     plot() function. 
plot(
    1:10,
    Power2(1:10, 2),
    xlab = "x",
    ylab = "x^2",
    main = "square"
    )
dev.off()


# (f) Create a function, PlotPower(), that allows you to create a plot 
#     of x against x^a for a fixed a and for a range of values of x. For 
#     instance, if you call:
#     PlotPower(1:10, 3)
#     then a plot should be created with an x-axis taking on values 
#     1, 2,...,10, and a y-axis taking on values 1^3, 2^3,...,10^3. 
Power3 <- function(x, a) {
    plot(
        x,
        x^a,
        xlab = "x",
        ylab = "y",
        main = "figure"
    )

}
Power3(1:10, 3)
# 第十六题 
# Using the Boston data set, fit classification models in order to predict 
# whether a given census tract has a crime rate above or below the median. 
# Explore logistic regression, LDA, naive Bayes, and KNN models using 
# various subsets of the predictors. Describe your findings. 
#
# Hint: You will have to create the response variable yourself, using the 
# variables that are contained in the Boston data set.
