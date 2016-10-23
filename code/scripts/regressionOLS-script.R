#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj2")
#trainingSet = read.csv('data/.csv', header=T)


# Fit OLS model:
args = commandArgs(trailingOnly =TRUE)
load(args[1])
load(args[2])
olsFit = lm(Balance~., data = trainingSet)
save(olsFit, file = 'data/ols-regression-model')


