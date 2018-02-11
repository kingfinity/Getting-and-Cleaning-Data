# Running the script
source("run_analysis.R")
run_analysis.run()

The script has six stages.
[0] - Downloads the data. If zipped file is already present, it continues with the next phases
[1] - Processes the test and train data sets, then combines them to one data set
[2] - Extracts the mean and standard deviation measurements from the combined data set
[3] - Renames the activities based from the activity_labels.txt
[4] - Renames the labels based from features.txt
[5] - Creates a tidy set based from the previous stages and writes it to tidy_data_set.csv