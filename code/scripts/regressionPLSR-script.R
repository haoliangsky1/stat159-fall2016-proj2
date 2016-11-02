#setwd("C:/Users/andre/Dropbox/College/Fall 16/Stat159/stat159-fall2016-proj2")
#trainingSet = read.csv('data/trainingSet.csv', header=T)
#scaledCredit = read.csv('data/scaled-credit.csv', header=T)
#load('data/trainingIndex.RData')

# Fit Ridge Regression model:
args = commandArgs(trailingOnly =TRUE)
temp = read.csv(args[1], header = T)
scaledCredit = temp[,2:ncol(temp)]
load(args[2])
seed = args[3]
library(pls)
# Construct the proper input
x = model.matrix(Balance~., scaledCredit)[,-1]
y = scaledCredit$Balance
# Run the fitting function
set.seed(seed)
#plsr.fit = plsr(y[trainingIndex]~x[trainingIndex,], validation = 'CV')
plsr.fit = plsr(Balance~., data=scaledCredit, subset = trainingIndex, validation = 'CV')
# Output the result of the fitting function
save(plsr.fit, file = 'data/regressionPLSR-cvResult.RData')
# Select best model
minComp = min(plsr.fit$validation$PRESS)
minComp = 4
# Plot the corss-validation errors in terms of the tunning parameter
png('images/scatterplot-plsr.png')
validationplot(plsr.fit, val.type = "MSEP", main = 'Plot for Cross-validation of PLSR')
dev.off()
# Compute the test MSE for best model selected
x.test = x[-(trainingIndex), ]
y.test = y[-(trainingIndex)]
plsr.pred = predict(plsr.fit, x.test, ncomp = 4)
plsr.mse = mean((plsr.pred - y.test)^2)
save(plsr.mse, file = 'data/msePLSR.RData')
# Refit the model on the fulll data set with the chosen parameter
plsrFit = plsr(y~x, ncomp = 4)
save(plsrFit, file = 'data/regressionPLSR-model.RData')

