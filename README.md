# Course project: Getting and Cleaning Data

## How to run

### Files
1. run_analysis.R - data retrieval and cleaning script
2. tidydataset.txt - result dataset after running the script
3. codebooks.md - description of output data

### Steps
1. Open the project in R studio and source the run_analysis.R file
2. tidydataset.txt should be created 

### Verify
1. tab <- read.table('tidydataset.txt')
2. str(tab) should show number of observations and variables
3. head(tab) should show the column names which have been cleaned

## Objective: You should create one R script called run_analysis.R that does the following.

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.