#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj2")
#credit = read.csv('data/Credit.csv', header=T)
#install.packages('plyr')
args = commandArgs(trailingOnly =TRUE)
credit = read.csv(args[1], header = T)
credit = credit[,2:ncol(credit)]

# Covert factors into dummy variables
temp_credit = model.matrix(Balance ~ ., data = credit)
new_credit <- cbind(temp_credit[ ,-1], Balance = credit$Balance)

# Mean centering and standardization
scaled_credit = scale(new_credit, center = TRUE, scale = TRUE)
write.csv(scaled_credit, file = "data/scaled-credit.csv")


