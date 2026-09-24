library(ISLR2)
# 第 1 题
# Suppose we test m null hypotheses, all of which are true. We control the
# Type I error for each null hypothesis at level α. For each subproblem,
# justify your answer.
#
# (a) In total, how many Type I errors do we expect to make?
# 每个检验发生 Type I error 的概率为 alpha。
# 所以期望的 Type I error 数：
# E(V) = m * alpha

# (b) Suppose that the m tests we perform are independent. What is the
# family-wise error rate associated with these m tests?
# FWER = 至少出现一次 Type I error 的概率。
# 所有检验都不犯错的概率：
# (1-alpha)^m
# 所以：
# FWER = 1 - (1-alpha)^m
#
# (c) Suppose that m = 2 and that the p-values for the two tests are positively
# correlated, so that if one is small then the other tends to be small as well,
# and if one is large then the other tends to be large. How does the family-wise
# error rate associated with these two tests qualitatively compare to the answer
# in part (b) with m = 2?
#
# Hint: First suppose that the two p-values are perfectly correlated.
# 正相关时，两个检验更倾向于一起 reject 或一起不 reject。
# 因此 FWER 比独立情况小。
# 完全正相关时相当于只做一次检验：
# FWER = alpha
# 独立时：
# FWER = 1-(1-alpha)^2

# (d) Suppose again that m = 2, but now the p-values for the two tests are
# negatively correlated, so that if one is large then the other tends to be
# small. How does the family-wise error rate associated with these two tests
# qualitatively compare to the answer in part (b) with m = 2?
#
# Hint: First suppose that whenever one p-value is less than α, the other is
# greater than α. In other words, we can never reject both null hypotheses.
# 负相关时，更容易出现“至少一个被 reject”。
# 因此 FWER 比独立情况大。
# 极端情况下两个检验绝不会同时 reject：
# FWER = 2*alpha

# 第 2 题
# Suppose that we test m hypotheses and control the Type I error for each
# hypothesis at level α. Assume that all m p-values are independent and that
# all null hypotheses are true.

# (a) Let the random variable A_j equal 1 if the jth null hypothesis is rejected
# and 0 otherwise. What is the distribution of A_j?
# A_j ~ Bernoulli(alpha)

# (b) What is the distribution of sum(j = 1 to m) A_j?
# sum(A_j) ~ Binomial(m, alpha)

# (c) What is the standard deviation of the number of Type I errors that we
# will make?
# Binomial(m, alpha) 的标准差：
# SD = sqrt(m * alpha * (1-alpha))

# 第 3 题
# Suppose we test m null hypotheses and control the Type I error for the jth
# null hypothesis at level α_j, for j = 1, ..., m. Argue that the family-wise
# error rate is no greater than sum(j = 1 to m) α_j.
# FWER <= sum(alpha_j)

# 第 4 题
# Suppose we test m = 10 hypotheses and obtain the following p-values:
#
# Null Hypothesis    p-value
# H01                0.0011
# H02                0.0310
# H03                0.0170
# H04                0.3200
# H05                0.1100
# H06                0.9000
# H07                0.0700
# H08                0.0060
# H09                0.0040
# H10                0.0009
p <- c(0.0011, 0.031, 0.017, 0.320, 0.110,
       0.900, 0.070, 0.006, 0.004, 0.0009)
names(p) <- paste0("H0", 1:10)
# (a) Suppose that we wish to control the Type I error for each null hypothesis
# at level α = 0.05. Which null hypotheses will we reject?# 单独控制 Type I error：p < 0.05
# reject：
# H01, H02, H03, H08, H09, H10

# (b) Now suppose that we wish to control the FWER at level α = 0.05. Which
# null hypotheses will we reject? Justify your answer.
# Bonferroni 控制 FWER：
# threshold = 0.05 / 10 = 0.005
# reject：
# H01, H09, H10

# (c) Now suppose that we wish to control the FDR at level q = 0.05. Which null
# hypotheses will we reject? Justify your answer.
# BH 控制 FDR = 0.05
# 排序后最大的满足：
# p_(j) <= 0.05*j/10
# j = 5
# reject：
# H01, H03, H08, H09, H10

# (d) Now suppose that we wish to control the FDR at level q = 0.20. Which null
# hypotheses will we reject? Justify your answer.
# BH 控制 FDR = 0.20
# 最大满足条件的是 j = 8
# reject：
# H01, H02, H03, H05,
# H07, H08, H09, H10

# (e) Of the null hypotheses rejected at FDR level q = 0.20, approximately how
# many are false positives? Justify your answer.
# 一共 reject 8 个。
# 预计 false positives：
# 0.20 * 8 = 1.6
# 即大约 2 个。

# 第 5 题
# For this problem, you will make up p-values that lead to a specified number
# of rejections using the Bonferroni and Holm procedures.
#
# (a) Give an example of five p-values, meaning five numbers between 0 and 1
# that we interpret as p-values, for which both Bonferroni's method and Holm's
# method reject exactly one null hypothesis when controlling the FWER at level
# 0.10.

p <- c(0.001, 0.03, 0.4, 0.6, 0.8)
# Bonferroni threshold = 0.1/5 = 0.02
# 只有 0.001 被 reject。
# Holm：
# 0.001 < 0.02
# 但 0.03 > 0.025
# 所以也只 reject 1 个。

# (b) Give an example of five p-values for which Bonferroni rejects one null
# hypothesis and Holm rejects more than one null hypothesis when controlling the
# FWER at level 0.10.
# Bonferroni reject 1 个，
# Holm reject 2 个的例子：

