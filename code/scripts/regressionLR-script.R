#trainingSet = read.csv('data/trainingSet.csv', header=T)
#scaledCredit = read.csv('data/scaled-credit.csv', header=T)
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
lr.cv.out = cv.glmnet(x[trainingIndex,], y[trainingIndex], alpha = 1, intercept = FALSE, standardize = FALSE, lambda = grid)
# Output the result of the fitting function
save(lr.cv.out, file = 'data/regressionLR-cvResult.RData')
# Select best model
bestlam = lr.cv.out$lambda.min
# Plot the corss-validation errors in terms of the tunning parameter
png('images/scatterplot-lasso.png')
plot(lr.cv.out)
abline(v = bestlam)
dev.off()
# Compute the test MSE for best model selected
x.test = x[-(trainingIndex), ]
y.test = y[-(trainingIndex)]
lasso.mod = glmnet(x[trainingIndex, ], y[trainingIndex], alpha = 1, lambda= bestlam)
lasso.pred = predict(lasso.mod, s = bestlam, newx = x.test)
lr.mse = mean((lasso.pred - y.test)^2)
save(lr.mse, file = 'data/mseLR.RData')
# Refit the model on the fulll data set with the chosen parameter
lrFit = glmnet(x, y, alpha = 1, lambda = bestlam)
save(lrFit, file = 'data/regressionLR-model.RData')

