# Download and unzip the data 
fileName <- "data.zip"
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,fileName, mode = "wb") 
unzip("data.zip", files = NULL, exdir=".")

# Install Reshape2 package for using melt and cast functions
if (!"reshape2" %in% installed.packages()) {
	install.packages("reshape2")
}
library("reshape2")

# Read the data into variables
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")  

# Merge the training and the test sets to create one data set.
merged_data <- rbind(x_train,x_test)

# Extract only the measurements on the mean and standard deviation for each measurement.
mean_std <- grep("mean()|std()", features[, 2]) 
merged_data <- merged_data[, mean_std]

# Appropriately label the data set with descriptive variable names.
descriptive_names <- sapply(features[, 2], function(x) {gsub("[()]", "",x)})
names(merged_data) <- descriptive_names[mean_std]

# Combine test and train data and subject, activity,mean and std data
subject <- rbind(subject_train, subject_test)
names(subject) <- 'subject'
activity <- rbind(y_train, y_test)
names(activity) <- 'activity'
merged_data <- cbind(subject, activity, merged_data)

# Use descriptive activity names to name the activities in the data set
activity_group <- factor(merged_data$activity)
levels(activity_group) <- activity_labels[,2]
merged_data$activity <- activity_group

# Create a second, independent tidy data set with the average of each variable for each activity and each subject.
initial_data <- melt(merged_data,(id.vars=c("subject","activity")))
final_data <- dcast(initial_data, subject + activity ~ variable, mean)
names(final_data)[-c(1:2)] <- paste("The mean of " , names(final_data)[-c(1:2)] )
write.table(final_data, "clean_data.txt", sep = ",", row.names = FALSE)

