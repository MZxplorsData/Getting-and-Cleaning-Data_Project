##########################################
### Getting and Cleaning Data - Week 4 ###
##########################################

rm(list=ls()) # clear the environnment of all objects defined previously
getwd() # get working directory

## Step 1
## Merges the training and the test datasets into one dataset
traindata = read.table("./data/train/X_train.txt") 
trainlabel = read.table("./data/train/y_train.txt") 
table(trainlabel) 
trainsubject = read.table("./data/train/subject_train.txt") 

testdata = read.table("./data/test/X_test.txt") 
testlabel = read.table("./data/test/y_test.txt")  
table(testlabel)  
testsubject = read.table("./data/test/subject_test.txt") 

mergeddata = rbind(traindata, testdata) 
mergedlabel = rbind(trainlabel, testlabel) 
mergedsubject = rbind(trainsubject, testsubject) 


## Step2
## Extracts only the mean and standard deviation of the accelerometer measurements
features = read.table("./data/features.txt") 
meanstdindex = grep("mean\\(\\)|std\\(\\)", features[, 2]) 
length(meanstdindex)
mergeddata = mergeddata[, meanstdindex] 
names(mergeddata) = gsub("\\(\\)", "", features[meanstdindex, 2]) 
names(mergeddata) = gsub("mean", "Mean", names(mergeddata)) 
names(mergeddata) = gsub("std", "Std", names(mergeddata)) 
names(mergeddata) = gsub("-", "", names(mergeddata))


#$ Step3
## Uses the descriptive activity names to label the activities in the dataset 
activity = read.table("./data/activity_labels.txt") 
activity[, 2] = tolower(gsub("_", "", activity[, 2])) 
substr(activity[2, 2], 8, 8) = toupper(substr(activity[2, 2], 8, 8)) 
substr(activity[3, 2], 8, 8) = toupper(substr(activity[3, 2], 8, 8)) 
mergedlabel[, 1] = activity[mergedlabel[, 1], 2] 
names(mergedlabel) = "activity" 


## Step4
## Appropriately labels the dataset with descriptive activity names and 
## exports labelled.txt dataset (intermediate tidy dataset)
names(mergedsubject) = "subject" 
labelleddata = cbind(mergedsubject, mergedlabel, mergeddata) 
write.table(labelleddata, "labelleddata.txt")  


## Step5
## Creates another final tidy dataset that stores the average mean and 
## standard devieations of the accelerometer measurements 
## across activities and subjects 
numsubject = length(table(mergedsubject))  
numactivity = dim(activity)[1]  
numcol = dim(labelleddata)[2] 
tidy = as.data.frame(matrix(NA, nrow = numsubject * numactivity, ncol = numcol))  
colnames(tidy) = colnames(labelleddata) 
row = 1 
for(i in 1:numsubject) { 
    for(j in 1:numactivity) { 
        tidy[row, 1] = sort(unique(mergedsubject)[, 1])[i] 
        tidy[row, 2] = activity[j, 2] 
        loop1 = i == labelleddata$subject 
        loop2 = activity[j, 2] == labelleddata$activity 
        tidy[row, 3:numcol] = colMeans(labelleddata[loop1&loop2, 3:numcol]) 
        row = row + 1 
        }
} 
head(tidy, 2) 
write.table(tidy, "summarydata.txt", row.name = F) 