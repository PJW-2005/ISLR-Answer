library(MASS)
# 第 1 题
# This problem involves the K-means clustering algorithm.
#
# (a) Prove Equation (12.18).
# 对一个 cluster C_k，令 n_k = |C_k|。
# 对任意第 j 个变量：
# sum_{i,i'} (x_ij - x_i'j)^2
# = 2*n_k*sum_i (x_ij - xbar_kj)^2
# 因此两边除以 n_k，并对 j 求和：
# (1/|C_k|) * sum_{i,i'} sum_j (x_ij-x_i'j)^2
# = 2 * sum_i sum_j (x_ij-xbar_kj)^2
# 即证明 Equation (12.18)。

# (b) On the basis of this identity, argue that the K-means clustering
# algorithm in Algorithm 12.2 decreases the objective in Equation (12.17) at
# each iteration.
# Step 2(a)：cluster centroid 是使平方误差最小的均值。
# Step 2(b)：每个 observation 被分配到最近的 centroid。
# 因此每一步都只会使 within-cluster variation
# 减小或保持不变。
# 所以 K-means 的 objective 不会增加。

# 第 2 题
# Suppose that we have four observations, for which we compute the following
# dissimilarity matrix:
#
#       Obs. 1    Obs. 2    Obs. 3    Obs. 4
# Obs. 1   0        0.30      0.40      0.70
# Obs. 2   0.30     0         0.50      0.80
# Obs. 3   0.40     0.50      0         0.45
# Obs. 4   0.70     0.80      0.45      0
#
# For instance, the dissimilarity between the first and second observations is
# 0.30, and the dissimilarity between the second and fourth observations is
# 0.80.
#
# (a) On the basis of this dissimilarity matrix, sketch the dendrogram that
# results from hierarchically clustering these four observations using complete
# linkage. Be sure to indicate the height at which each fusion occurs, as well
# as the observations corresponding to each leaf in the dendrogram.

# 1. {1} 和 {2} 在 height = 0.30 合并
# 2. {3} 和 {4} 在 height = 0.45 合并
# 3. {1,2} 和 {3,4} 在 height = 0.80 合并

# (b) Repeat part (a), this time using single-linkage clustering.

# 1. {1} 和 {2} 在 height = 0.30 合并
# 2. {1,2} 和 {3} 在 height = 0.40 合并
# 3. {1,2,3} 和 {4} 在 height = 0.45 合并

# (c) Suppose that we cut the dendrogram obtained in part (a) such that two
# clusters result. Which observations are in each cluster?

# Cluster 1 = {1,2}
# Cluster 2 = {3,4}

# (d) Suppose that we cut the dendrogram obtained in part (b) such that two
# clusters result. Which observations are in each cluster?

# Cluster 1 = {1,2,3}
# Cluster 2 = {4}

# (e) It is mentioned in the chapter that, at each fusion in the dendrogram,
# the positions of the two clusters being fused can be swapped without changing
# the meaning of the dendrogram. Draw a dendrogram equivalent to the one in
# part (a), in which two or more leaves are repositioned but the meaning of the
# dendrogram remains the same.

# 第 3 题
# In this problem, you will perform K-means clustering manually, with K = 2,
# on a small example with n = 6 observations and p = 2 features. The
# observations are as follows:
#
# Observation    X1    X2
# 1               1     4
# 2               1     3
# 3               0     4
# 4               5     1
# 5               6     2
# 6               4     0
#
# (a) Plot the observations.
x <- matrix(c(
  1,4,
  1,3,
  0,4,
  5,1,
  6,2,
  4,0
), ncol = 2, byrow = TRUE)
plot(x[,1], x[,2],
     xlab = "X1", ylab = "X2",
     pch = 19)

text(x[,1], x[,2],
     labels = 1:6,
     pos = 3)
# (b) Randomly assign a cluster label to each observation. You can use the
# sample() command in R to do this. Report the cluster labels for each
# observation.
cluster <- c(1,1,2,2,1,2)

# (c) Compute the centroid for each cluster.
# Cluster 1 = observations 1,2,5
# centroid 1 = (8/3, 3)
# Cluster 2 = observations 3,4,6
# centroid 2 = (3, 5/3)

