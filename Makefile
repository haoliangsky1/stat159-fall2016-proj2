# Declare phony targets
.PHONY: all data clean tests eda ols ridge lasso pcr plsr regression report slides session

# Output
csv = data/Credit.csv
RData = data/*.RData
png = images/*.png
txt = data/*.txt
rmd = report/sections/*.Rmd
scaled-credit = data/scaled-credit.csv
trainingIndex = data/trainingIndex.RData
# The randomization seed for training and test set
seed = 1 

output = $(csv) $(RData) $(png) $(txt) session-info.txt report/report.pdf
# PHONY targets

all: $(output)

report/report.pdf:
	cat $(rmd) > report/report.Rmd
	Rscript -e 'library(rmarkdown); render("report/report.Rmd")'

session-info.txt: session.sh
	bash session.sh
	Rscript code/scripts/session-info-script.R

data/*.RData: 
	Rscript code/scripts/regressionOLS-script.R $(scaled-credit) $(trainingIndex)
data/*.RData:
	Rscript code/scripts/regressionLR-script.R $(scaled-credit) $(trainingIndex) $(seed)
data/*.RData:
	Rscript code/scripts/regressionRR-script.R $(scaled-credit) $(trainingIndex) $(seed)
data/*.RData:
	Rscript code/scripts/regressionPCR-script.R $(scaled-credit) $(trainingIndex) $(seed)
data/*.RData:
	Rscript code/scripts/regressionPLSR-script.R $(scaled-credit) $(trainingIndex) $(seed)
data/*.png:
	Rscript code/scripts/regressionLR-script.R $(scaled-credit) $(trainingIndex) $(seed)
data/*.png:
	Rscript code/scripts/regressionRR-script.R $(scaled-credit) $(trainingIndex) $(seed)
data/*.png:
	Rscript code/scripts/regressionPCR-script.R $(scaled-credit) $(trainingIndex) $(seed)
data/*.png:
	Rscript code/scripts/regressionPLSR-script.R $(scaled-credit) $(trainingIndex) $(seed)


data/*.RData: 
	Rscript code/scripts/trainingAndTestSet-script.R $(scaled-credit) $(seed)

data/*.csv: 
	Rscript code/scripts/trainingAndTestSet-script.R $(scaled-credit) $(seed)

data/*.RData:
	Rscript code/scripts/regressionOLS-script.R $(scaled-credit) $(trainingIndex)

data/*.RData:
	Rscript code/scripts/regressionRR-script.R $(scaled-credit) $(trainingIndex)



# Pre-modeling Data Processing
$(scaled-credit):
	Rscript code/scripts/premodelingDataProcessing-script.R data/Credit.csv

# Exploratory Data Analysis (EDA)
data/*.txt: 
	Rscript code/scripts/eda-script.R data/Credit.csv
data/*.RData: 
	Rscript code/scripts/eda-script.R data/Credit.csv
images/*.png: 
	Rscript code/scripts/eda-script.R data/Credit.csv

data/Credit.csv:
	curl -O http://www-bcf.usc.edu/~gareth/ISL/Credit.csv
	mv Credit.csv data/Credit.csv


data: 
	# Download the file Credit.csv to the folder data
	curl -O http://www-bcf.usc.edu/~gareth/ISL/Credit.csv
	mv Credit.csv data/Credit.csv
	Rscript code/scripts/premodelingDataProcessing-script.R data/Credit.csv
	Rscript code/scripts/trainingAndTestSet-script.R $(scaled-credit) $(seed)

tests:
	# run the unit tests of the self-defiend functions
	Rscript code/test-that.R

eda:
	# perform the exploratory data analysis
	Rscript code/scripts/eda-script.R $(csv)

ols:
	# run the OLS regression
	Rscript code/scripts/regressionOLS-script.R $(scaled-credit) $(trainingIndex)

ridge:
	# run the Ridge Regression with Seed
	Rscript code/scripts/regressionRR-script.R $(scaled-credit) $(trainingIndex) $(seed)

lasso:
	# run the Lasso Regression with Seed
	Rscript code/scripts/regressionLR-script.R $(scaled-credit) $(trainingIndex) $(seed)

pcr:
	# run the PCR with Seed
	Rscript code/scripts/regressionPCR-script.R $(scaled-credit) $(trainingIndex) $(seed)

plsr:
	# run the PLSR with Seed
	Rscript code/scripts/regressionPLSR-script.R $(scaled-credit) $(trainingIndex) $(seed)

regressions:
	make ols
	make ridge
	make lasso
	make pcr
	make plsr

report: $(rmd)
	#concatinate the four files into one
	cat $(rmd) > report/report.Rmd
	# generate report.pdf
	Rscript -e 'library(rmarkdown); render("report/report.Rmd")'

slides:
	# generate the slides.html
	Rscript -e 'library(rmarkdown); render("slides/slides.Rmd")'


session:
	bash session.sh
	Rscript code/scripts/session-info-script.R


clean:
	# Clean files
	# rm -f session-info.txt
	# rm -f data/*.csv
	# rm -f images/*.*
	# rm -f data/*.*
	rm -f report/*.pdf
	rm -f report/section/*.pdf



