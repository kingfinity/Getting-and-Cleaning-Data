    
run_analysis.run = function()
{
    # Download the data for the project
    
    ## Set current working directory to M3W4/Getting-and-Cleaning-Data
    # destdir = "./M3W4/Getting-and-Cleaning-Data/"
    # setwd(destdir)
    
    ## Due to the size of the dataset, will only download if file data.zip is not present in the target destination directory
    message("[0][1] Downloading data...")
    if(!file.exists("data.zip"))
    {
        dl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(dl,"data.zip",method="curl")
        message("[0][1] Downloading data... DONE!")
        message("[0][2] Unzipping file...")
        unzip("data.zip",exdir=getwd())  
        message("[0][2] Unzipping file... DONE!")
    }
    else
    {
        message("[0][1] Downloading data... Data exists! Continuing...")
    }
    
    # 1. Merges the training and the test sets to create one data set.
    message("[1][1] Processing test set...")
    subject_test <- read.csv("./UCI HAR Dataset/test/subject_test.txt",header=FALSE,sep=" ")
    x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
    y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
    test_set <- data.frame(subject_test,y_test,x_test)
    message("[1][1] Processing test set... DONE!")
    
    message("[1][2] Processing train set...")
    subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
    y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
    train_set <- data.frame(subject_train,y_train,x_train)
    message("[1][2] Processing train set... DONE!")
    
    message("[1][3] Combining test and train sets...")
    combined_set <- rbind(test_set,train_set)
    message("[1][3] Combining test and train sets... DONE!")
    
    features <- read.csv("./UCI HAR Dataset/features.txt",header=FALSE,sep=" ")
    feature_names <- c(c("subject","activity"),as.character(features[,2]))
    names(combined_set) <- feature_names
    
    # 2. Extracts only the measurements on the mean and standard deviation for each measurement.
    message("[2][1] Extracting mean and standard deviation measurements from combined set...")
    mean_stddev <- grep("mean|std",features[,2])
    ms_combined_set <- combined_set[,c(1,2,mean_stddev+2)]
    message("[2][1] Extracting mean and standard deviation measurements from combined set... DONE!")
    
    # 3. Uses descriptive activity names to name the activities in the data set.
    message("[3][1] Renaming activities...")
    activity_labels <- read.csv("./UCI HAR Dataset/activity_labels.txt",header=FALSE,sep=" ")
    ms_combined_set$activity <- activity_labels[ms_combined_set$activity,2]
    message("[3][1] Renaming activities... DONE!")
    
    # 4. Appropriately labels the data set with descriptive variable names.
    ## Replacing all possible contractions, not just mean and std, for scalability
    ## prefix 't' => time domain signals captured at a constant rate of 50Hz; TimeDomain
    ## prefix 'f' => Fast Fourier Transform (FFT) frequency domain signals; FrequencyDomain
    ## %Acc% => Accelerometer
    ## %Gyro% => Gyroscope
    ## %Mag% => Magnitude
    ## %-mean% => Mean
    ## %-std% => StandardDeviation
    ## %-mad% => MedianAbsoluteDeviation
    ## %-max% => Maximum
    ## %-min% => Minimum
    ## %-sma% => SignalMagnitudeArea
    ## %-energy% => Sum of the squares divided by the number of values; EnergyMeasure
    ## %-iqr% => InterquartileRange
    ## %-entropy% => SignalEntropy
    ## %-arCoeff% => BurgAutoregressionCoefficient
    ## %-correlation% => CorrelationCoefficient
    ## %-maxInds% => IndexFrequencyComponentLargestMagnitude
    ## %-meanFreq% => MeanFrequency
    ## %-skewness% => Skewness
    ## %-kurtosis% => Kurtosis
    ## %-bandsEnergy% => EnergyFrequencyInterval
    ## %-angle% => Angle
    
    message("[4][1] Renaming labels...")
    temp_labels <- names(ms_combined_set)
    temp_labels <- gsub("[(][)]", "",temp_labels)
    temp_labels <- gsub("[-]", "_",temp_labels)
    temp_labels <- gsub("^t","TimeDomain_",temp_labels)
    temp_labels <- gsub("^f","FrequencyDomain_",temp_labels)
    temp_labels <- gsub("Acc","Accelerometer",temp_labels)
    temp_labels <- gsub("Gyro","Gyroscope",temp_labels)
    temp_labels <- gsub("Mag","Magnitude",temp_labels)
    temp_labels <- gsub("mean","Mean",temp_labels)
    temp_labels <- gsub("std","StandardDeviation",temp_labels)
    temp_labels <- gsub("mad","MedianAbsoluteDeviation",temp_labels)
    temp_labels <- gsub("max","Maximum",temp_labels)
    temp_labels <- gsub("min","Minimum",temp_labels)
    temp_labels <- gsub("sma","SignalMagnitudeArea",temp_labels)
    temp_labels <- gsub("energy","EnergyMeasure",temp_labels)
    temp_labels <- gsub("iqr","InterquartileRange",temp_labels)
    temp_labels <- gsub("entropy","SignalEntropy",temp_labels)
    temp_labels <- gsub("arCoeff","BurgAutoregressionCoefficient",temp_labels)
    temp_labels <- gsub("correlation","CorrelationCoefficient",temp_labels)
    temp_labels <- gsub("maxInds","IndexFrequencyComponentLargestMagnitude",temp_labels)
    temp_labels <- gsub("meanFreq","MeanFrequency",temp_labels)
    temp_labels <- gsub("MeanFreq","MeanFrequency",temp_labels)
    temp_labels <- gsub("skewness","Skewness",temp_labels)
    temp_labels <- gsub("kurtosis","Kurtosis",temp_labels)
    temp_labels <- gsub("bandsEnergy","EnergyFrequencyInterval",temp_labels)
    temp_labels <- gsub("^angle","AngleBetween_",temp_labels)
    temp_labels <- gsub("[,]","_and_",temp_labels)
    temp_labels <- gsub("[()]","",temp_labels)
    temp_labels <- gsub("[)]","",temp_labels)
    names(ms_combined_set)<-temp_labels
    message("[4][1] Renaming labels... DONE!")
    
    # 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    message("[5][1] Creating tidy set...")
    tidy_ms_combined_set <- aggregate(ms_combined_set[,3:ncol(ms_combined_set)],
                                      list(subject=ms_combined_set$subject,activity=ms_combined_set$activity),
                                      mean)
    message("[5][1] Creating tidy set... DONE!")
    message("[5][2] Writing to file tidy_data_set.txt...")
    write.table(tidy_ms_combined_set,"tidy_data_set.txt",row.names=FALSE)
    message("[5][2] Writing to file tidy_data_set.txt... DONE!")
}