# (d) Assign each observation to the centroid to which it is closest in terms
# of Euclidean distance. Report the cluster labels for each observation.
cluster <- c(1,1,1,2,2,2)

# (e) Repeat parts (c) and (d) until the answers obtained stop changing.

# Cluster 1 = observations 1,2,3
# centroid 1 = (2/3, 11/3)
# Cluster 2 = observations 4,5,6
# centroid 2 = (5, 1)

# (f) In your plot from part (a), color the observations according to the
# cluster labels obtained.

plot(x[,1], x[,2],
     col = cluster,
     pch = 19,
     xlab = "X1", ylab = "X2")
text(x[,1], x[,2],
     labels = 1:6,
     pos = 3)

# 第 4 题
# Suppose that, for a particular data set, we perform hierarchical clustering
# using single linkage and complete linkage. We obtain two dendrograms.
#
# (a) At a certain point on the single-linkage dendrogram, the clusters
# {1, 2, 3} and {4, 5} fuse. On the complete-linkage dendrogram, the clusters
# {1, 2, 3} and {4, 5} also fuse at a certain point. Which fusion will occur
# higher on the tree? Will they fuse at the same height, or is there not enough
# information to tell?

# Single linkage 使用两个 cluster 间的最小距离。
# Complete linkage 使用最大距离。
# 所以：
# complete fusion height >= single fusion height。
# 一般 complete 更高；
# 特殊情况下也可能相同。

# (b) At a certain point on the single-linkage dendrogram, the clusters {5} and
# {6} fuse. On the complete-linkage dendrogram, the clusters {5} and {6} also
# fuse at a certain point. Which fusion will occur higher on the tree? Will they
# fuse at the same height, or is there not enough information to tell?

# {5} 和 {6} 都是 singleton。
# 最小距离 = 最大距离 = d(5,6)
# 所以 single 和 complete 在相同高度合并。

# 第 5 题
# In words, describe the results that you would expect if you performed K-means
# clustering of the eight shoppers in Figure 12.16, on the basis of their sock
# and computer purchases, with K = 2. Give three answers, one for each of the
# variable scalings displayed. Explain your answers.

# 第 6 题
# We saw in Section 12.2.2 that the principal component loading and score
# vectors provide an approximation to a matrix in the sense of Equation (12.5).
# Specifically, the principal component score and loading vectors solve the
# optimization problem given in Equation (12.6).
#
# Now suppose that the M principal component score vectors z_im, m = 1, ..., M,
# are known. Using Equation (12.6), explain why each of the first M principal
# component loading vectors φ_jm, m = 1, ..., M, can be obtained by performing
# p separate least-squares linear regressions. In each regression, the principal
# component score vectors are the predictors, and one feature of the data matrix
# is the response.

# PCA 的近似为：
# x_ij ≈ sum_m z_im * phi_jm
# 如果 z_im 已经知道，
# 对每一个 feature j：
# X_j = phi_j1*Z1 + ... + phi_jM*ZM + error
# 就是一个普通 least squares regression。
# 因此分别对 p 个 features 做 p 次 regression，
# 得到的 regression coefficients
# 就是 loading phi_j1,...,phi_jM。


# 第 7 题
# In the chapter, we mentioned the use of correlation-based distance and
# Euclidean distance as dissimilarity measures for hierarchical clustering.
# These two measures are almost equivalent: if each observation has been
# centered to have mean zero and standard deviation one, and if r_ij denotes
# the correlation between observations i and j, then 1 - r_ij is proportional
# to the squared Euclidean distance between observations i and j.
#
# On the USArrests data, show that this proportionality holds.
#
# Hint: Euclidean distance can be calculated using the dist() function, and
# correlations can be calculated using the cor() function.

X <- t(scale(t(USArrests)))
D2 <- as.matrix(dist(X))^2
R <- cor(t(X))
D2.cor <- 2 * (ncol(X) - 1) * (1 - R)
all.equal(D2, D2.cor)

# 第 8 题
# In Section 12.2.3, a formula for calculating the proportion of variance
# explained, or PVE, was given in Equation (12.10). We also saw that PVE can be
# obtained using the sdev output of the prcomp() function.
#
# On the USArrests data, calculate PVE in two ways:
pr <- prcomp(USArrests,
             center = TRUE,
             scale. = TRUE)
