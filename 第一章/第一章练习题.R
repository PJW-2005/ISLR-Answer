### 第一题
# For each of parts (a) through (d), indicate whether we would generally
# expect the performance of a flexible statistical learning method to be
# better or worse than an inflexible method. Justify your answer.
# (a) The sample size n is extremely large, and the number of predictors p is small. 
# better， 因为高样本容量中，高复杂度能够让样本充分学习到数据件的关联，从而使样本的偏差下降，且由于多样本的
# 约束自身的方差也能够下降

# (b) The number of predictors p is extremely large, and the number
# of observations n is small.
# worse 因为可以学习的样本太少，过高的复杂度回有过拟合的风险，容易导致variance爆炸，可能学习到的使error
# (c) The relationship between the predictors and response is highly
# non-linear.
# better 高复杂度才能刻画出这种非线性关系，简单模型的bias过高
# (d) The variance of the error terms, i.e. σ2 = Var(ϵ), is extremely
# high.
# worse 高复杂度可能导致学习到的主要是噪声

### 第二题
# Explain whether each scenario is a classification or regression prob￾lem, 
# and indicate whether we are most interested in inference or pre￾diction. Finally, provide n and p.
# (a) We collect a set of data on the top 500 firms in the US. For each
# firm we record profit, number of employees, industry and the
# CEO salary. We are interested in understanding which factors
# affect CEO salary.
# 这是个回归问题 我们在意的是这个推理的过程 这里的n样本量是500家CEo的薪水 P参数是利润，雇佣员工的数量

# (b) We are considering launching a new product and wish to know
# whether it will be a success or a failure. We collect data on 20
# similar products that were previously launched. For each product we have recorded whether it was a success or failure, price
# charged for the product, marketing budget, competition price,
# and ten other variables.
# 这是个预测问题， 其中的样本量n是20多个的产品，然后特征是市场预期，产品价格，竞品价格
# (c) We are interested in predicting the % change in the USD/Euro
# exchange rate in relation to the weekly changes in the world
# stock markets. Hence we collect weekly data for all of 2012. For
# each week we record the % change in the USD/Euro, the %
#   change in the US market, the % change in the British market,
# and the % change in the German market
#  这是个预测问题，数据是2012年整周的数量，特征是各个市场的比率的变化

###第三题
# We now revisit the bias-variance decomposition.
# (a) Provide a sketch of typical (squared) bias, variance, training error, test
# error, and Bayes (or irreducible) error curves, on a single plot, as we go from less flexible statistical learning methods
# towards more flexible approaches. The x-axis should represent
# the amount of flexibility in the method, and the y-axis should
# represent the values for each curve. There should be five curves.
# Make sure to label each one.
# (b) Explain why each of the five curves has the shape displayed in
#  part (a).
# 对于偏差应该整体呈现一个持续下降的趋势，对于方差应该呈现出上升的趋势，训练误差应该要一直下降，而测试误差应该先下降后上升，对于不可约误差应该一直保持不变
# 这是因为复杂度高以后偏差的拟合效果变好，整体预测准确度上升，但是对于单个数据变化更敏感，二者一叠加导致测试误差应该为先下降后上升的趋势 而对测试误差而言遵循梯度下降应该一直减少，误差不可变

###第四题
# You will now think of some real-life applications for statistical learning.
# (a) Describe three real-life applications in which classification might
# be useful. Describe the response, as well as the predictors. Is the
# goal of each application inference or prediction? Explain your
# answer.
# 对于生成的回应是否是离散的类别 自动驾驶需要图像识别 对于工厂优劣产品开发需要进行分类 对于不同股票的相同变化趋势的归因系统需要鉴别
# (b) Describe three real-life applications in which regression might
# be useful. Describe the response, as well as the predictors. Is the
# goal of each application inference or prediction? Explain your
# answer.
# 对于生成的响应是否是连续的数值 需要定量的东西可能需要回归，比如客户流量 股价预测 销售额 进货额 
# (c) Describe three real-life applications in which cluster analysis
# might be useful.
# 对于有没有明确的response 用户画像归类 和性质相关的东西？且无法被特征刻画？ 

