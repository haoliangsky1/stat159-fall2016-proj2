#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj2")
#credit = read.csv('data/Credit.csv', header=T)
#install.packages('plyr')
args = commandArgs(trailingOnly =TRUE)
credit = read.csv(args[1], header = T)
credit = credit[,2:ncol(credit)]