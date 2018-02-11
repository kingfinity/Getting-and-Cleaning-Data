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
[5] - Creates a tidy set based from the previous stages and writes it to *tidy_data_set.txt*  

### Some notes
#### Stage 1 - Downloads the data
Due to the size of the dataset, will only download if file data.zip is not present in the target destination directory  
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

#### Stage 4 - Renames the labels based from *features.txt*
The script replaces all possible contractions, not just mean and std, for scalability  

* prefix 't' => time domain signals captured at a constant rate of 50Hz; TimeDomain
* prefix 'f' => Fast Fourier Transform (FFT) frequency domain signals; FrequencyDomain
* %Acc% => Accelerometer
* %Gyro% => Gyroscope
* %Mag% => Magnitude
* %-mean% => Mean
* %-std% => StandardDeviation
* %-mad% => MedianAbsoluteDeviation
* %-max% => Maximum
* %-min% => Minimum
* %-sma% => SignalMagnitudeArea
* %-energy% => Sum of the squares divided by the number of values; EnergyMeasure
* %-iqr% => InterquartileRange
* %-entropy% => SignalEntropy
* %-arCoeff% => BurgAutoregressionCoefficient
* %-correlation% => CorrelationCoefficient
* %-maxInds% => IndexFrequencyComponentLargestMagnitude
* %-meanFreq% => MeanFrequency
* %-skewness% => Skewness
* %-kurtosis% => Kurtosis
* %-bandsEnergy% => EnergyFrequencyInterval
* %-angle% => Angle
