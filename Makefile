# Declare phony targets
.PHONY: all data clean tests eda regression report

# Output
csv = data/Credit.csv
RData = data/*.RData
png = images/*.png
txt = data/*.txt
# The randomization seed for training and test set
seed = 1 

output = $(csv) $(RData) $(png) $(txt)
all: $(output)


# PHONY targets

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

session:
	bash session.sh

data: 
	# Download the file Credit.csv to the folder data
	curl -O http://www-bcf.usc.edu/~gareth/ISL/Credit.csv
	mv Credit.csv data/Credit.csv


clean:
	# Clean files
	# rm -f data/Credit.csv