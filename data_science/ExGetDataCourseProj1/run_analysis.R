# converts integer activity id into activity name
# corresponding to UCI HAR Dataset/activity_labels.txt
convert_activity_id <- function(id) {
    if (id == 1) {
        "WALKING"
    }
    else if (id == 2) {
        "WALKING_UPSTAIRS"
    }
    else if (id == 3) {
        "WALKING_DOWNSTAIRS"
    }
    else if (id == 4) {
        "SITTING"
    }
    else if (id == 5) {
        "STANDING"
    }
    else if (id == 6) {
        "LAYING"
    }
    else {
        NA
    }
}


# return column classes to read data set with read.table
col_classes <- function() {
    c(rep("numeric", 6), #Time_body_acc
      rep("NULL", 34),
      rep("numeric", 6), #Time_gravity
      rep("NULL", 34),
      rep("numeric", 6), #Time_body_acc_jerk
      rep("NULL", 34),
      rep("numeric", 6), #Time_body_gyro
      rep("NULL", 34),
      rep("numeric", 6), #Time_body_gyro_jerk
      rep("NULL", 34),
      rep("numeric", 2), #Time_body_acc_mag
      rep("NULL", 11),
      rep("numeric", 2), #Time_gravity_acc_mag
      rep("NULL", 11),
      rep("numeric", 2), #Time_body_acc_jerk_mag
      rep("NULL", 11),
      rep("numeric", 2), #Time_body_gyro_mag
      rep("NULL", 24),
      rep("numeric", 6), #Freq_body_acc
      rep("NULL", 73),
      rep("numeric", 6), #Freq_body_acc_jerk
      rep("NULL", 73),
      rep("numeric", 6), #Freq_body_gyro
      rep("NULL", 73),
      rep("numeric", 2), #Freq_body_acc_mag
      rep("NULL", 11),
      rep("numeric", 2), #Freq_body_acc_jerk_mag
      rep("NULL", 11),
      rep("numeric", 2), #Freq_body_gyro_mag
      rep("NULL", 11),
      rep("numeric", 2), #Freq_body_body_gyro_jerk_mag
      rep("NULL", 18))
}


# variable column names of the result data table
variable_col_names <- function() {
    c("Time_body_acc_mean_X", "Time_body_acc_mean_Y", "Time_body_acc_mean_Z",
      "Time_body_acc_std_X", "Time_body_acc_std_Y", "Time_body_acc_std_Z",
      "Time_gravity_acc_mean_X", "Time_gravity_acc_mean_Y", "Time_gravity_acc_mean_Z",
      "Time_gravity_acc_std_X", "Time_gravity_acc_std_Y", "Time_gravity_acc_std_Z",
      "Time_body_acc_jerk_mean_X", "Time_body_acc_jerk_mean_Y", "Time_body_acc_jerk_mean_Z",
      "Time_body_acc_jerk_std_X", "Time_body_acc_jerk_std_Y", "Time_body_acc_jerk_std_Z",
      "Time_body_gyro_mean_X", "Time_body_gyro_mean_Y", "Time_body_gyro_mean_Z",
      "Time_body_gyro_std_X", "Time_body_gyro_std_Y", "Time_body_gyro_std_Z",
      "Time_body_gyro_jerk_mean_X", "Time_body_gyro_jerk_mean_Y", "Time_body_gyro_jerk_mean_Z",
      "Time_body_gyro_jerk_std_X", "Time_body_gyro_jerk_std_Y", "Time_body_gyro_jerk_std_Z",
      "Time_body_acc_mag_mean", "Time_body_acc_mag_std",
      "Time_gravity_acc_mag_mean", "Time_gravity_acc_mag_std",
      "Time_body_acc_jerk_mag_mean", "Time_body_acc_jerk_mag_std",
      "Time_body_gyro_mag_mean", "Time_body_gyro_mag_std",
      "Freq_body_acc_mean_X", "Freq_body_acc_mean_Y", "Freq_body_acc_mean_Y",
      "Freq_body_acc_std_X", "Freq_body_acc_std_Y", "Freq_body_acc_std_Z",
      "Freq_body_acc_jerk_mean_X", "Freq_body_acc_jerk_mean_Y", "Freq_body_acc_jerk_mean_Z",
      "Freq_body_acc_jerk_std_X", "Freq_body_acc_jerk_std_Y", "Freq_body_acc_jerk_std_Z",
      "Freq_body_gyro_mean_X", "Freq_body_gyro_mean_Y", "Freq_body_gyro_mean_Z",
      "Freq_body_gyro_std_X", "Freq_body_gyro_std_Y", "Freq_body_gyro_std_Z",
      "Freq_body_acc_mag_mean", "Freq_body_acc_mag_std",
      "Freq_body_acc_jerk_mag_mean", "Freq_body_acc_jerk_mag_std",
      "Freq_body_gyro_mag_mean", "Freq_body_gyro_mag_std",
      "Freq_body_body_gyro_jerk_mag_mean", "Freq_body_body_gyro_jerk_mag_std"
      )
}


