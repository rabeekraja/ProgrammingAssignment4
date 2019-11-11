#This R script does following steps
#Step #1:Merges the training and the test sets to create one data set.

#Step #2:Extracts only the measurements on the mean and standard deviation for each measurement.

# Step #3:Appropriately labels the data set with descriptive variable names.

#Step #4 :Uses descriptive activity names to name the activities in the data set


#Step #5:From the data set in step 4, creates a second, independent tidy data set with the 
#average of each variable for each activity and each subject.

# Set current working directory
setwd("C:/rlib")
#Load Libraries
# check if plyr package is installed
if (!"plyr" %in% installed.packages()) {
  install.packages("plyr")
}

library(plyr)
## Data download and unzip 
# fileName to store in local drive
fileN <- "UCIDataSets.zip"
# URL to download zip file data
dataUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# Directory/folder name that datasets available
dir <- "UCI HAR Dataset"
extract_data <- function(fileName,url,dirName) {
# Check if file is already downloaded or copied -if not download.
#The choice of binary transfer (mode = "wb" or "ab") is important on Windows, 
#since unlike Unix-alikes it does distinguish between text and binary files 
#and for text transfers changes \n line endings to \r\n (aka ‘CRLF’).
# added mode of wb (binary)
if(!file.exists(fileName)){
  download.file(url,fileName, mode = "wb")
}

# Verify already files are extracted otherwise unzip.
if(!file.exists(dirName)){
  unzip(fileName, files = NULL, exdir=".")
}

}
#Call function extract data
extract_data(fileN,dataUrl,dir)

##Data Reading
#Read test text Data into variables
subject_test_data <- read.table("UCI HAR Dataset/test/subject_test.txt")
#print(count(subject_test_data))
X_test_data <- read.table("UCI HAR Dataset/test/X_test.txt")
#print(count(X_test_data))
y_test_data <- read.table("UCI HAR Dataset/test/y_test.txt")
#print(count(y_test_data))
#Read training text Data into variables
subject_train_data <- read.table("UCI HAR Dataset/train/subject_train.txt")
#print(count(subject_train_data))
X_train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
#print(count(X_train_data))
y_train_data <- read.table("UCI HAR Dataset/train/y_train.txt")
#print(count(y_train_data))
#Read labels text Data into variable
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
#print(count(activity_labels))
# Read features
features <- read.table("UCI HAR Dataset/features.txt")  
#print(count(features))
## Data Analysis Steps
# Step 1. Merge test & training data into single set.
#rbind here to append all the rows from test and all rows from training 
# datasets into single set.
mergedDataSet <- rbind(X_train_data,X_test_data)

# Step 2. Extract Mean & Standard Deviation measurements. 
#  vector of mean,std data.
#mean_Std_Vector <- grep("mean()|std()", features[, 2]) 
mean_Std_Vector <-grep("mean\\(\\)|std\\(\\)", features[, 2])
#print(mean_Std_Vector)
mergedDataSet <- mergedDataSet[,mean_Std_Vector]



# 3. Label  data set with proper activity names.
#  Create features without () by using global replace.
replacedFeatureName <- sapply(features[, 2], function(x) {gsub("[()]", "",x)})
names(mergedDataSet) <- replacedFeatureName[mean_Std_Vector]


# combine test and train of subject data and activity data, give descriptive lables
subject <- rbind(subject_train_data, subject_test_data)
names(subject) <- 'subject'
activity <- rbind(y_train_data, y_test_data)
names(activity) <- 'activity'

# combine subjects, activities, and sub data set to create final data set.
mergedDataSet <- cbind(subject,activity, mergedDataSet)


# 4. Uses descriptive activity names to name the activities in the data set
# group the activity column of dataSet and rename.
activity_group <- factor(mergedDataSet$activity)
levels(activity_group) <- activity_labels[,2]
mergedDataSet$activity <- activity_group

names(mergedDataSet)<-gsub("^t", "Time", names(mergedDataSet))
names(mergedDataSet)<-gsub("^f", "Frequency", names(mergedDataSet))
names(mergedDataSet)<-gsub("Acc", "Accelerometer", names(mergedDataSet))
names(mergedDataSet)<-gsub("Gyro", "Gyroscope", names(mergedDataSet))
names(mergedDataSet)<-gsub("Mag", "Magnitude", names(mergedDataSet))
names(mergedDataSet)<-gsub("BodyBody", "Body", names(mergedDataSet))
names(mergedDataSet)<-gsub("[()]", "", names(mergedDataSet))

# 5. tidy data set with the average of each variable. 
# gather data for subjects, activities. 


finalData <- aggregate(. ~subject + activity, mergedDataSet, mean)
finalData <- tidydata[order(tidydata$subject, tidydata$activity),]
#print(finalData)

# write the tidy data to the current directory as "tidied_final_data.txt"
write.table(finalData, "tidied_final_data.txt", sep = ",",row.names = FALSE)
write.csv(finalData, "tidy_final_data.csv", row.names=FALSE)