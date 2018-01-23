Code Book
==========

# Download and unzip the data 
* download the data into file data.zip
* unzip the contents of data.zip into a folder UCI HAR Dataset

# Install Reshape2 package for using melt and cast functions
* check whether reshape2 package has already been installed
* if not, then install it

# Read the data into variables
* read subject_text, subject_train, x_test, x_train, y_test, y_train, activity_labels and features
* data into variables with same names 

# Merge the training and the test sets to create one data set.
* merge datasets x_train and x_data into a variable named merged_data

# Extract only the measurements on the mean and standard deviation for each measurement.
* use grep to get only the mean and standard deviation of measurements and store into mean_std variable
* set merged_data variable to contain only the mean and standard deviation of measurements

# Appropriately label the data set with descriptive variable names.
* use sapply to apply gsub function on the features dataset to have descriptive names

# Combine test and train data and subject, activity,mean and std data
* combine subject_train and subject_test datasets with rbind to a dataset named subject
* use rbind also to combine y_train and y_test datasets into dataset named activity
* use cbind to combine subject, activity and merged_data together

# Use descriptive activity names to name the activities in the data set
* assign activity column of merged_data dataset descriptive activity labels

# Create a second, independent tidy data set with the average of each variable for each activity and each subject.
* create a table named final_data from the subject and activity mean data
* give descriptive names for the columns of the table
* write the table to a file "clean_data.txt"

