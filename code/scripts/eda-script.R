#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj2")
#credit = read.csv('data/Credit.csv', header=T)
args = commandArgs(trailingOnly =TRUE)
credit = read.csv(args[1], header = T)
credit = credit[,2:ncol(credit)]

# Compute the summary statistics for quantitative variables
getSummary = function(data, name){
  current = 0
  if (name == 'Income') {
    current = data$Income
  } else if (name == 'Limit') {
    current = data$Limit
  }  else if (name == 'Rating') {
    current = data$Rating
  } else if (name == 'Cards') {
    current = data$Cards
  } else if (name == 'Age') {
    current = data$Age
  } else if (name == 'Education') {
    current = data$Education
  } else if (name == 'Balance') {
    current = data$Balance
  }
  currentSummary = c(min(current, na.rm=T), max(current, na.rm=T), (max(current, na.rm=T) - min(current, na.rm=T)), median(current, na.rm=T), quantile(current, na.rm=T)[[2]], quantile(current, na.rm=T)[[4]], IQR(current, na.rm=T), mean(current, na.rm=T), var(current, na.rm=T), sd(current, na.rm=T))
  names(currentSummary) = c('Minimun', 'Maximum', 'Range', 'Median', '1st Quartile', '3rd Quartile', 'Interquartile Range', 'Mean', 'Variance', 'Standard Deviation')
  return(currentSummary)
}

quantitativeVariables = c(colnames(credit)[1:6], 'Balance')
summaryMatrix = matrix(ncol = 10, nrow = 7)
colnames(summaryMatrix) = c('Minimun', 'Maximum', 'Range', 'Median', '1st Quartile', '3rd Quartile', 'Interquartile Range', 'Mean', 'Variance', 'Standard Deviation')
rownames(summaryMatrix) = quantitativeVariables
for(i in 1:length(quantitativeVariables)) {
  summaryMatrix[i,] = getSummary(credit, quantitativeVariables[i])
}
sink('data/eda-quantitativeVariables.txt')
summaryMatrix
sink()
save(summaryMatrix, file = 'data/eda-summaryMatrix.RData')

# Histograms and boxplots
# Income
png('images/histogram-income.png')
hist(credit$Income, main = 'Histgoram of Income', xlab = 'Income')
dev.off()
png('images/boxplot-income.png')
boxplot(credit$Income, main = 'Boxplot of Income', xlab = 'Income')
dev.off()
# Limit
png('images/histogram-limit.png')
hist(credit$Limit, main = 'Histgoram of Limit', xlab = 'Limit')
dev.off()
png('images/boxplot-limit.png')
boxplot(credit$Limit, main = 'Boxplot of Limit', xlab = 'Limit')
dev.off()
# Rating
png('images/histogram-rating.png')
hist(credit$Rating, main = 'Histgoram of Rating', xlab = 'Rating')
dev.off()
png('images/boxplot-rating.png')
boxplot(credit$Rating, main = 'Boxplot of Rating', xlab = 'Rating')
dev.off()
# Cards
png('images/histogram-cards.png')
hist(credit$Cards, main = 'Histgoram of Cards', xlab = 'Cards')
dev.off()
png('images/boxplot-cards.png')
boxplot(credit$Cards, main = 'Boxplot of Cards', xlab = 'Cards')
dev.off()
# Ages
png('images/histogram-age.png')
hist(credit$Age, main = 'Histgoram of Age', xlab = 'Age')
dev.off()
png('images/boxplot-age.png')
boxplot(credit$Age, main = 'Boxplot of Age', xlab = 'Age')
dev.off()
# Education
png('images/histogram-education.png')
hist(credit$Education, main = 'Histgoram of Education', xlab = 'Year of Education')
dev.off()
png('images/boxplot-education.png')
boxplot(credit$Education, main = 'Boxplot of Education', xlab = 'Year of Education')
dev.off()
# Balance
png('images/histogram-balance.png')
hist(credit$Balance, main = 'Histgoram of Balance', xlab = 'Balance')
dev.off()
png('images/boxplot-balance.png')
boxplot(credit$Balance, main = 'Boxplot of Balance', xlab = 'Balance')
dev.off()


# Compute the summary statistics for qualitative variables


dfasfa


