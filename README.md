---
title: "README"
author: "Gregory Julock"
date: "4/28/2020"
output: html_document
---
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
# README.md File

This README file explains how all of the scripts work for the Getting and Cleaning Data Course Project and how they are connected. 

The script files included in the project: 
README.md
CodeBook.md
run_analysis.R

The Codebook.md file is a code book that describes the variables, the data, and any transformations or work that was performed to clean up the data.

The run_analysis.R file is the primary script.

## Explanation of project:
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. This project provides the following: 1) a tidy data set as described below, 2) a link to a Github repository with a script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. There is a README.md in the repo with the scripts. This repo explains how all of the scripts work and how they are connected.

Project Description: One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 

## run_analysis.R File code and comments
### The script first sets the working directory and the libraries needed
```{R message=FALSE}
#setwd("/Users/gj/Rstudio-repo-local/R cleaning project")
library(data.table)
library(dplyr)
library(tidyverse)
```
## 1. Merges the training and test sets to create one data set

### Read dataset metadata into  dataframes
```{R results='hide', message=FALSE}
listoffeatures <- fread("./UCI HAR Dataset/features.txt")
activitylables <- fread("./UCI HAR Dataset/activity_labels.txt")
```

### Read training set data into dataframes
```{R results='hide',message=FALSE}
trainsetx <- fread("./UCI HAR Dataset/train/X_train.txt")
trainlabelsety <- fread("./UCI HAR Dataset/train/y_train.txt")
trainsubject <- fread("UCI HAR Dataset/train/subject_train.txt")
```

### Read testing dataset data into dataframes
```{R results='hide',message=FALSE}
testingsetx <- fread("UCI HAR Dataset/test/X_test.txt")
testlabelsety <-fread("UCI HAR Dataset/test/y_test.txt")
testsubject <- fread("UCI HAR Dataset/test/subject_test.txt")
```
### Merging of the training and the test sets to create one data set.
```{R results='hide',message=FALSE}
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
```
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
```{R results='hide',message=FALSE}
#get the columns that have mean and standard deviation in the label
columnsmeanstd <- grep(".*mean.*|.*std.*", names(combineddataset), ignore.case=TRUE)
# format list of columns with activity, subject, and the features that have means and std deviation
columnsneededlist <- c(1,2,columnsmeanstd)
# create the formated data frame
columnsneeddf <- combineddataset[, columnsneededlist, with=FALSE]
print(str(columnsneeddf))
```
## 3. Use descriptive activity names to name the activities in the data set
```{R results='hide',message=FALSE}
#check activity number in column and replace with corresponding activity label
for (i in 1:6){ columnsneeddf$V2[columnsneeddf$V2 == i] <- c(activitylables$V2[i])}
print(columnsneeddf$V2)
```
## 4. Appropiately labels the data set with descriptive variable names
```{R results='hide',message=FALSE}
#feature column names were already set previously
#finish setting column names Subject and Activity
colnames(columnsneeddf)[colnames(columnsneeddf) %in% c("V1", "V2")] <- c("Subject", "Activity")
print(names(columnsneeddf))
```
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
```{R results='hide',message=FALSE, warning=FALSE}
# each variable for each activity and each subject
avgtidydata <- columnsneeddf %>%
                             group_by(Subject, Activity) %>%
                             summarize_each(funs(mean))
print(avgtidydata)
# Write the tidy dataset to a file
fwrite(avgtidydata, file="./avgtidydata.txt")
```

            