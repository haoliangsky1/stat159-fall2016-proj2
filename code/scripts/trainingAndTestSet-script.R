#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj2")
#credit = read.csv('data/scaled-credit.csv', header=T)
args = commandArgs(trailingOnly =TRUE)
credit = read.csv(args[1], header = T)
credit = credit[,2:ncol(credit)]
seed = args[2]

# Set seed:
set.seed(seed)
index = c(1:nrow(credit))
trainingIndex = sample(index, 300)
trainingSet = credit[trainingIndex, ]
testSet = credit[-trainingIndex, ]

save(trainingSet, file = 'data/trainingSet.RData')
write.csv(trainingSet, file = 'data/trainingSet.csv')
save(testSet, file = 'data/testSet.RData')
write.csv(testSet, file = 'data/testSet.csv')