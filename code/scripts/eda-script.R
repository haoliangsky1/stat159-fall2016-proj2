#setwd("~/Desktop/Fall_2016/Stat159/stat159-fall2016-proj2")
#credit = read.csv('data/Credit.csv', header=T)
#install.packages('plyr')
library(plyr)
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
colnames(summaryMatrix) = c('Min', 'Max', 'Range', 'Median', '25%', '75%', 'IQR', 'Mean', 'Var', 'Std. Dev.')
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
qualitativeVariables = colnames(credit)[7:12]
creditQualitative = credit[qualitativeVariables]
# Gender
genderTable = count(credit, 'Gender')
genderTable$RelativeFrequency = genderTable$freq / sum(genderTable$freq)
colnames(genderTable)[2] = 'Frequency'
sink('data/frequencyTable-gender.txt')
genderTable
sink()
save(genderTable, file = 'data/frequencyTable-gender.RData')
png('images/barchart-gender.png')
barplot(table(credit$Gender), main = 'Barplot of Gender', xlab = 'Gender')
dev.off()

# Student
studentTable = count(credit, 'Student')
studentTable$RelativeFrequency = studentTable$freq / sum(studentTable$freq)
colnames(studentTable)[2] = 'Frequency'
sink('data/frequencyTable-student.txt')
studentTable
sink()
save(studentTable, file = 'data/frequencyTable-student.RData')
png('images/barchart-student.png')
barplot(table(credit$Student), main = 'Barplot of Student', xlab = 'Student')
dev.off()
# Married
marriedTable = count(credit, 'Married')
marriedTable$RelativeFrequency = marriedTable$freq / sum(marriedTable$freq)
colnames(marriedTable)[2] = 'Frequency'
sink('data/frequencyTable-married.txt')
marriedTable
sink()
save(marriedTable, file = 'data/frequencyTable-married.RData')
png('images/barchart-married.png')
barplot(table(credit$Married), main = 'Barplot of Marital Status', xlab = 'Marital Status')
dev.off()
# Ethnicity
ethnicityTable = count(credit, 'Ethnicity')
ethnicityTable$RelativeFrequency = ethnicityTable$freq / sum(ethnicityTable$freq)
colnames(ethnicityTable)[2] = 'Frequency'
sink('data/frequencyTable-ethnicity.txt')
ethnicityTable
sink()
save(ethnicityTable, file = 'data/frequencyTable-ethnicity.RData')
png('images/barchart-ethnicity.png')
barplot(table(credit$Ethnicity), main = 'Barplot of Ethnicity', xlab = 'Ethnicity')
dev.off()

# Association between Balance and the predictors
# Matrix of Correlations among all quantitative variables:
creditQuantitative = credit[quantitativeVariables]
correlationMatrix = cor(creditQuantitative)
sink('data/eda-correlationMatrix.txt')
correlationMatrix
sink()
save(correlationMatrix, file = 'data/correlation-matrix.RData')
#Scatterplot Matrix
png('images/scatterplot-matrix.png')
pairs(~Income+Limit+Rating+Cards+Age+Education+Balance, data = creditQuantitative, main = 'Simple Scatterplot Matrix', cex = 0.8)
dev.off()

# Anova between Balance and all the qualitative variables
options(contrasts = c("contr.helmert", "contr.poly"))
anovaQualitative = aov(Balance~Gender+Student+Married+Ethnicity, data = creditQualitative)
save(anovaQualitative, file = 'eda-anovaQualitative.RData')

# Conditional boxplots between Balance and the qualitative variables
# On gender
balanceMale = credit$Balance[credit$Gender != 'Female']
balanceFemale = credit$Balance[credit$Gender == 'Female']
png('images/boxplot-balanceConditionalOnGender.png')
boxplot(balanceMale, balanceFemale, names = c('Male', 'Female'), main = 'Boxplot of Balance Conditioned on Gender')
dev.off()

# On student
balanceStudent = credit$Balance[credit$Student == 'Yes']
balanceNonStudent = credit$Balance[credit$Student == 'No']
png('images/boxplot-balanceConditionalOnStudent.png')
boxplot(balanceStudent, balanceNonStudent, names = c('Student', 'Non-Student'), main = 'Boxplot of Balance Conditioned on Student')
dev.off()
# On marital status
balanceMarried = credit$Balance[credit$Married == 'Yes']
balanceSingle = credit$Balance[credit$Married == 'No']
png('images/boxplot-balanceConditionalOnMarried.png')
boxplot(balanceMarried, balanceSingle, names = c('Married', 'Single'), main = 'Boxplot of Balance Conditioned on Marital Status')
dev.off()
# On ethnicity
balanceCaucasian = credit$Balance[credit$Ethnicity == 'Caucasian']
balanceAA = credit$Balance[credit$Ethnicity == 'African American']
balanceAsian = credit$Balance[credit$Ethnicity == 'Asian']
png('images/boxplot-balanceConditionalOnEthnicity.png')
boxplot(balanceCaucasian, balanceAA, balanceAsian, names = c('Caucasian', 'African American', 'Asian'), main = 'Boxplot of Balance Conditioned on Ethnicity')
dev.off()




