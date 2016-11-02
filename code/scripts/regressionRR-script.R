#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj2")
#trainingSet = read.csv('data/trainingSet.csv', header=T)
#testSet = read.csv('data/testSet.csv', header = T)
#load('data/trainingIndex.RData')

# Fit Ridge Regression model:
args = commandArgs(trailingOnly =TRUE)
temp = read.csv(args[1], header = T)
scaledCredit = temp[,2:ncol(temp)]
load(args[2])
seed = args[3]
library(glmnet)
# Construct the proper input
x = model.matrix(Balance~., scaledCredit)[,-1]
y = scaledCredit$Balance
grid = 10^seq(10, -2, length = 100)
# Run the fitting function
set.seed(seed)
rr.cv.out = cv.glmnet(x[trainingIndex,], y[trainingIndex], alpha = 0, intercept = FALSE, standardize = FALSE, lambda = grid)
# Output the result of the fitting function
save(rr.cv.out, file = 'data/regressionRR-cvResult.RData')
# Select best model
bestlam = rr.cv.out$lambda.min
# Plot the corss-validation errors in terms of the tunning parameter
png('images/scatterplot-ridge.png')
plot(rr.cv.out)
abline(v=bestlam)
dev.off()
# Compute the test MSE for best model selected
x.test = x[-(trainingIndex), ]
y.test = y[-(trainingIndex)]
ridge.mod = glmnet(x[trainingIndex, ], y[trainingIndex], alpha = 0, lambda= bestlam)
ridge.pred = predict(ridge.mod, s = bestlam, newx = x.test)
rr.mse = mean((ridge.pred - y.test)^2)
save(rr.mse, file = 'data/mseRR.RData')
# Refit the model on the fulll data set with the chosen parameter
rrFit = glmnet(x, y, alpha = 0, lambda = bestlam)
save(rrFit, file = 'data/regressionRR-model.RData')

