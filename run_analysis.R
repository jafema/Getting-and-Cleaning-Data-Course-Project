# upload the library dplyr to use the functions included in the package dplyr to manipulate the data

library(dplyr)


# set the Set Working directory as to source file location

# ==================================================================================================
# Upload the data from txt files for merging 
# the training and the test sets to create one data set

# get Features names
file <- "UCI HAR Dataset/features.txt"
Features <- read.table(file)

# get activity labels
file <- "UCI HAR Dataset/activity_labels.txt"
activity_label <- read.table(file)

# ------------------
# data from Train
# get subject train
file <- "UCI HAR Dataset/train/subject_train.txt"
TrainSubject <- read.table(file)

# gets the number related with the activity
file <- "UCI HAR Dataset/train/y_train.txt"
TrainActivity <- read.table(file)

# gets the values related with the features
file <- "UCI HAR Dataset/train/X_train.txt"
TrainFeature <- read.table(file)

# ------------------
# data from Test 
# get subject test
file <- "UCI HAR Dataset/test/subject_test.txt"
TestSubject <- read.table(file)

# gets the number related with the activity
file <- "UCI HAR Dataset/test/y_test.txt"
TestActivity <- read.table(file)

# gets the values related with the features
file <- "UCI HAR Dataset/test/X_test.txt"
TestFeature <- read.table(file)


# ==================================================================================================
# building the data frame by combinng row and columns
# set data for building the information regarding the subject base on the data from TrainSubject and TestSubject
# these data are number which represents a specific subject
subject <- rbind(TrainSubject,TestSubject)

# set data for building the information regarding the activity base on the data from TrainActivity and TestActivity
# these data are the number realeted to the activities done by the subject in the experiment
activity <- rbind(TrainActivity,TestActivity)

# set data for building the information regarding the feature base on the data from TrainFeature and TestFeature, 
# these data are the measurement of the experiment for a specific feature
feature <- rbind(TrainFeature,TestFeature)

# naming the variables (columns)
names(subject) <- c("subject")
names(activity) <- c("activity")
names(feature) <- Features$V2 # takes the names from the txt file where feature list is defined


# merge all in one data frame
DF <- cbind(subject,activity,feature)

# pass data to Data Frame Table according dplyr to use the methods from this library over the data
DF <- tbl_df(DF)

# ==================================================================================================
# Extracts only the measurements on the mean and standard deviation for each measurement 
# also it will get the columns regarding subject, activity
# with contains is selected the variables which have the string specified
DF <- select(DF,1:2, contains("-mean()"), contains("-std()") )

# ==================================================================================================
# replacing the content of DF activity by labels instead numbers
DF$activity <- activity_label[DF$activity,2]


# ==================================================================================================
# Appropriately labels the data set with descriptive variable names
# remove from the varialbes names characters as (, ), -
names(DF) <- sub("()","",names(DF),fixed = TRUE)
names(DF) <- sub("-","",names(DF),fixed = TRUE)
names(DF) <- sub("-","",names(DF),fixed = TRUE)


# ==================================================================================================
# Creates a second, independent tidy data set with the average of each variable for each activity 
# and each subject

# group data by variables subject and activity
DF_tidy_act_sub <- group_by(DF, subject, activity)

# order the data 
DF_tidy_act_sub <- arrange(DF_tidy_act_sub, subject, activity )

# summarise the data to get the average information per variable regarding subject and activity
DF_tidy_act_sub <- summarise_each(DF_tidy_act_sub, funs(mean)) 

# ==================================================================================================
# printing is txt the file the data frame with the summarise info
write.table(DF_tidy_act_sub, "E:/Coursera/Getting_and_Cleaning_Data/project/output_data.txt", sep="\t", row.names = FALSE)

