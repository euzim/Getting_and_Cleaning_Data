# Getting and Cleaning Data Course Project Code Book

This is the code book that describes the variables, the data, and the transformations or work that have been performed to clean up the data.

- The data was obtained at the site:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

- Here is the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

- The script run_analysis.R cleans the data obtained from the link above via the following steps:

*** Step 1: Merge the training and the test sets to create one data set ***

1. Read the train set X_train.txt, Y_train.txt and subject_train.txt from “./UCI HAR Dataset/train" directory, and store them as x_train, y_train and subject_train variables, respectively.

2. Read the test set X_test.txt, Y_test.txt and subject_test.txt from “./UCI HAR Dataset/test” directory, and store them as x_test, y_test and subject_test variables, respectively.

3. Merge x_train and x_test to create x_data.

4. Merge y_train and y_test to create y_data.

5. Merge subject_train and subject_test to create subject_data.

*** Step 2. Extract only the measurements on the mean and standard deviation for each measurement ***

1. Read features.txt from “./UCI HAR Dataset" directory and save it as the variable features.

2. Find the row numbers for the features that contain “mean()” (for mean values) and “std()” (for standard deviation).

3. Extract a subset of x_data with the row numbers found in #2 and overwrite x_data.


*** Step 3. Use descriptive activity names to name the activities in the data set ***

1. Read activity_labels.txt from “./UCI HAR Dataset" directory and save it as activity_labels.

2. Clean the activity names given in the second column of activity_labels by replacing “_”  (underscore) by “ “ (space), making all the letters lower cases, and capitalizing only the first letter of each word.

3. Transform the values in y_data into the activity names based on the relationship between the activity class labels and names given in activity_labels.

*** Step 4. Appropriately label the data set with descriptive variable names ***

1. Clean the column names of x_data by changing from “mean” to “Mean”, changing from “std” to “Std” and removing “()” and “_”.

2. Add the column name “Activity” for y_data.

3. Add the column name “Subject” for subject_data.

4. Merge subject_data, y_data and x_data by column and save it as tidy_data.

*** Step 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject ***

1. There are 30 subjects and 6 activities, which create 180 combinations of subjects and activities. For each combination, the average of each variable is calculated. Run this in nested for loops, one for subject and the other for activity. Insert the output into the new data frame called tidy_data2.

2. Write tidy_data2 into "tidy_data_meanActivityAndSubject.txt" in the current working directory.
