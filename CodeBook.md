CodeBook
=========
The data are obtanined from different txt files are they are merged in one data frame to be used in the analysis.

In the forum there is a thread from David Hood show a picture about the structure of the global data
frame
https://class.coursera.org/getdata-007/forum/thread?thread_id=49

The data structure follows this pattern with the difference for the variables Subject and Activity which are located in the first and second column.

The variable list will be
*  subject
*  activity
*  features (variables from the file features.txt)

This data are stores in oned data frame DF.

Over this data just select only the measurements variables related to the mean and standard deviation for each measurement also it get the columns regarding subject, activity. 

After that the activity variable observations are replaced by labels instead numbers in order to have a clear view about the meaning. The list of activities related to each number may be found at activity_labels.txt.
Some variables are renamed by removing characters as (, ), - will make more difficult work wit it over the script.


A second data frame is created, independent tidy data set with the average of each variable for each activity and each subject. 
This is get by groupping the data by variables subject and activity,ordering byt he same varaibles and later on summarising the data to get the average information per variable regarding subject and activity. This data are store in a data frame table named DF_tidy_act_sub.
