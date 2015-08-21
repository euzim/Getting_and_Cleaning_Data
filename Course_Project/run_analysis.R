## Getting and Cleaning Data 
## Course Project

# The data is collected from the embedded accelerometer in Samsung Galaxy S 
# smartphone worn by a group of 30 volunteers within an age bracket of 19-48 years, 
# and gyroscope. Each person performed six activities (WALKING, WALKING_UPSTAIRS, 
# WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). 
# A full description is available at the site where the data was obtained: 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# Here are the data for the project: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# Create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each 
# measurement. 
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.

## =================================================================================
## Step 1. Merges the training and the test sets to create one data set.
# Training set
x_train <- read.table('./UCI HAR Dataset/train/X_train.txt')
y_train <- read.table('./UCI HAR Dataset/train/Y_train.txt')
subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt')

# Test set
x_test <- read.table('./UCI HAR Dataset/test/X_test.txt')
y_test <- read.table('./UCI HAR Dataset/test/Y_test.txt')
subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt')

# Merge
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

## =================================================================================
# Step 2. Extracts only the measurements on the mean and standard deviation for each 
# measurement. 
features <- read.table('./UCI HAR Dataset/features.txt')
mean <- grep('mean\\(\\)',features[,2])
std <- grep('std\\(\\)',features[,2])
meanANDstdIndex <- union(mean, std)
x_data <- x_data[,meanANDstdIndex]

## =================================================================================
# Step 3. Uses descriptive activity names to name the activities in the data set.
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity_labels[, 2] <- gsub("_", " ", activity_labels[, 2])
activity_labels[, 2] <- tolower(activity_labels[, 2])
substr(activity_labels[, 2], 1, 1) <- toupper(substr(activity_labels[, 2], 1, 1))
substr(activity_labels[2, 2], 9, 9) <- toupper(substr(activity_labels[2, 2], 9, 9))
substr(activity_labels[3, 2], 9, 9) <- toupper(substr(activity_labels[3, 2], 9, 9))
activityLabels <- activity_labels[y_data[, 1], 2]
y_data[, 1] <- activityLabels

## =================================================================================
# Step 4. Appropriately labels the data set with descriptive variable names. 
names(x_data) <- gsub("mean", "Mean", features[meanANDstdIndex, 2])
names(x_data) <- gsub("std", "Std", names(x_data))
names(x_data) <- gsub("\\(\\)", "", names(x_data))
names(x_data) <- gsub("-", "", names(x_data))
names(y_data) <- "Activity"
names(subject_data) <- "Subject"
tidy_data <- cbind(subject_data, y_data, x_data)

## =================================================================================
# Step 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
usubject <- sort(unique(subject_data[,1]))
nsubject <- length(usubject)
nactivity <- dim(activity_labels)[1]
ncolumn <- dim(tidy_data)[2]
tidy_data2 <- matrix(NA, nrow = nsubject*nactivity, ncol = ncolumn) 
tidy_data2 <- as.data.frame(tidy_data2)
colnames(tidy_data2) <- colnames(tidy_data)
rowindex <- 1
for(i in 1:nsubject) {
    for(j in 1:nactivity) {
        tidy_data2[rowindex, 1] <- usubject[i]
        tidy_data2[rowindex, 2] <- activity_labels[j, 2]
        subjectRows <- i == tidy_data$Subject
        activityRows <- activity_labels[j, 2] == tidy_data$Activity
        tidy_data2[rowindex, 3:ncolumn] <- colMeans(tidy_data[subjectRows&activityRows, 3:ncolumn])
        rowindex <- rowindex + 1
    }
}
write.table(tidy_data2, file = "tidy_data_meanActivityAndSubject.txt", row.name = FALSE) 
