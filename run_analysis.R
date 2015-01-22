#set working directory and open train and test files
setwd("~/Dropbox/RTutorials/Coursera3-Getting&CleaningData/C3GetCleanData_CourseProject")

###Part 1
###Merge training and test data into one data set:

#first load the training and test data on measurements, activity, and subject
train_data_x <- read.table("./UCI HAR Dataset/train//X_train.txt", header = FALSE)
train_data_y <- read.table("./UCI HAR Dataset/train//y_train.txt", header = FALSE)
train_data_subj <- read.table("./UCI HAR Dataset/train//subject_train.txt", header = FALSE)

test_data_x <- read.table("./UCI HAR Dataset/test//X_test.txt", header = FALSE)
test_data_y <- read.table("./UCI HAR Dataset/test//y_test.txt", header = FALSE)
test_data_subj <- read.table("./UCI HAR Dataset/test//subject_test.txt", header = FALSE)

#check dim for each file to evaluate how to combine data below:
dim(train_data_x) ; dim(train_data_y) ; dim(train_data_subj)
dim(test_data_x) ; dim(test_data_y) ; dim(test_data_subj)

#combine x, y, and subj data for training and test with cbind
#with subject (subj) value in left most column, followed activity (y) value, 
#then measurement (x) values
train_data <- cbind(train_data_subj, train_data_y, train_data_x)
test_data <- cbind(test_data_subj, test_data_y, test_data_x)

#Merge training and test into one data frame
all_data <- rbind(train_data, test_data)

###Part 2 
###Extract only measurements on the mean and standard deviation
###for each measurement:

#First get feature names from the features.txt file
features <- read.table("./UCI HAR Dataset//features.txt", header = FALSE, 
                       stringsAsFactors = FALSE)

#combine these names (transposed) with the headers Subject and Activity
f_names <- c("Subject","Activity",t(features[,2]))

#and assign the names to the columns of all_data, but first converting it to be
#unique names to remove the problematic parentheses and dashes
names(all_data) <- make.names(f_names, unique = TRUE)

#with the names, get a list of indicies for columns containing mean or std
#used fixed = TRUE to exclude meanFreq() columns
#and ignore.case = FALSE to exclude columns with Mean in the name
mean_indicies <- grep("mean()", f_names, fixed = TRUE, ignore.case = FALSE)
sd_indicies <- grep("std()", f_names, fixed = TRUE, , ignore.case = FALSE)

#create new data frame subset_data which only contains the 
#columns with information on Subject, Activity, means, and sds
subset_data <- all_data[,c(1,2,mean_indicies, sd_indicies)]

###Part 3
###Use descriptive names to label activities in data set:

##get activity labels from the features.txt file
act_labels <- read.table("./UCI HAR Dataset//activity_labels.txt", header = FALSE, 
                       stringsAsFactors = FALSE)

#now create a new variable called Act_labels, which makes Activity a 
#factor with the labels from act_labels in column 2
subset_data$Act_Labels <- factor(subset_data$Activity, labels = t(act_labels[,2]))

###Part 4
###Label data with descriptive variable names:

#First I copied names to this temporary vector of names
temp_names <- names(subset_data)

#change names with mean in them:
temp_names <- gsub(".mean...", "Mean", temp_names)
temp_names <- gsub(".mean..", "Mean", temp_names)

#change names with std in them:
temp_names <- gsub(".std...", "Sd", temp_names)
temp_names <- gsub(".std..", "Sd", temp_names)

#fix duplicate BodyBody
temp_names <- gsub("BodyBody", "Body", temp_names)

#Now make these temp_names the names of the tidy subset_data
names(subset_data) <- temp_names

###Part 5
#Lastly, create a second, independent tidy data set with the
#average of each variable for each activity and each subject using plyr:

library(plyr)
subset_averages <- ddply(subset_data, .(Subject, Act_Labels), numcolwise(mean))
write.table(subset_averages, "tidy_data_means.txt", row.names = FALSE)