# (a) Use the sdev output of the prcomp() function, as was done in
# Section 12.2.3.
pve1 <- pr$sdev^2 /
        sum(pr$sdev^2)
# (b) Apply Equation (12.10) directly. Use the prcomp() function to compute the
# principal component loadings, and then use those loadings in Equation (12.10)
# to obtain the PVE.
X <- scale(USArrests)
Z <- X %*% pr$rotation
pve2 <- colSums(Z^2) /
        sum(X^2)
all.equal(as.numeric(pve1),
          as.numeric(pve2))

# These two approaches should give the same results.
#
# Hint: You will obtain the same results in parts (a) and (b) only if the same
# data are used in both cases. For instance, if you perform prcomp() using
# centered and scaled variables in part (a), then you must center and scale the
# variables before applying Equation (12.10) in part (b).

# 第 9 题
# Consider the USArrests data. We will now perform hierarchical clustering on
# the states.
#
# (a) Using hierarchical clustering with complete linkage and Euclidean
# distance, cluster the states.
d <- dist(USArrests)
hc <- hclust(d,
             method = "complete")
plot(hc)
# (b) Cut the dendrogram at a height that results in three distinct clusters.
# Which states belong to which clusters?
group <- cutree(hc, k = 3)
split(rownames(USArrests),
      group)

# (c) Hierarchically cluster the states using complete linkage and Euclidean
# distance after scaling the variables to have standard deviation one.
X <- scale(USArrests)
d2 <- dist(X)
hc2 <- hclust(d2,
              method = "complete")
plot(hc2)
group2 <- cutree(hc2, k = 3)
split(rownames(USArrests),
      group2)

# (d) What effect does scaling the variables have on the hierarchical
# clustering obtained? In your opinion, should the variables be scaled before
# the inter-observation dissimilarities are computed? Justify your answer.

# scaling 会明显改变 clustering。
# 原始数据中 Assault 等数值范围大的变量
# 会主导 Euclidean distance。
# 因为四个变量量纲和尺度不同，
# 所以这里更适合先进行 scaling。

# 第 10 题
# In this problem, you will generate simulated data, and then perform PCA and
# K-means clustering on the data.
set.seed(1)
# (a) Generate a simulated data set with 20 observations in each of three
# classes, for 60 observations in total, and 50 variables.
X <- matrix(rnorm(60 * 50),
            nrow = 60)
class <- rep(1:3,
             each = 20)
X[class == 2, 1:10] <-
  X[class == 2, 1:10] + 3
X[class == 3, 1:10] <-
  X[class == 3, 1:10] - 3


# Hint: You can use functions such as rnorm() or runif() to generate data. Be
# sure to add a mean shift to the observations in each class so that there are
# three distinct classes.
# (b) Perform PCA on the 60 observations and plot the first two principal
# component score vectors. Use a different color for the observations in each
# of the three classes. If the three classes appear separated in this plot,
# continue to part (c). Otherwise, return to part (a) and modify the simulation
# to create greater separation. Do not continue until the three classes show at
# least some separation in the first two principal component score vectors.
pc <- prcomp(X,
             scale. = TRUE)
plot(pc$x[,1],
     pc$x[,2],
     col = class,
     pch = 19,
     xlab = "PC1",
     ylab = "PC2")

# (c) Perform K-means clustering of the observations with K = 3. How well do
# the clusters obtained from K-means clustering compare to the true class
# labels?
km3 <- kmeans(X,
              centers = 3,
              nstart = 20)
table(class, km3$cluster)

# Hint: You can use table() in R to compare the true class labels to the cluster
# labels. Interpret the results carefully: K-means assigns cluster numbers
# arbitrarily, so you cannot simply check whether the true labels and cluster
# labels are numerically identical.
#
# (d) Perform K-means clustering with K = 2. Describe your results.

# (e) Perform K-means clustering with K = 4. Describe your results.
km2 <- kmeans(X,
              centers = 2,
              nstart = 20)
table(class,km2$cluster)

