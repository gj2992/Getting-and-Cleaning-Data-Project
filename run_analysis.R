#File: run_analysis.R
#Author: Gregory Julock
#Getting and Cleaning Data Course Project
#26 APR 2020

library(data.table)
library(dplyr)
library(tidyverse)
#
# 1. Merges the training and test sets to create one data set
#
# read dataset metadata into  dataframes
listoffeatures <- fread("./UCI HAR Dataset/features.txt")
activitylables <- fread("./UCI HAR Dataset/activity_labels.txt")

# Read training set data into dataframes
trainsetx <- fread("./UCI HAR Dataset/train/X_train.txt")
trainlabelsety <- fread("./UCI HAR Dataset/train/y_train.txt")
trainsubject <- fread("UCI HAR Dataset/train/subject_train.txt")

#read testing dataset data into dataframes
testingsetx <- fread("UCI HAR Dataset/test/X_test.txt")
testlabelsety <-fread("UCI HAR Dataset/test/y_test.txt")
testsubject <- fread("UCI HAR Dataset/test/subject_test.txt")
######################################
# 1. Merges the training and the test sets to create one data set.
#combine sub datasets
activity <- rbind(trainlabelsety,testlabelsety)
features <- rbind(trainsetx,testingsetx)
subject <- rbind(trainsubject,testsubject)
#set column names 
colnames(activity) <- "V2"
# transpose the column of feature names and set the feature column names
colnames(features) <- t(listoffeatures[,2])
#combine (Merge) into one dataset
combineddataset <- cbind(subject, activity, features)
print(str(combineddataset))

####################################
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
#get the columns that have mean and standard deviation in the label
columnsmeanstd <- grep(".*mean.*|.*std.*", names(combineddataset), ignore.case=TRUE)
# format list of columns with activity, subject, and the features that have means and std deviation
columnsneededlist <- c(1,2,columnsmeanstd)
# create the formated data frame
columnsneeddf <- combineddataset[, columnsneededlist, with=FALSE]
print(str(columnsneeddf))
####################################
# 3. Use descriptive activity names to name the activities in the data set
#check activity number in column and replace with corresponding activity label
for (i in 1:6){ columnsneeddf$V2[columnsneeddf$V2 == i] <- c(activitylables$V2[i])}
print(columnsneeddf$V2)
####################################
# 4. Appropiately labels the data set with descriptive variable names
#feature column names were already set previously
#finish setting column names Subject and Activity
colnames(columnsneeddf)[colnames(columnsneeddf) %in% c("V1", "V2")] <- c("Subject", "Activity")
print(names(columnsneeddf))
###################################
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject
avgtidydata <- columnsneeddf %>%
                             group_by(Subject, Activity) %>%
                             summarize_each(funs(mean))
print(avgtidydata)
# Write the tidy dataset to a file
fwrite(avgtidydata, file="./avgtidydata.txt")
