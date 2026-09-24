library(ISLR2)
library(survival)

# 第 1 题
# For each example, state whether or not the censoring mechanism is independent.
# Justify your answer.
#
# (a) In a study of disease relapse, due to a careless research scientist, all
# patients whose phone numbers begin with the number "2" are lost to follow-up.
# I

# (b) In a study of longevity, a formatting error causes all patient ages that
# exceed 99 years to be lost. That is, we know that those patients are more than
# 99 years old, but we do not know their exact ages.
# I

# (c) Hospital A conducts a study of longevity. However, very sick patients tend
# to be transferred to Hospital B and are lost to follow-up.
# NI

# (d) In a study of unemployment duration, the people who find work earlier are
# less motivated to stay in touch with study investigators, and therefore are
# more likely to be lost to follow-up.
# NI

# (e) In a study of pregnancy duration, women who deliver their babies pre-term
# are more likely to do so away from their usual hospital, and thus are more
# likely to be censored than women who deliver full-term babies.
# NI

# (f) A researcher wishes to model the number of years of education of the
# residents of a small town. Residents who enroll in college out of town are
# more likely to be lost to follow-up, and are also more likely to attend
# graduate school, than those who attend college in town.
# NI

# (g) Researchers conduct a study of disease-free survival, meaning the time
# until disease relapse following treatment. Patients who have not relapsed
# within five years are considered cured, and thus their survival time is
# censored at five years.
# I

# (h) We wish to model the failure time for an electrical component. This
# component can be manufactured in Iowa or Pittsburgh, with no difference in
# quality. The Iowa factory opened five years ago, so components manufactured
# in Iowa are censored at five years. The Pittsburgh factory opened two years
# ago, so those components are censored at two years.
# I

# (i) We wish to model the failure time of an electrical component made in two
# different factories, one of which opened before the other. We have reason to
# believe that components manufactured in the factory that opened earlier are
# of higher quality.
# I

# 第 2 题
# We conduct a study with n = 4 participants who have just purchased cell
# phones, in order to model the time until phone replacement. The first
# participant replaces her phone after 1.2 years. The second participant still
# has not replaced her phone at the end of the two-year study period. The third
# participant changes her phone number and is lost to follow-up, but has not yet
# replaced her phone, 1.5 years into the study. The fourth participant replaces
# her phone after 0.2 years.
#
# For each of the four participants, i = 1, ..., 4, answer the following
# questions using the notation introduced in Section 11.1.
#
# (a) Is the participant's cell phone replacement time censored?
# NO 
# YES
# NO
# YES

# (b) Is the value of c_i known? If so, what is it?
# c1 = 2
# c2 = 2
# c3 = 1.5
# c4 = 2

# (c) Is the value of t_i known? If so, what is it?
# t1 = 1.2
# t2 未知，只知道 > 2
# t3 未知，只知道 > 1.5
# t4 = 0.2

# (d) Is the value of y_i known? If so, what is it?
# y1 = 1.2
# y2 = 2
# y3 = 1.5
# y4 = 0.2

# (e) Is the value of δ_i known? If so, what is it?
# delta1 = 1
# delta2 = 0
# delta3 = 0
# delta4 = 1

# 第 3 题
# For the example in Exercise 2, report the values of K, d_1, ..., d_K,
# r_1, ..., r_K, and q_1, ..., q_K, where this notation was defined in
# Section 11.3.
# 观察到的真正 replacement times：
# 0.2 和 1.2
# K = 2
# d1 = 0.2
# d2 = 1.2
# d1 时 4 人仍在 risk set
# r1 = 4
# q1 = 1
# d2 时剩 3 人
# r2 = 3
# q2 = 1

# 第 4 题
# This problem makes use of the Kaplan-Meier survival curve displayed in
# Figure 11.9. The raw data used to plot this survival curve are given below.
# The covariate column is not needed for this problem.
#
# Observation (Y)    Censoring Indicator (δ)    Covariate (X)
# 26.5               1                          0.1
# 37.2               1                         11.0
# 57.3               1                         -0.3
# 90.8               0                          2.8
# 20.2               0                          1.8
# 89.8               0                          0.4
#
# (a) What is the estimated probability of survival past 50 days?
# S_hat(50) = 0.6
# (b) Write out an analytical expression for the estimated survival function.
# For instance, your answer might be something along the lines of
#
# S_hat(t) = 0.80,  if t < 31,
#            0.50,  if 31 <= t < 77,
#            0.22,  if 77 <= t.
#
# This expression is for illustration only; it is not the correct answer.
# S_hat(t) =
# 1.0   , t < 26.5
# 0.8   , 26.5 <= t < 37.2
# 0.6   , 37.2 <= t < 57.3
# 0.4   , t >= 57.3

