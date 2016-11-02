# Declare phony targets
.PHONY: all data clean tests eda regression report

# Output
csv = data/Credit.csv
RData = data/*.RData
png = images/*.png
txt = data/*.txt
# The randomization seed for training and test set
seed = 1 

output = $(csv) $(RData) $(png) $(txt) session-info.txt report/report.pdf
# PHONY targets



all: $(output)

report/report.pdf:
	Rscript -e 'library(rmarkdown); render("report/report.Rmd")'

session-info.txt:
	Rscript code/scripts/session-info-script.R

data/*.RData:
	Rscript code/scripts/regressionOLS-script.R data/scaled-credit.csv
data/*.RData:
	Rscript code/scripts/regressionLR-script.R data/scaled-credit.csv data/trainingIndex.RData $(seed)
data/*.RData:
	Rscript code/scripts/regressionRR-script.R data/scaled-credit.csv data/trainingIndex.RData $(seed)
data/*.RData:
	Rscript code/scripts/regressionPCR-script.R data/scaled-credit.csv data/trainingIndex.RData $(seed)
data/*.RData:
	Rscript code/scripts/regressionPLSR-script.R data/scaled-credit.csv data/trainingIndex.RData $(seed)
data/*.png:
	Rscript code/scripts/regressionLR-script.R data/scaled-credit.csv data/trainingIndex.RData $(seed)
data/*.png:
	Rscript code/scripts/regressionRR-script.R data/scaled-credit.csv data/trainingIndex.RData $(seed)
data/*.png:
	Rscript code/scripts/regressionPCR-script.R data/scaled-credit.csv data/trainingIndex.RData $(seed)
data/*.png:
	Rscript code/scripts/regressionPLSR-script.R data/scaled-credit.csv data/trainingIndex.RData $(seed)


data/*.RData: code/scripts/trainingAndTestSet-script.R data/scaled-credit.csv 
	Rscript code/scripts/trainingAndTestSet-script.R data/scaled-credit.csv $(seed)

data/*.csv: code/scripts/trainingAndTestSet-script.R data/scaled-credit.csv
	Rscript code/scripts/trainingAndTestSet-script.R data/scaled-credit.csv $(seed)

data/*.RData: code/scripts/regressionOLS-script.R data/*.RData
	Rscript code/scripts/regressionOLS-script.R data/scaled-credit.csv data/trainingIndex.RData

data/*.RData: code/scripts/regressionRR-script.R data/*/RData
	Rscript code/scripts/regressionRR-script.R data/scaled-credit.csv data/trainingIndex.RData



# Pre-modeling Data Processing
data/*.csv: code/scripts/premodelingDataProcessing.R data/Credit.csv
	Rscript code/scripts/premodelingDataProcessing.R data/Credit.csv

# Exploratory Data Analysis (EDA)
data/*.txt: code/scripts/eda-script.R data/Credit.csv
	Rscript code/scripts/eda-script.R data/Credit.csv
data/*.RData: code/scripts/eda-script.R data/Credit.csv
	Rscript code/scripts/eda-script.R data/Credit.csv
images/*.png: code/scripts/eda-script.R data/Credit.csv
	Rscript code/scripts/eda-script.R data/Credit.csv


data: 
	# Download the file Credit.csv to the folder data
	curl -O http://www-bcf.usc.edu/~gareth/ISL/Credit.csv
	mv Credit.csv data/Credit.csv

tests:
	# run the unit tests of the self-defiend functions
	Rscript code/test-that.R

eda:
	# perform the exploratory data analysis
	Rscript code/scripts/eda-script.R data/Credit.csv

ols:
	# run the OLS regression
	Rscript code/scripts/regressionOLS-script.R data/scaled-credit.csv

ridge:
	# run the Ridge Regression with Seed
	Rscript code/scripts/regressionRR-script.R data/scaled-credit.csv data/trainingIndex.RData $(seed)

lasso:
	# run the Lasso Regression with Seed
	Rscript code/scripts/regressionLR-script.R data/scaled-credit.csv data/trainingIndex.RData $(seed)

pcr:
	# run the PCR with Seed
	Rscript code/scripts/regressionPCR-script.R data/scaled-credit.csv data/trainingIndex.RData $(seed)

plsr:
	# run the PLSR with Seed
	Rscript code/scripts/regressionPLSR-script.R data/scaled-credit.csv data/trainingIndex.RData $(seed)

regressions:
	make ols
	make ridge
	make lasso
	make pcr
	make plsr

report:
	# generate report.pdf
	Rscript -e 'library(rmarkdown); render("report/report.Rmd")'

slides:
	# generate the slides.html


session:
	bash session.sh
	Rscript code/scripts/session-info-script.R


clean:
	# Clean files
	# rm -f data/Credit.csv
	# rm -f images/*.png
	rm -f report/*.pdf
	rm -f report/section/*.pdf



