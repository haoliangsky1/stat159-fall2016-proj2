This folder has the *functions* folder for *regression-functjions.R*, the *scripts* folder for *eda-script.R*, *regression-script.R* and *sessoin-info-script.R*, the *tests* folder for *test-regression.R* and the *test-that.r* script.

For the *functions* and *tests* folders, currently no self-defined functions are used for this project, so there are only place holder files with brief instructions.

The *scripts* folder contains most of the code necessary to reproduce the entire project:

* *eda-script.R* contains the code for Exploratory Data Analysis (EDA) for this project, including:

    -  Calculating the summary statistics of all the quantitative variables, including their *Mimnimum*, *Maximum*, *Range*, *Median*, *First and Third Quartiles*, *Interquartile Range*, *Mean*, and *Standard Deviation*; 

    -  Drawing histograms and boxplots for the quantitative variables for their distributions;

    -  Creating frequency tables, including counts and relative frequency, for qualitative variables;

    -  Drawing barcharts of the frequencies of the qualitative variables;

    -  Calculating the matrix of correlations among all quantitative variables;

    -  Drawing scatterplot matrix for correlations among all quantitative variables;

    -  Calculating the anova between *Balance* and all the qualitative variables;

    -  Drawing conditional boxplots between *Balance* and the qualitative varaibles, including *Gender*, *Ethnicity*, *Student*, and *Married*.

* *premodelingDataProcessing-script.R* converts the factos, namely qualitative variables in the data set, into dummy variables, and perform mean centering and standardization.

* *trainingAndTestSet-script.R* generates the training set and test set for model training with randomization seed of 1.

* *regressionOLS-script.R* fits a multiple linear regression model via Ordinary Least Squares (OLS), using the *lm()* function. This model will serve as a benchmark in comparison to other models.

* *regressionRR-script.R* fits a multiple linear regression model via Ridge Regression (RR), using R package *"glmnet"*. The parameters selection is via cross-validataion.

* *regressionLR-script.R* fits a multiple linear regression model via Lasso Regression (LR), using R package *"glmnet"*. The parameter selection is via cross-validation.

* *regressionPCR-script.R* fits a multiple linear regression model via Princiapl Components Regression (PCR), using the R package *"pls"*. The parameter selection is via cross-validation.

* *regressionPLSR-script.R* fits a multiple linear regression model via Partial Least Squares Regression (PCR), using the R package *"pls"*. The parameter selection is via cross-validation.