# 第 5 题
# Sketch the survival function given by
#
# S_hat(t) = 0.80,  if t < 31,
#            0.50,  if 31 <= t < 77,
#            0.22,  if 77 <= t.
#
# Your answer should look something like Figure 11.9.
S <- stepfun(c(31, 77),
             c(0.80, 0.50, 0.22))

plot(S,
     xlim = c(0, 100),
     ylim = c(0, 1),
     xlab = "Time",
     ylab = "Survival Probability",
     verticals = TRUE,
     do.points = FALSE)

# 第 6 题
# This problem makes use of the data displayed in Figure 11.1. You can refer
# to the observation times as y_1, ..., y_4. The ordering of these observation
# times can be seen from Figure 11.1; their exact values are not required.

# (a) Report the values of δ_1, ..., δ_4, K, d_1, ..., d_K, r_1, ..., r_K,
# and q_1, ..., q_K. The relevant notation is defined in Sections 11.1 and 11.3.
# delta1 = 1
# delta2 = 0
# delta3 = 1
# delta4 = 0
#
# K = 2
#
# d1 = y3
# d2 = y1
#
# r1 = 4, q1 = 1
# r2 = 2, q2 = 1

# (b) Sketch the Kaplan-Meier survival curve corresponding to this data set.
# You do not need to use any software; you can sketch it by hand using the
# results obtained in part (a).

# Kaplan-Meier curve：
# S(t) = 1       , t < y3
#        3/4     , y3 <= t < y1
#        3/8     , t >= y1

# (c) Based on the survival curve estimated in part (b), what is the
# probability that the event occurs within 200 days? What is the probability
# that the event does not occur within 310 days?

# 200 天时 S(200) = 3/4
# P(event <= 200)
# = 1 - S(200)
# = 1/4
# 310 天时：
# P(event > 310)
# = S(310)
# = 3/8

# (d) Write out an expression for the estimated survival curve from part (b).
# S_hat(t) =
# 1       , t < y3
# 3/4     , y3 <= t < y1
# 3/8     , t >= y1

# 第 7 题
# In this problem, we will derive Equations (11.5) and (11.6), which are needed
# for the construction of the log-rank test statistic in Equation (11.8).
# Recall the notation in Table 11.1.

# (a) Assume that there is no difference between the survival functions of the
# two groups. Then we can think of q_1k as the number of failures if we draw
# r_1k observations, without replacement, from a risk set of r_k observations
# that contains a total of q_k failures. Argue that q_1k follows a
# hypergeometric distribution. Write the parameters of this distribution in
# terms of r_1k, r_k, and q_k.
# q_1k ~ Hypergeometric(r_k, q_k, r_1k)

# (b) Given your previous answer and the properties of the hypergeometric
# distribution, what are the mean and variance of q_1k? Compare your answer
# to Equations (11.5) and (11.6).
# E(q_1k) = r_1k * q_k / r_k
# Var(q_1k) =
# r_1k * (q_k/r_k) * (1-q_k/r_k) *
# (r_k-r_1k)/(r_k-1)

# 第 8 题
# Recall that the survival function S(t), the hazard function h(t), and the
# density function f(t) are defined in Equations (11.2), (11.9), and (11.11),
# respectively. Furthermore, define F(t) = 1 - S(t). Show that the following
# relationships hold:
# f(t) = dF(t) / dt,
# S(t) = exp(-integral(from 0 to t) h(u) du).

# h(t) = f(t)/S(t)
# = -S'(t)/S(t)
# = -d(log S(t))/dt
# 积分：
# log S(t) = - integral_0^t h(u)du

# 第 9 题
# In this exercise, we will explore the consequences of assuming that survival
# times follow an exponential distribution.
#
# (a) Suppose that a survival time follows an Exp(λ) distribution, so that its
# density function is f(t) = λ*exp(-λ*t). Using the relationships provided in
# Exercise 8, show that S(t) = exp(-λ*t).
# f(t) = lambda*exp(-lambda*t)
# F(t) = 1-exp(-lambda*t)
# 所以：
# S(t) = exp(-lambda*t)

# (b) Now suppose that each of n independent survival times follows an Exp(λ)
# distribution. Write out an expression for the likelihood function in
# Equation (11.13).
# L(lambda)
# = product [f(y_i)^delta_i *
#            S(y_i)^(1-delta_i)]
# = lambda^(sum(delta_i)) *
#   exp(-lambda*sum(y_i))


# (c) Show that the maximum likelihood estimator for λ is
# λ_hat = sum(i = 1 to n) δ_i / sum(i = 1 to n) y_i.
# log L =
# sum(delta_i)*log(lambda)
# - lambda*sum(y_i)
# 对 lambda 求导并令其为 0：
# lambda_hat =
# sum(delta_i) / sum(y_i)

