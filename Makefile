# Declare phony targets
.PHONY: all data clean tests eda regression report

# Output
csv = data/Credit.csv
RData = data/*.RData
png = images/*.png

output = $(csv) $(RData) $(png)
all: $(output)


# PHONY targets

# Exploratory Data Analysis (EDA)
data/eda-output.txt: code/scripts/eda-script.R data/Credit.csv
	Rscript code/scripts/eda-script.R data/Credit.csv
data/eda-summaryMatrix.RData: code/scripts/eda-script.R data/Credit.csv
	Rscript code/scripts/eda-script.R data/Credit.csv
images/*png: code/scripts/eda-script.R data/Credit.csv
	Rscript code/scripts/eda-script.R data/Credit.csv



data: 
	# Download the file Credit.csv to the folder data
	curl -O http://www-bcf.usc.edu/~gareth/ISL/Credit.csv
	mv Credit.csv data/Credit.csv


clean:
	# Clean files
	# rm -f data/Credit.csv