###第五题
# What are the advantages and disadvantages of a very flexible (versus
# a less flexible) approach for regression or classification? Under what
# circumstances might a more flexible approach be preferred to a less
# flexible approach? When might a less flexible approach be preferred?
# 过高的复杂度会使得方差的值增加，从而使得回归多次预测函数出现动荡现象，而且解释性下降，对于分类问题，这会
# 导致有较多的分类错误现象的产生 好处是回归预测的总体值的准确率更高 分类预测一致，其实分类和回归的核心区别就是在于多了个分类头，将连续值变成了分类值
# 在多样本的情况下适合使用更多复杂度，且目标函数复杂，目标以预测为主的方法 这种适合存在较多的约束 而在小样本情况下适合使用少复杂度 目标为解释模型

###第六题
# Describe the differences between a parametric and a non-parametric
# statistical learning approach. What are the advantages of a parametric approach 
# to regression or classification (as opposed to a nonparametric approach)? What are its disadvantages?
# 对于参数模型而言，它选用的是利用参数去刻画出来目标函数f 对于非参模型它没有明显的参数而是去对数据点进行分雷预估
# 它的优势在于参数模型更便于刻画模型效果，而劣势在于它对于f目标函数属于强约束
# 对于分参数模型而言它不便于刻画模型效果，但是它对于f目标函数属于弱约束
# 参数化统计学习方法假设预测变量与响应变量之间的关系具有特定的函数形式，并估计固定数量的参数。例如，线性回归假设响应变量可以表示为预测变量的线性组合。非参数化方法则不对函数形式做出明确假设，而是由数据本身决定关系的结构。
# 参数化方法的主要优势在于其简单、计算效率高且所需观测样本较少。此外，由于估计的参数具有明确的含义，因此模型的可解释性更强。然而，其缺点是如果所假设的函数形式不正确，模型可能会产生较大的偏差，导致预测性能较差。
# 非参数化方法更具灵活性，能够捕捉复杂和非线性的关系。但通常需要更多的数据，方差较高，且更难解释。

###第七题
# The table below provides a training data set containing six observations, three predictors, and one qualitative response variable.
# Obs. X1 X2 X3 Y
# 1 0 3 0 Red
# 2 2 0 0 Red
# 3 0 1 3 Red
# 4 0 1 2 Green
# 5 −1 0 1 Green
# 6 1 1 1 Red
# Suppose we wish to use this data set to make a prediction for Y when
# X1 = X2 = X3 = 0 using K-nearest neighbors.
data <- matrix(c(0, 3, 0, 2, 0, 0, 0, 1, 3, 0, 1, 2, -1, 0, 1, 1, 1, 1), nrow = 6, byrow = TRUE)
data_frame <- as.data.frame(data)
colnames(data_frame) <- c("X1", "X2", "X3")
data_frame$Y <- c("Red", "Red", "Red", "Green", "Green", "Red")

df <- data.frame(
                  X1 = c(0, 2, 0, 0, -1, 1),
                  X2 = c(3, 0, 1, 1, 0, 1 ),
                  X3 = c(0, 0, 3, 2, 1, 1),
                  Y = c("Red", "Red", "Red", "Green", "Green", "Red"))

Euclidean_distance <- function(x, y){
  sqrt(sum((x-y)^2))
}

KNN <- function(df, k){ 
  ord <- order(df$distance)
  category <- df[ord,]$Y[1:k]
  print(names(which.max(table(category))))
  }

# (a) Compute the Euclidean distance between each observation and the test point, X1 = X2 = X3 = 0.
df$distance <- apply(df[,c("X1", "X2", "X3")], 1, function(x){Euclidean_distance(x, c(0, 0, 0))})
head(df$distance)  

