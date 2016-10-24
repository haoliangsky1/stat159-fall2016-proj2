#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj2")
#trainingSet = read.csv('data/trainingSet.csv', header=T)
#testSet = read.csv('data/testSet.csv', header = T)

# Fit Ridge Regression model:
args = commandArgs(trailingOnly =TRUE)
temp = read.csv(args[1], header = T)
scaledCredit = temp[,2:ncol(temp)]
load(args[2])
library(glmnet)
# Construct the proper input
x = model.matrix(Balance~., scaledCredit)[,-1]
y = scaledCredit$Balance
cv.out = cv.glmnet(x[trainingIndex,], y[trainingIndex], alpha = 0)
