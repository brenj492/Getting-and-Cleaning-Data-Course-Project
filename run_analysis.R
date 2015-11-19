## This script cleans up and organizes the train and test data for the 
## Samsung Human Activity Recognition study by doing the following:
## 1.Reading the train data into tbl_df() for dplyr manipulation
## 2.Creating column names by reading in the features data, 
##     converting that data into a character string, and merging it onto the train data 
## 3.Deleting duplicate columns
## 4.Selecting only those columns pertaining to mean and standard deviation measurements
## 5.Reading the activity and subject labels, and binding them onto the train data 
## 6.Repeating steps 1-4 for the test data
## 7.Merging the train and test data into the long form
## 8.Labeling the activity indicators with descriptive names
## 9.Creating a second, tidy data set with the average of each variable for each activity and each subject


## Step 1: reading the X_train data into a format compatible with dplyr
## the data first must be read into a data table. fread() is faster than read.table

library(data.table)
library(dplyr)
train.data <- fread("./UCI HAR Dataset/train/X_train.txt")
train.DF <- tbl_df(train.data)

## Step 2: Creating column names
## again, I read the features text document with fread(), 
## and then converted it into a character vector and used that vector for variable names

features <- fread("./UCI HAR Dataset/features.txt")
colnames <- c(features$V2)
names(train.DF) <- colnames

## Step 3: Deleting duplicate columns
## I will not be able to use dplyr tools such as select until duplicate columns are eliminated

train.DF <- train.DF[, !duplicated(colnames(train.DF))]

## STep 4: Extracting mean and std measurements

train.DF <- select(train.DF, contains("mean"), contains("std"))

## Step 5: Reading activity and subject labels, and binding them onto the train.DF data

act.train <- fread("./UCI HAR Dataset/train/y_train.txt")
names(act.train) <- "Activity"
subject.train <- fread("./UCI HAR Dataset/train/subject_train.txt")
names(subject.train) <- "Subject"
train.DF <- bind_cols(subject.train, act.train, train.DF)

## Step 6: Repeat steps 1-5 with the test dataset

test.data <- fread("./UCI HAR Dataset/test/X_test.txt")
test.DF <- tbl_df(test.data)
act.test <- fread("./UCI HAR Dataset/test/y_test.txt")
names(act.test) <- "Activity"
subject.test <- fread("./UCI HAR Dataset/test/subject_test.txt")
names(subject.test) <- "Subject"
names(test.DF) <- colnames
test.DF <- test.DF[, !duplicated(colnames(test.DF))]
test.DF <- select(test.DF, contains("mean"), contains("std"))
test.DF <- bind_cols(subject.test, act.test, test.DF) 

## Step 7: Merging the two data frames
## because the number of obs, the subjects, and the activities performed to not precisely match up, 
## I decided it was best to merge the two data sets the long way by rbinding them

full.data <- bind_rows(train.DF, test.DF)
full.DF <- tbl_df(full.data)

## Step 8: Labeling activity indicators with descriptive names
  
full.DF$Activity[full.DF$Activity == 1] <- "1_Walking"
full.DF$Activity[full.DF$Activity == 2] <- "2_Walking_Upstairs"
full.DF$Activity[full.DF$Activity == 3] <- "3_Walking_Downstairs"
full.DF$Activity[full.DF$Activity == 4] <- "4_Sitting"
full.DF$Activity[full.DF$Activity == 5] <- "5_Standing"
full.DF$Activity[full.DF$Activity == 6] <- "6_Laying"
full.DF

## Step 9: Creating a second, tidy data table with averages for each variable of each activity of each subject

summary.DF <- full.DF %>%
              group_by(Subject, Activity) %>%
              summarize_each(funs(mean)) %>%
              print
              
  
write.table(summary.DF, file = "tidy data course project table.txt", row.names = FALSE)

## to see the first 6 lines of the table, use head(read.table("./tidy data course project table.txt", header = TRUE)) 
