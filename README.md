# Getting-and-Cleaning-Data-Course-Project
This script merges and cleans up two distinct data sets (train and test) within the 
Human Activity Recognition Using Smartphones Dataset. 

The following packages are used in this script: data.table and dplyr. Make sure they are installed before proceeding
In all read() commands, make sure the file path entered matches the path to your working directory. If you receive a 
file does not exist error, check to make sure the file path inputted is correct.

I completed the assignment in 9 basic steps:
  (1.) Read the train data 
  (2.) Create column names by reading in the features data, 
      convert that data into a character string, and merge it onto the train data 
  (3.) Delete duplicate columns
  (4.) Select only those columns pertaining to mean and standard deviation measurements
  (5.) Read the activity and subject labels, and bind them onto the train data 
  (6.) Repeat steps 1-4 for the test data
  (7.) Merge the train and test data into the long form 
  (8.) Label the activity indicators with descriptive names
  (9.) Create a second, tidy data set with the average of each variable for each activity and each subject
  
The resulting data frame in step 8 contains 88 columns: a column indicating the subject number, a column indicating
the activity, and 86 columns of measurements. there are 10,299 observations. The second data frame created in step 9 is 
grouped first by subject and then by activity, and the average was calculated for each measurement per activity, per
subject. The resulting data frame has 180 observations across 88 columns (again, a column for subject and activity,
followed by 86 columns for the means of each of the measurements). 
