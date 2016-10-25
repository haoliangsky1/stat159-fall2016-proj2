#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj2")
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
#pcr.fit = pcr(Balance~., data = scaledCredit, subset = trainingIndex, validation = 'CV')
pcr.fit = pcr(y[trainingIndex]~x[trainingIndex,], validation = 'CV')
# Output the result of the fitting function
save(pcr.fit, file = 'data/regressionPCR-cvResult.RData')
# Select best model
minComp = min(pcr.fit$validation$PRESS)
# Plot the corss-validation errors in terms of the tunning parameter
png('images/scatterplot-pcr.png')
validationplot(cv.out, val.type = "MSEP")
dev.off()
# Compute the test MSE for best model selected
x.test = x[-(trainingIndex), ]
y.test = y[-(trainingIndex)]
pcr.pred = predict(pcr.fit, x.test, ncomp = 11)
msePCR = mean((pcr.pred - y.test)^2)
save(msePCR, file = 'data/cv-msePCR.RData')
# Refit the model on the fulll data set with the chosen parameter
pcrFit = pcr(y~x, ncomp = 11)
save(rrFit, file = 'data/regressionRR-model.RData')


