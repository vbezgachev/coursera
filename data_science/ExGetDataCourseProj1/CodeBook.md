## Introduction
The following source data set has been used for the "Getting and Cleaning Data Course Project 1":
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

A full description is available here of the data set can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Source data set
Description of the source data set is provided in following files:
- README.txt contains a general description
- features_info.txt contains detail description of measured/calculated variables
- activity_labels.txt contains activity names that were done by volunteers
- features.txt contains full list of processed variables

Data set itself is divided into train and test sets. Each set can be found under "train" and "test"
directories accordingly. Each directory has following files:
- subject_<...>.txt contains volunteer ID per record. Valid IDs are 1 to 30
- y_<...>.txt contains Activity ID per record. Valid IDs are 1 to 6. 
  Corresponding activity names can be found in activity_labels.txt
- x_<...>.txt contains processed variables per record. 
  Each record has 561 values that have been measured and post-processed.
  Post-processing is described in features_info.txt.
- Subdirectory "Inertial Signals" contains files with original unprocessed values.
  Those files are not used in this project.

## Measured and processed variables
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using 
a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. 
Similarly, the acceleration signal was then separated into body and gravity acceleration signals 
(tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals 
(tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated 
using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, 
fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 
mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. 
These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

## Full result data set
The full result data set has following columns:
- Subject_ID: volunteer ID that is taken from subject_<...>.txt of a source data set
- Activity: activity name. Activity ID is taken from y_<...>.txt of a source data set
  and then converted into text using the mapping provided by activity_labels.txt
- 64 columns for variables. The name of each column reflects the name of a signal 
  from the source data set and a calculated value, i.e. "mean" or "std".
  For example "Time_body_acc_mean_X" is a body acceleration mean value along X direction from a time domain signals.
  And "Freq_body_acc_mean_X" is a body acceleration mean value along X direction from a frequency domain signals.
  
The data from train and test source data sets have been merged into the full result data set.
Only mean and standard deviation values of variables have been put into result data set.
No angles have been taken.

## Tidy result data set
The tidy result data set is calculated from the full result data set to contain the average of each variable 
for each activity and each volunteer. 
Consequently the tidy result data set is much smaller and has only 180 records: 30 volunteers X 6 activities.
The columns of a tidy data set are:
- Subject_ID: volunteer ID that is taken from subject_<...>.txt of a source data set
- Activity: activity name. Activity ID is taken from y_<...>.txt of a source data set
  and then converted into text used mapping provided by activity_labels.txt
- 64 columns for variables. The name of each column reflects the name of a signal 
  from the source data set and measured value, i.e. "mean" or "std". Plus all columns
  have a suffix "_mean" to indicated containing of an average value.
  For example "Time_body_acc_mean_X_mean", "Freq_body_acc_mean_X_mean".
