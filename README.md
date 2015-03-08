# Getting and Cleaning Data 
## Course Project

The Goal of this project to prepare a well-labelled and tidy data from the raw data (labels are stored in separate files, separate training and test datasets, etc.) that was collected from accelerometers of Samsung Galaxy S smartphones (more about the raw data in http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 

This file describes how to re-produce the end-result of the project, which is the aggregated tidy dataset (with name as summary.txt) that restores average mean and standard deviations of the accelerometer measurements across activities and subjects. The project also produces another intermediate tidy dataset (with name as labelleddata.txt, but not included in this repository) that restores original mean and standard deviations of the accelerometer measurements for for each activity and subject.  

For re-producing the above mentioned tidy datasets, you will need to run run_analysis.R in RStudio or R. But before that, please
 * Download the zipped raw data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzip the file
 * Rename the folder "UCI HAR Dataset" as "data"
 * Make sure that the folder "data" and run_analysis.R are both in the current working directory

The run_analysis.R does the followings in steps
 1. Merges the training and the test datasets into one dataset
 2. Extracts only the mean and standard deviation of the accelerometer measurements
 3. Uses the descriptive activity names to label the activities in the dataset
 4. Appropriately labels the dataset with descriptive activity names and exports labelled.txt dataset (intermediate tidy dataset)
 5. Creates another final tidy dataset (summarydata.txt) that stores the average mean and standard devieations of the accelerometer measurements across activities and subjects
