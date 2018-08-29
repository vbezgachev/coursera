## Description
The repository contains one script file "run_analysis.R" that implement 
tasks from "Getting and Cleaning Data Course Project 1", code book CodeBook.md,
full result data set "result_set.txt", requested tidy result data set 
"result_set_mean.txt" and this read me file.

The following source data set is used:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

A full description is available here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

To run the script please extract the data set into a directory where you have "run_analysis.R" script.
Let say you have a folder "C:\Coursera\Getting and Cleaning Data\CourseProj1". 
Then you have to have the following structure in it:
- run_analysis.R
- UCI HAR Dataset
  - activity_labels.txt
  - features.txt
  - features_info.txt
  - README.txt
  - test
    - subject_test.txt
    - X_test.txt
    - y_test.txt
    - Inertial Signals
  - train
    - subject_train.txt
    - X_train.txt
    - y_train.txt
    - Inertial Signals
    
To run the script, start R console, change working directory to "C:\Coursera\Getting and Cleaning Data\CourseProj1"
Type "source("run_analysis.R")" and "DT_mean <- run_analysis()".
The tidy data set with the average of each variable for each activity and each subject is returned.

The function do the following:
<ol>
<li>Read train and test subject files "UCI HAR Dataset/train/subject_train.txt" and "UCI HAR Dataset/test/subject_test.txt"</li>
<li>Merge subjects with rbind into subject data table</li>
<li>Read train and test activity ID files "UCI HAR Dataset/train/y_train.txt" and "UCI HAR Dataset/test/y_test.txt"</li>
<li>Merge activities with rbind into activity ID data table</li>
<li>Convert activity IDs into activity names and create activity data table with the names</li>
<li>Read mean and standard deviation variables from "UCI HAR Dataset/train/x_train.txt" and "UCI HAR Dataset/test/x_test.txt"
    read.table is used. colClasses parameter is used to extract only needed variables from data files.
    Type in R console "?read.table" to explore more about the function and the colClasses parameter</li>
<li>Merge extracted variables with rbind into the data table</li>
<li>Merge subject (2), activity (5) and variables (7) data tables into one result data table</li>
<li>Set descriptive column names in the result data table (8)</li>
<li>Save the result data table (9) into "result_set.txt"</li>
<li>Create tidy data set with the average of each variable for each activity and each subject.
    mean() is called on variable columns (with lapply) and a data table is created.
    Now we have a lot of duplicated rows with subject ID, activity and a mean value.
    Call unique() on this data table. As a result we have the desired tidy data table without duplicates</li>
<li>Set descriptive column names for the data table (11)</li>
<li>Save the tidy data table (12) into "result_set_mean.txt"</li>
</ol>

After running the script you will have "result_set.txt" (full result data set) and 
"result_set_mean.txt" (tidy result data set) in your working directory.