p <- c(0.001, 0.024, 0.04, 0.6, 0.8)

# Bonferroni：
# threshold = 0.02
# 只 reject 0.001。
# Holm：
# 0.001 < 0.02
# 0.024 < 0.025
# 0.04 > 0.0333
# 所以 Holm reject 前两个。

# 第 6 题
# For each of the three panels in Figure 13.3, answer the following questions.
#
# (a) How many false positives, false negatives, true positives, true negatives,
# Type I errors, and Type II errors result from applying the Bonferroni procedure
# to control the FWER at level α = 0.05?
# Panel 1：
# FP = 0
# FN = 1
# TP = 7
# TN = 2
# Type I = 0
# Type II = 1

# Panel 2：
# FP = 0
# FN = 1
# TP = 7
# TN = 2
# Type I = 0
# Type II = 1

# Panel 3：
# FP = 0
# FN = 5
# TP = 3
# TN = 2
# Type I = 0
# Type II = 5

# (b) How many false positives, false negatives, true positives, true negatives,
# Type I errors, and Type II errors result from applying the Holm procedure to
# control the FWER at level α = 0.05?
# Panel 1：
# FP = 0
# FN = 1
# TP = 7
# TN = 2

# Panel 2：
# FP = 0
# FN = 0
# TP = 8
# TN = 2

# Panel 3：
# FP = 0
# FN = 0
# TP = 8
# TN = 2

# Type I = FP
# Type II = FN

# (c) What is the false discovery proportion associated with using the
# Bonferroni procedure to control the FWER at level α = 0.05?
# Panel 1 = 0/7 = 0
# Panel 2 = 0/7 = 0
# Panel 3 = 0/3 = 0

# (d) What is the false discovery proportion associated with using the Holm
# procedure to control the FWER at level α = 0.05?
# Panel 1 = 0/7 = 0
# Panel 2 = 0/8 = 0
# Panel 3 = 0/8 = 0

# (e) How would the answers to parts (a) and (c) change if we instead used the
# Bonferroni procedure to control the FWER at level α = 0.001?
# 如果 FWER = 0.001：
# Bonferroni threshold：
# 0.001/10 = 0.0001
# threshold 更严格，所以 Type II error 增加
# 从 Figure 13.3 读图：
# Panel 1：
# TP = 3, FN = 5, FP = 0, TN = 2
# Panel 2：
# TP = 2, FN = 6, FP = 0, TN = 2
# Panel 3：
# TP = 2, FN = 6, FP = 0, TN = 2
# 三个 panel 的 FDP 仍然都是 0。

# 第 7 题
# This problem makes use of the Carseats data set in the ISLR2 package.
#
# (a) For each quantitative variable in the data set besides Sales, fit a linear
# model to predict Sales using that quantitative variable. Report the p-values
# associated with the coefficients for the variables. That is, for each model
# of the form
#
# Y = β0 + β1*X + ε,
#
# report the p-value associated with β1. Here, Y represents Sales and X
# represents one of the other quantitative variables.
vars <- c("CompPrice", "Income", "Advertising",
          "Population", "Price", "Age", "Education")

pvals <- sapply(vars, function(x) {
  summary(lm(Carseats$Sales ~ Carseats[[x]]))$coef[2, 4]
})

# (b) Suppose we control the Type I error at level α = 0.05 for the p-values
# obtained in part (a). Which null hypotheses do we reject?
# 单独控制 Type I error = 0.05
#
# reject：
# Income
# Advertising
# Price
# Age


# (c) Now suppose we control the FWER at level 0.05 for the p-values. Which null
# hypotheses do we reject?
# Bonferroni 控制 FWER = 0.05
#
# m = 7
# threshold = 0.05/7 = 0.00714
#
# reject：
# Income
# Advertising
# Price
# Age

# (d) Finally, suppose we control the FDR at level 0.20 for the p-values. Which
# null hypotheses do we reject?
# BH 控制 FDR = 0.20
p.adjust(pvals, method = "BH")
# reject：
# Income
# Advertising
# Price
# Age

# 第 8 题
# In this problem, we will simulate data from m = 100 fund managers.
#
# set.seed(1)
# n <- 20
# m <- 100
# X <- matrix(rnorm(n * m), ncol = m)
#
# These data represent each fund manager's percentage returns for each of
# n = 20 months. We wish to test the null hypothesis that each fund manager's
# percentage returns have population mean zero. Notice that the data were
# simulated so that every fund manager's percentage returns have population
# mean zero; in other words, all m null hypotheses are true.
#
# (a) Conduct a one-sample t-test for each fund manager, and plot a histogram of
# the p-values obtained.
#
# (b) If we control the Type I error for each null hypothesis at level α = 0.05,
# how many null hypotheses do we reject?
#
# (c) If we control the FWER at level 0.05, how many null hypotheses do we
# reject?
#
# (d) If we control the FDR at level 0.05, how many null hypotheses do we
# reject?
#
# (e) Now suppose we cherry-pick the 10 fund managers who perform best in our
# data. If we control the FWER for just these 10 fund managers at level 0.05,
# how many null hypotheses do we reject? If we control the FDR for just these
# 10 fund managers at level 0.05, how many null hypotheses do we reject?
#
# (f) Explain why the analysis in part (e) is misleading.
#
# Hint: Standard approaches for controlling the FWER and FDR assume that all
# tested null hypotheses are adjusted for multiplicity and that no
# cherry-picking of the smallest p-values has occurred. What goes wrong if we
# cherry-pick?