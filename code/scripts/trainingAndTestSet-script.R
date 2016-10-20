#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj2")
#credit = read.csv('data/scaled-credit.csv', header=T)
args = commandArgs(trailingOnly =TRUE)
credit = read.csv(args[1], header = T)
credit = credit[,2:ncol(credit)]

# Set seed:
set.seed(1)
index = c(1:nrow(credit))
trainingIndex = sample(index, 300)
trainingSet = credit[trainingIndex, ]
testSet = credit[-trainingIndex, ]

save(trainingSet, file = 'data/trainingSet.RData')
save(testSet, file = 'data/testSet.RData')