# Declare phony targets
.PHONY: all data clean tests eda regression report

# Output
csv = data/Credit.csv

output = $(csv) 

all: $(output)


# PHONY targets
data: 
	# Download the file Credit.csv to the folder data
	curl -O http://www-bcf.usc.edu/~gareth/ISL/Credit.csv
	mv Credit.csv data/Credit.csv


clean:
	# Clean files
	# rm -f data/Credit.csv