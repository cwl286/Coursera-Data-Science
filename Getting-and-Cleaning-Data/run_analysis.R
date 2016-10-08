## You should create one R script called run_analysis.R that does the following. 
## (1) Merges the training and the test sets to create one data set.
## (2)Extracts only the measurements on the mean and standard deviation for each measurement. 
## (3)Uses descriptive activity names to name the activities in the data set
## (4)Appropriately labels the data set with descriptive variable names. 
## (5)From the data set in step 4, creates a second, independent tidy data set with the average 
##    of each variable for each activity and each subject.

## Set working directory where files are located
setwd("C:/Users/Waffles/Documents/UCI HAR Dataset")

## Read data from files
activity_labels <- read.table('./activity_labels.txt', header = FALSE)
features <- read.table('./features.txt', header = FALSE)

## Read data from training files
subjectTrain <- read.table('./train/subject_train.txt', header = FALSE)
xTrain <- read.table('./train/X_train.txt', header = FALSE) 
yTrain <- read.table('./train/y_train.txt', header = FALSE)

## Read data from testing files
subjectTest <- read.table('./test/subject_test.txt', header = FALSE)
xTest <- read.table('./test/X_test.txt', header = FALSE) 
yTest <- read.table('./test/y_test.txt', header = FALSE)

## Add column labels to the above data sets
colnames(activity_labels) = c("activityId", "activityName")
colnames(subjectTrain) = "subjectId"
colnames(xTrain) = features[,2]
colnames(yTrain) = "activityId"
colnames(subjectTest) = "subjectId"
colnames(xTest) = features[,2]
colnames(yTest) = "activityId"


## (1) Merge the training and the test sets to create one data set.
## Create separate data sets for training and testing, then merge them.
trainData = cbind(xTrain,yTrain,subjectTrain)
testData = cbind(xTest,yTest,subjectTest)
projectData = rbind(trainData,testData)


## (2)Extract only the measurements on the mean and standard deviation for each measurement. 
meanStdFeatures<- grepl("(-mean\\(\\)|-std\\(\\))", features$V2)
meanStdData <- projectData[,meanStdFeatures]


## (3)Use descriptive activity names to name the activities in the data set.
meanStdNamedData <- merge(activity_labels, meanStdData, by = "activityId", all = TRUE)


## (4)Appropriately label the data set with descriptive variable names.
names(meanStdNamedData)<-gsub("\\()","", names(meanStdNamedData))
names(meanStdNamedData)<-gsub("std","StdDev", names(meanStdNamedData))
names(meanStdNamedData)<-gsub("mean","Mean", names(meanStdNamedData))
names(meanStdNamedData)<-gsub("^(t)","time", names(meanStdNamedData))
names(meanStdNamedData)<-gsub("^(f)","freq", names(meanStdNamedData))
names(meanStdNamedData)<-gsub("BodyBody","Body", names(meanStdNamedData))

## Reorder the columns so that "subjectId" appears first
meanStdNamedData<-meanStdNamedData[c(69, 1:68)]

## (5)From the data set in step 4, create a second, independent tidy data set with the average 
##    of each variable for each activity and each subject.
library(dplyr)
tidyData <- aggregate(.~subjectId+activityName, meanStdNamedData, mean)
tidyData <- tidyData[order(tidyData$subjectId, tidyData$activityId),]
write.table(tidyData, file = "tidy_data.txt", row.name = FALSE)