# (b) What is our prediction with K = 1? Why?
a <- KNN(df, 1)

# (c) What is our prediction with K = 3? Why?
b <- KNN(df, 3)
# (d) If the Bayes decision boundary in this problem is highly nonlinear, then 
# would we expect the best value for K to be large or small? Why?
#我们会希望这个K较小一点，较小的K意味着它的整体的偏差会减小更容易拟合非线性，模型更灵活

###第八题
# This exercise relates to the College data set, which can be found in
# the file College.csv on the book website. It contains a number of
# variables for 777 different universities and colleges in the US. The
# variables are
# • Private : Public/private indicator
# • Apps : Number of applications received
# • Accept : Number of applicants accepted
# • Enroll : Number of new students enrolled
# • Top10perc : New students from top 10 % of high school class
# • Top25perc : New students from top 25 % of high school class
# • F.Undergrad : Number of full-time undergraduates
# • P.Undergrad : Number of part-time undergraduates
# • Outstate : Out-of-state tuition
# • Room.Board : Room and board costs
# • Books : Estimated book costs
# • Personal : Estimated personal spending
# • PhD : Percent of faculty with Ph.D.’s
# • Terminal : Percent of faculty with terminal degree
# • S.F.Ratio : Student/faculty ratio
# • perc.alumni : Percent of alumni who donate
# • Expend : Instructional expenditure per student
# • Grad.Rate : Graduation rate
# Before reading the data into R, it can be viewed in Excel or a text
# editor.
# (a) Use the read.csv() function to read the data into R. Call the
# loaded data college. Make sure that you have the directory set
# to the correct location for the data.
college <- read.csv("college.csv")
# (b) Look at the data using the View() function. You should notice
# that the first column is just the name of each university. We don’t
# really want R to treat this as data. However, it may be handy to
# have these names for later. Try the following commands:
rownames(college) <- college[, 1]
View(college)
# You should see that there is now a row.names column with the
# name of each university recorded. This means that R has given
# each row a name corresponding to the appropriate university. R
# will not try to perform calculations on the row names. However,
# we still need to eliminate the first column in the data where the
# names are stored. Try
college <- college[, -1]
View(college)
# Now you should see that the first data column is Private. Note
# that another column labeled row.names now appears before the
# Private column. However, this is not a data column but rather
# the name that R is giving to each row.
# (c) i. Use the summary() function to produce a numerical summary
# of the variables in the data set.
summary(college)
# ii. Use the pairs() function to produce a scatterplot matrix of
# the first ten columns or variables of the data. Recall that
# you can reference the first ten columns of a matrix A using
pairs(college[,2:5])
dev.off()
# iii. Use the plot() function to produce side-by-side boxplots of
# Outstate versus Private.
plot(as.factor(college$Private), college$Outstate)
# iv. Create a new qualitative variable, called Elite, by binning
# the Top10perc variable. We are going to divide universities
# into two groups based on whether or not the proportion
# of students coming from the top 10 % of their high school
# classes exceeds 50 %.
Elite <- rep("No", nrow(college))
Elite[college$Top10perc > 50] <- "Yes"
Elite <- as.factor(Elite)
college <- data.frame(college, Elite)
# Use the summary() function to see how many elite universities there are. Now use the plot() function to produce
# side-by-side boxplots of Outstate versus Elite.
# v. Use the hist() function to produce some histograms with
# differing numbers of bins for a few of the quantitative variables. You may find 
# the command par(mfrow = c(2, 2))useful: it will divide the print window into four regions so
# that four plots can be made simultaneously. Modifying the
# arguments to this function will divide the screen in other
# ways.
par(mfrow = c(2,2))
hist(college$Accept, breaks = 5, mfrow = c(2, 2))
hist(college$Apps, breaks=5)
hist(college$Enroll, breaks=5)
hist(college$Outstate, breaks=5)
# vi. Continue exploring the data, and provide a brief summary
# of what you discover.

