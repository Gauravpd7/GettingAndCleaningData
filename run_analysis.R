# Downloading and unzipping.
if(!file.exists("./data")){
        dir.create("./data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,"./data/dataset.zip")
unzip("./data/dataset.zip",exdir="./data")

# Loading the datasets.
features <- read.table("./data/UCI HAR Dataset/features.txt")
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")


# 1.Merging the training and test sets into a single dataset called "mergedData"mergedData".
X <- rbind(x_test,x_train)
Y <- rbind(y_test,y_train)
subject <- rbind(subject_test,subject_train)
colnames(subject) <- "subject_ID"
colnames(Y) <- "activity_ID"
colnames(X) <- features[,2]
mergedData <- cbind(subject,Y,X)

# 2.Subsetting to get data only for means and standard deviations.
mergedData <- mergedData %>% select(subject_ID,activity_ID,contains("mean"),contains("std"))

# 3.Applying descriptive activity labels.
mergedData$activity_ID <- activities[mergedData$activity_ID,2]
names(mergedData)[2] <- "activity"

# 4. Labeling the data set with descriptive variable names.
# Labels to subject and activity columns have already been applied in the previous steps. 
names(mergedData)<-gsub("^t", "Time", names(mergedData))
names(mergedData)<-gsub("^f", "Frequency", names(mergedData))
names(mergedData)<-gsub("-mean()", "Mean", names(mergedData))
names(mergedData)<-gsub("-std()", "STD", names(mergedData))
names(mergedData)<-gsub("-freq()", "Frequency", names(mergedData))
names(mergedData)<-gsub("angle", "Angle", names(mergedData))
names(mergedData)<-gsub("gravity", "Gravity", names(mergedData))
names(mergedData)<-gsub("tBody", "TimeBody", names(mergedData))
names(mergedData)<-gsub("Acc", "Accelerometer", names(mergedData))
names(mergedData)<-gsub("Gyro", "Gyroscope", names(mergedData))
names(mergedData)<-gsub("Mag", "Magnitude", names(mergedData))

#5 Creating a second tidy dataset with average of each variable for each activity and each subject
tidyData <- mergedData %>%
        group_by(subject_ID,activity) %>%
        summarise_all(mean)
# Writing the final tidy dataset to a txt file.
write.table(tidyData, "tidyData.txt", row.name=FALSE)