# (f) Perform K-means clustering with K = 3 on the first two principal
# component score vectors rather than on the raw data. That is, perform
# K-means clustering on the 60-by-2 matrix whose first column is the first
# principal component score vector and whose second column is the second
# principal component score vector. Comment on the results.
km.pc <- kmeans(
  pc$x[,1:2],
  centers = 3,
  nstart = 20
)
table(class,km.pc$cluster)
# (g) Using the scale() function, perform K-means clustering with K = 3 after
# scaling each variable to have standard deviation one. How do these results
# compare to those obtained previously? Explain.
X.scale <- scale(X)
km.scale <- kmeans(
  X.scale,
  centers = 3,
  nstart = 20
)
table(class,km.scale$cluster)

# 第 11 题
# Write an R function to perform matrix completion as in Algorithm 12.1 and as
# outlined in Section 12.5.2. In each iteration, the function should keep track
# of the relative error and the iteration count. Iterations should continue
# until the relative error is sufficiently small or a maximum number of
# iterations is reached. Set a default value for this maximum number. There
# should also be an option to print the progress at each iteration.
#
# Test your function on the Boston data. First standardize the features to have
# mean zero and standard deviation one using scale(). Run an experiment in
# which you randomly leave out an increasing and nested fraction of observations
# from 5% to 30%, in steps of 5%. Apply Algorithm 12.1 with M = 1, 2, ..., 8.
# Display the approximation error as a function of the fraction of observations
# that are missing and the value of M, averaged over 10 repetitions.
matrix.complete <- function(X,
                            M = 2,
                            tol = 1e-7,
                            maxit = 100,
                            trace = FALSE) {

  miss <- is.na(X)
  Xhat <- X
  means <- colMeans(X,
                    na.rm = TRUE)
  for (j in 1:ncol(X)) {
    Xhat[miss[,j], j] <- means[j]
  }

  old.err <- Inf

  for (iter in 1:maxit) {

    s <- svd(Xhat)
    Xapp <-
      s$u[,1:M,drop=FALSE] %*%
      diag(s$d[1:M], M) %*%
      t(s$v[,1:M,drop=FALSE])
    err <- sum(
      (X[!miss] - Xapp[!miss])^2
    )
    rel.err <-
      abs(old.err - err) /
      sum(X[!miss]^2)
    Xhat[miss] <- Xapp[miss]
    Xhat[!miss] <- X[!miss]

    if (trace)
      cat(iter, rel.err, "\n")

    if (rel.err < tol)
      break

    old.err <- err
  }
  list(
    Xhat = Xhat,
    iter = iter,
    rel.err = rel.err
  )
}
# 第 12 题
# In Section 12.5.2, Algorithm 12.1 was implemented using the svd() function.
# However, given the connection between svd() and prcomp() highlighted in the
# lab, we could instead implement the algorithm using prcomp().
matrix.complete.pca <- function(X, M = 2, tol = 1e-7, maxit = 100) {
  miss <- is.na(X)
  Xhat <- X
  means <- colMeans(X,
                    na.rm = TRUE)
  for (j in 1:ncol(X)) {
    Xhat[miss[,j], j] <- means[j]
  }
  old.err <- Inf
  for (iter in 1:maxit) {
    pc <- prcomp(
      Xhat,
      center = TRUE,
      scale. = FALSE
    )
    Xapp <-pc$x[,1:M,drop=FALSE] %*% t(pc$rotation[,1:M,drop=FALSE])
    Xapp <- sweep(Xapp, 2, pc$center,"+")
    err <- sum((X[!miss] -Xapp[!miss])^2)
    rel.err <- abs(old.err - err) / sum(X[!miss]^2)
    Xhat[miss] <- Xapp[miss]
    Xhat[!miss] <- X[!miss]
    if (rel.err < tol)
      break
    old.err <- err
  }
  return(Xhat)
}


# Write a function to implement Algorithm 12.1 that uses prcomp() rather than
# svd().

# 第 13 题
# On the book website, www.statlearning.com, there is a gene expression data set
# named Ch12Ex13.csv. It consists of 40 tissue samples with measurements on
# 1,000 genes. The first 20 samples are from healthy patients, while the second
# 20 samples are from a diseased group.
#
# (a) Load the data using read.csv(). You will need to set header = FALSE.
#
# (b) Apply hierarchical clustering to the samples using correlation-based
# distance, and plot the dendrogram. Do the genes separate the samples into the
# two groups? Do your results depend on the type of linkage used?
#
# (c) Your collaborator wants to know which genes differ the most across the
# two groups. Suggest a way to answer this question, and apply it here.