###第九题
# This exercise involves the Auto data set studied in the lab. Make sure
# that the missing values have been removed from the data.
Auto <- read.csv("Auto.csv")
# (a) Which of the predictors are quantitative, and which are qualitative?
# (b) What is the range of each quantitative predictor? You can answer this using the range() function. range()
# 除了Year origin name
# (c) What is the mean and standard deviation of each quantitative
# predictor?
df$distance <- apply(df[,c("X1", "X2", "X3")], 1, function(x){Euclidean_distance(x, c(0, 0, 0))})
Auto_sd <- apply(Auto[,c("mpg", "displacement", "weight", "acceleration" )], 2, function(x){sd(x)})
# (d) Now remove the 10th through 85th observations. What is the
# range, mean, and standard deviation of each predictor in the
# subset of the data that remains?
Auto_remain <- Auto[c(-10, -85),]
summary(Auto_remain)
Auto_remain_sd <- apply(Auto[,c("mpg", "displacement", "weight", "acceleration" )], 2, function(x){sd(x)})
remove(Auto_remain)
remove(Auto_remain_sd)
# (e) Using the full data set, investigate the predictors graphically,
# using scatterplots or other tools of your choice. Create some plots
# highlighting the relationships among the predictors. Comment
# on your findings.
par(mfrow = c(2,2))
plot(Auto$mpg, Auto$displacement)
hist(Auto$mpg)
pairs(Auto[,c("mpg", "displacement", "weight", "acceleration" )])
dev.off()
# (f) Suppose that we wish to predict gas mileage (mpg) on the basis
# of the other variables. Do your plots suggest that any of the
# other variables might be useful in predicting mpg? Justify your
# answer.
# displacement 和 weight我觉得线性性较强可以用来进行预测

###第10题
# This exercise involves the Boston housing data set.
# (a) To begin, load in the Boston data set. The Boston data set is
# part of the ISLR2 library.
library(ISLR2)
# Now the data set is contained in the object Boston.
Boston
# Read about the data set:
# How many rows are in this data set? How many columns? What
# do the rows and columns represent?
?Boston
#   (b) Make some pairwise scatterplots of the predictors (columns) in
# this data set. Describe your findings.
pairs(Boston)
# (c) Are any of the predictors associated with per capita crime rate?
#   If so, explain the relationship.
plot(Boston$dis,log(Boston$crim))
plot(Boston$age,log(Boston$crim))
cor(Boston$age,log(Boston$crim))
cor(Boston$dis,log(Boston$crim))
# dis和age有一定的相关性，但是
# (d) Do any of the census tracts of Boston appear to have particularly
# high crime rates? Tax rates? Pupil-teacher ratios? Comment on
# the range of each predictor.
# (e) How many of the census tracts in this data set bound the Charles
# river?
#   (f) What is the median pupil-teacher ratio among the towns in this
# data set?
#   (g) Which census tract of Boston has lowest median value of owneroccupied homes? What are the values of the other predictors
# for that census tract, and how do those values compare to the
# overall ranges for those predictors? Comment on your findings.
# (h) In this data set, how many of the census tracts average more than
# seven rooms per dwelling? More than eight rooms per dwelling?
#   Comment on the census tracts that average more than eight
# rooms per dwelling.
# 




###思考：第一题
#复杂度和样本大小的关系，如何去进行选择
# 刻画模型复杂度的方法 VC theor?
# 这里有一个VC维的问题，它描述了我们为什么能够使用数据学习进行学习的过程
# 如何去根据样本量选择复杂度？
# BIC和AIC
# 最近研究进展？
# 在2019年出现了一个双降的理论Deep Double Descent: Where Bigger Models and More Data Hurt
# 测试
# 对于不同股票的相同变化趋势的归因系统需要鉴别


