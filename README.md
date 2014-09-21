Getting and Cleaning Data Course Project
========================================

Script: *run_analysis.R*

Set the Set Working directory as to source file location, in this path is present also the data form UCI HAR Dataset.zip in uncompress format.

Firstly, it is need to get the data. This is done by reading the files
* features.txt
* activity_labels.txt
* subject_train.txt
* y_train.txt
* X_train.txt
* subject_test.txt
* y_test.txt
* X_test.txt

The data from each file will be stored in a data frame according the following relation 
features.txt	==>	Features
* activity_labels.txt	==>	activity_label
* subject_train.txt	==>	TrainSubject
* y_train.txt	==>	TrainActivity
* X_train.txt	==>	 TrainFeature
* subject_test.txt 	==>	TestSubject
* y_test.txt ==>	TestActivity
* X_test.txt ==>	TestFeature

All these data will be used to build a global data frame to be used in the analysis.

In the forum there is a thread from David Hood show a picture about the structure of the global data frame:
https://class.coursera.org/getdata-007/forum/thread?thread_id=49

This script follows this pattern with the difference for the variables Subject and Activity which are located in the first and second column.

The process for  building the data frame by combinng row and columns, by the methods rbind and cbind.

For building the variable "subject" will be by combining the data from TrainSubject and TestSubject, these data are number which represents a specific subject, this data are stored in the data frame "subject".

Variable "activity" is created with the information regarding the activity base on the data from TrainActivity and TestActivity, these data are the number realeted to the activities done by the subject in the experiment. This data are stored in the data frame "activity".

The variables related to features are created combining the data alocated at TrainFeature and TestFeature, these data are the measurement of the experiment for a specific feature, these data are stored in the data frame "feature".

The all data are put together but each varaible should have a specific name, so the data frame subject  has the variable "subject", the data frame activity has the varaible "activity" and for the data stored in the data frame feature the variables are named with the names from the data frame Features which is the data frame that takes the names from the txt file where feature list is defined

Now all variables are combined following the order subject,activity,feature. By doing this the global data frame is created, this data frame has been named as "data".

To get profit from package dplyr data freme is transformed. "data" to Data Frame Table to use the methods from this library over the data. This step creates the variable DF.
Over this DF will be select the only the measurements on the mean and standard deviation for each measurement also it will get the columns regarding subject, activity.
There are just take the varialbes that include mean() and std() at the end. Due tu according features_info.txt mean(): Mean value and std(): Standard deviation.
This selection is store in a data frame table named DF

The activity variable observations are replaced by labels instead number in order to have a clear view about the meaning. The list of activities related to each number may be found at activity_labels.txt.
Some variables are renamed by removing characters as (, ), - will make more difficult work wit it over the script.

As is requested by the project a second data frame is created, independent tidy data set with the average of each variable for each activity and each subject. This is get by groupping the data by variables subject and activity,ordering and later on summarising the data to get the average information per variable regarding subject and activity. This data are store in a data frame table named DF_tidy_act_sub

As a final step DF_tidy_act_sub is printing is txt the file.

One way to read the data from this txt file is with the following R code:
```
data <- read.table(file_path, header = TRUE) 
View(data)
```
