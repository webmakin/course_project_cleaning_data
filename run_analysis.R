# install.packages("data.table")
# install.packages("dplyr")
library(data.table)
library(dplyr)

# download data
if(!file.exists('./data')){dir.create('./data')}
fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(fileUrl, destfile = './data/dataset.zip', method = 'curl')
unzip(zipfile = './data/dataset.zip', exdir = './data/')
folder <- './data/UCI HAR Dataset'

#Read databases in the folder
features <- read.table(paste0(folder,"/features.txt"), col.names = c("n","functions"))
activities <- read.table(paste0(folder,"/activity_labels.txt"), col.names = c("code", "activity"))
subject_test <- read.table(paste0(folder,"/test/subject_test.txt"), col.names = "subject")
x_test <- read.table(paste0(folder,"/test/X_test.txt"), col.names = features$functions)
y_test <- read.table(paste0(folder,"/test/y_test.txt"), col.names = "code")
subject_train <- read.table(paste0(folder,"/train/subject_train.txt"), col.names = "subject")
x_train <- read.table(paste0(folder,"/train/X_train.txt"), col.names = features$functions)
y_train <- read.table(paste0(folder,"/train/y_train.txt"), col.names = "code")


#Step 1
#Merges the training and the test sets to create one data set.
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
dataset <- cbind(subject, y, x)

#Step 2
#Extracts only the measurements on the mean and standard deviation for each measurement. 
data_set <- dataset %>% select(subject, code, contains("mean"), contains("std"))

#Step 3
#Uses descriptive activity names to name the activities in the data set
data_set$code <- activities[data_set$code, 2]

#Step 4
#Appropriately labels the data set with descriptive variable names. 
names(data_set)[2] = "activity"
names(data_set)<-gsub("Acc", "Accelerometer", names(data_set))
names(data_set)<-gsub("Gyro", "Gyroscope", names(data_set))
names(data_set)<-gsub("BodyBody", "Body", names(data_set))
names(data_set)<-gsub("Mag", "Magnitude", names(data_set))
names(data_set)<-gsub("^t", "Time", names(data_set))
names(data_set)<-gsub("^f", "Frequency", names(data_set))
names(data_set)<-gsub("tBody", "TimeBody", names(data_set))
names(data_set)<-gsub("-mean()", "Mean", names(data_set), ignore.case = TRUE)
names(data_set)<-gsub("-std()", "StandardDeviation", names(data_set), ignore.case = TRUE)
names(data_set)<-gsub("-freq()", "Frequency", names(data_set), ignore.case = TRUE)
names(data_set)<-gsub(".std.", "StandardDeviation", names(data_set), ignore.case = TRUE)
names(data_set)<-gsub("Freq", "Frequency", names(data_set), ignore.case = TRUE)
names(data_set)<-gsub("angle", "Angle", names(data_set))
names(data_set)<-gsub("gravity", "Gravity", names(data_set))

#Step 5
#From the data set in step 4, creates a second, independent tidy data set with the 
#average of each variable for each activity and each subject.
grouped <- group_by(data_set, activity, subject)
tidydataset <- summarise_all(grouped, mean)
write.table(tidydataset, "tidydataset.txt", row.name=FALSE)