# (d) Use your answer to part (c) to derive an estimator of the mean survival
# time.
#
# Hint: Recall that the mean of an Exp(λ) random variable is 1/λ.
# Exp(lambda) 的平均生存时间为 1/lambda
# 因此：
# mean_hat =
# sum(y_i) / sum(delta_i)

# 第 10 题
# This exercise focuses on the BrainCancer data set, which is included in the
# ISLR2 R library.


# (a) Plot the Kaplan-Meier survival curve with plus or minus one standard-error
# bands, using the survfit() function in the survival package.
fit <- survfit(
  Surv(time, status) ~ 1,
  data = BrainCancer
)
plot(fit,
     conf.int = FALSE,
     xlab = "Months",
     ylab = "Survival Probability")
lines(fit$time,
      fit$surv + fit$std.err,
      type = "s", lty = 2)
lines(fit$time,
      fit$surv - fit$std.err,
      type = "s", lty = 2)

# (b) Draw a bootstrap sample of size n = 88 from the pairs (y_i, δ_i), and
# compute the resulting Kaplan-Meier survival curve. Repeat this process
# B = 200 times. Use the results to estimate the standard error of the
# Kaplan-Meier survival curve at each time point. Compare this estimate to the
# standard errors obtained in part (a).
set.seed(1)

B <- 200
times <- fit$time
boot.surv <- matrix(NA, B, length(times))
for (b in 1:B) {

  id <- sample(1:nrow(BrainCancer),
               replace = TRUE)

  dat <- BrainCancer[id, ]

  fb <- survfit(
    Surv(time, status) ~ 1,
    data = dat
  )

  boot.surv[b, ] <-
    summary(fb,
            times = times,
            extend = TRUE)$surv
}
boot.se <- apply(boot.surv, 2, sd)
plot(times, fit$std.err, type = "l")
lines(times, boot.se, lty = 2)

# (c) Fit a Cox proportional hazards model that uses all of the predictors to
# predict survival. Summarize the main findings.
fit.all <- coxph(
  Surv(time, status) ~
    sex + diagnosis + loc +
    ki + gtv + stereo,
  data = BrainCancer
)
summary(fit.all)

# (d) Stratify the data by the value of ki. Since only one observation has
# ki = 40, group that observation with those having ki = 60. Plot adjusted
# Kaplan-Meier survival curves for each of the five strata, controlling for the
# other predictors.
BrainCancer$ki.group <-
  ifelse(BrainCancer$ki %in% c(40, 60),
         "40/60",
         as.character(BrainCancer$ki))
BrainCancer$ki.group <-
  factor(BrainCancer$ki.group)
fit.ki <- coxph(
  Surv(time, status) ~
    ki.group + sex + diagnosis +
    loc + gtv + stereo,
  data = BrainCancer
)
newdat <- data.frame(
  ki.group = levels(BrainCancer$ki.group),
  sex = factor("Female",
               levels = levels(BrainCancer$sex)),
  diagnosis = factor("Meningioma",
                     levels = levels(BrainCancer$diagnosis)),
  loc = factor("Supratentorial",
               levels = levels(BrainCancer$loc)),
  gtv = mean(BrainCancer$gtv, na.rm = TRUE),
  stereo = factor("SRT",
                  levels = levels(BrainCancer$stereo))
)
fit.adjust <- survfit(fit.ki,
                      newdata = newdat)
plot(fit.adjust,
     col = 1:5,
     xlab = "Months",
     ylab = "Survival Probability")
legend("bottomleft",
       levels(BrainCancer$ki.group),
       col = 1:5,
       lty = 1)
# 第 11 题
# This example makes use of the following data.
#
# Observation (Y)    Censoring Indicator (δ)    Covariate (X)
# 26.5               1                          0.1
# 37.2               1                         11.0
# 57.3               1                         -0.3
# 90.8               0                          2.8
# 20.2               0                          1.8
# 89.8               0                          0.4
#
# (a) Create two groups of observations. In Group 1, X < 2, whereas in Group 2,
# X >= 2. Plot the Kaplan-Meier survival curves corresponding to the two groups.
# Be sure to label the curves so that it is clear which curve corresponds to
# which group. By eye, does there appear to be a difference between the two
# groups' survival curves?
#
# (b) Fit Cox's proportional hazards model, using the group indicator as a
# covariate. What is the estimated coefficient? Write a sentence interpreting
# this coefficient in terms of the hazard, or instantaneous probability of the
# event. Is there evidence that the true coefficient value is non-zero?
#
# (c) Recall from Section 11.5.2 that, in the case of a single binary covariate,
# the log-rank test statistic should be identical to the score statistic for
# the Cox model. Conduct a log-rank test to determine whether there is a
# difference between the survival curves for the two groups. How does the
# p-value for the log-rank test statistic compare to the p-value for the score
# statistic for the Cox model from part (b)?