# main function that do the job
run_analysis <- function() {
    library(data.table)
    
    # merge subject identifications from
    # - UCI HAR Dataset/train/subject_train.txt
    # - UCI HAR Dataset/test/subject_test.txt
    # into the dedicated data table
    train_subj_id <- fread("UCI HAR Dataset/train/subject_train.txt")
    test_subj_id <- fread("UCI HAR Dataset/test/subject_test.txt")
    DT_subj <- rbind(train_subj_id, test_subj_id)
    
    # merge activity labels from
    # - UCI HAR Dataset\train\y_train.txt
    # - UCI HAR Dataset\test\y_test.txt
    # replace integer values with activity names
    # create a dedicated data table eith activity names
    train_activity_id <- read.table("UCI HAR Dataset/train/y_train.txt", 
                                    col.names = c("Activity_ID"))
    test_activity_id <- read.table("UCI HAR Dataset/test/y_test.txt",
                                   col.names = c("Activity_ID"))
    DT_activity_id <- rbind(train_activity_id, test_activity_id)
    DT_activity <- data.table(sapply(DT_activity_id$Activity_ID, convert_activity_id))

    # merge data sets from
    # - UCI HAR Dataset\train\x_train.txt
    # - UCI HAR Dataset\test\x_test.txt
    # only mean and standard deviation values are extracted    
    colClasses <- col_classes()
    train_data_set <- read.table("UCI HAR Dataset/train/x_train.txt",
                                colClasses = colClasses)
    test_data_set <- read.table("UCI HAR Dataset/test/x_test.txt",
                                colClasses = colClasses)
    DT_dataset <- rbind(train_data_set, test_data_set)
    
    # merge subject, activity and data set into the result 
    # data table and save it on the disc
    DT <- cbind(DT_subj, DT_activity, DT_dataset)
    variableColNames = variable_col_names()
    setnames(DT, c("Subject_ID", "Activity", variableColNames))
    write.table(DT, "result_set.txt", row.names = FALSE)
    
    # create a dataset with average values of each variable 
    # for each activity and each subject
    DT_mean <- DT[, lapply(.SD, mean), 
                  by = list(Subject_ID, Activity), 
                  .SDcols = variableColNames]
    
    # remove duplicated records
    DT_mean <- unique(DT_mean)
    
    # rename columns of variables to be ended with "_mean"
    variableColNamesMean <- c()
    for (name in variableColNames) {
        name <- paste(name, "mean", sep = "_")
        variableColNamesMean <- c(variableColNamesMean, name)
    }
    setnames(DT_mean, c("Subject_ID", "Activity", variableColNamesMean))
    
    # save the data table with means in the disc
    write.table(DT_mean, "result_set_mean.txt", row.names = FALSE)
    DT_mean
}