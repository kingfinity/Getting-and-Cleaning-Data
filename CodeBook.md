# Running the script
`source("run_analysis.R")`  
`run_analysis.run()`

## Script Output
The script has six stages.  
[0] - Downloads the data. If looks for the file *data.zip*. If not found, the script will download the file, otherwise, it will continue    
[1] - Processes the test and train data sets, then combines them to one data set  
[2] - Extracts the mean and standard deviation measurements from the combined data set  
[3] - Renames the activities based from the *activity_labels.txt*  
[4] - Renames the labels based from *features.txt*  
[5] - Creates a tidy set based from the previous stages and writes it to *tidy_data_set.csv*  
