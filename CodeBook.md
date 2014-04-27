Code Book for Getting and Cleaning Data Peer Assessment
=======================================================


## Step 1 - Download data

In order to execute the script `run_analysis.r`, you must first download the smartphone dataset available here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

After unzipping the file, move the folder "UCI HAR Dataset" to your working directory.

## Step 2 - Execute run_analysis.r

The `run_analysis.r` script will take the smartphone dataset and apply the following transformations:

1) Merge the training and the test sets to create one data set.
2) Extract only the measurements on the mean and standard deviation for each measurement. 
3) Usesdescriptive activity names to name the activities in the data set
4) Appropriately labelsthe data set with descriptive activity names. 
5) Createsa second, independent tidy data set with the average of each variable for each activity and each subject. 

## Step 3 - Open tidyData.csv

The second dataset will be printed to a file called `tidyData.csv`, which contains the following columns:

`subject.id` contains an identifying number for each subject
`activity` contians a factor variable indicating the activity the subject was performing at the time of the observation. Possible values are "Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", or "Laying".
`variable` contains a factor that refers to the mean or standard deviation of a particular observation type. 
`average` contains a numerical value equal to the mean of a particular variable for a given `subject.id` and `activity`.
