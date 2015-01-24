# C3GetCleanData_CourseProject

This repository contains the files relevant to my course project for the Coursera course on Getting and Cleaning Data taught by Drs. Jeff Leek, Roger D. Peng, and Brian Caffo from Johns Hopkins - Bloomberg School of Public Health.

## Contents of Repository
This repository contains the following files:

1. run_analysis.R

- The run_analysis.R script is written with the assumption that the working directory for this script contains a sub-directory, "UCI HAR Dataset", containing the Samsung data downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

- This file is an R script that does the following things as per the assignment guidelines, most notably, this script produces the tidy_data_means.txt file described below.

i. Loads and merges the training and the test sets to create one data set.

ii. Extracts only the measurements on the mean and standard deviation for each measurement. 

iii. Uses descriptive activity names to name the activities in the data set.

iv. Appropriately labels the data set with descriptive variable names. 

v. From the data set created in step 4, the script creates a second, independent tidy data set (tidy_data_means.txt) with the average of each variable for each activity and each subject.

2. tidy_data_means.txt

- This is the output from the data set created in step 5 of run_analysis.R.

- Contains the averages of each variable for each activity and each subject.

3. CodeBook.md

- This is a code book that describes the variables, the data, and any transformations or work that was performed to clean up the data used in run_analysis.R on the train and test data located in the UCI HAR Dataset.

- The code book refers the reader to some additional information contained in the features_info.txt and README.txt files that are downloaded along with the Samsung data and contained within the UCI HAR Dataset directory.
