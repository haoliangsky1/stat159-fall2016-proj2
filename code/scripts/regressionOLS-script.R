#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj2")
#trainingSet = read.csv('data/trainingSet.csv', header=T)
#testSet = read.csv('data/testSet.csv', header = T)
#scaledCredit = read.csv('data/scaled-credit.csv')
# Fit OLS model:
args = commandArgs(trailingOnly =TRUE)
temp = read.csv(args[1], header = T)
scaledCredit = temp[,2:ncol(temp)]
load(args[2])
#olsFit = lm(Balance~Income + Limit + Student1, data = scaledCredit, subset = trainingIndex)
olsFit = lm(Balance~., data = scaledCredit, subset = trainingIndex)
save(olsFit, file = 'data/ols-regression-model.RData')

ols.pred = predict(temp, scaledCredit[-trainingIndex,])
ols.mse = mean((ols.pred - scaledCredit[-trainingIndex,"Balance"])^2)
save(ols.mse, file = 'data/mseOLS.RData')
