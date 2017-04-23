# R script - coursera - Getting & Cleaning Data project.
#R script called run_analysis.R that does the following.

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# step 1 - Downloading data from the URL (done outside of script)
# step 2 - function to load the features and activity labels data

local_data_source <- "/home/balman/R/UCI HAR Dataset"
activityLabels <- read.table("/home/balman/R/UCI HAR Dataset/activity_labels.txt")
features <- read.table("/home/balman/R/UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])
reqFeatures <- grep(pattern = ".*mean.*|.*std.*", features[,2])
reqFeatures.names <- features[reqFeatures,2]
reqFeatures.names <- gsub('-mean','Mean',reqFeatures.names)
reqFeatures.names <- gsub('-std','Std',reqFeatures.names)
reqFeatures.names <- gsub('[()-]','',reqFeatures.names)
#load train and test data
trainData <- read.table(file = "/home/balman/R/UCI HAR Dataset/train/X_train.txt")[reqFeatures]
trainActivities <- read.table(file = "/home/balman/R/UCI HAR Dataset/train/y_train.txt")
trainSubjects <- read.table(file = "/home/balman/R/UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, trainData)
# load test data
testData <- read.table("/home/balman/R/UCI HAR Dataset/test/X_test.txt")[reqFeatures]
testActivities <- read.table("/home/balman/R/UCI HAR Dataset/test/y_test.txt")
testSubjects <- read.table("/home/balman/R/UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, testData)
#merge both datasets
MasterData <- rbind(train, test)
colnames(MasterData) <- c("subject", "activity", reqFeatures.names)
# turn activities and subjects into factors
MasterData$activity <- factor(MasterData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
MasterData$subject <- as.factor(MasterData$subject)
#load package reshape2 to make the melt command work
library(reshape2)
MasterData.melted <- melt(MasterData, id = c("subject", "activity"))
MasterData.mean <- dcast(MasterData.melted, subject + activity ~ variable, mean)
write.table(MasterData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
