# CodeBook

## Information about the datasets - 
1. features.txt - List of all features.
2. activity_labels.txt - Links the class labels with their activity name.
3. X_train.txt - Training set.
4. y_train.txt - Training labels.
5. X_test.txt - Test set.
6. y_test.txt - Test labels.
7. subject_train.txt - Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

## R Script - run_analysis.R - 
  The R Script "run_analysis.R" performs the five tasks assigned in this project for creation of the tidy dataset, for details about the working of the R Script refer to "README.md".
  
  ## Data Transformations - 
  1. The datasets are read into R as follows - 
     - features <- read.table("./data/UCI HAR Dataset/features.txt")
     - activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
     - subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
     - x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
     - y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
     - subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
     - x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
     - y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
  2. Merging the training and test datasets into a single dataset - 
     - The rows of the x_test, x_train datasets are merged into a single dataset X using the rbind() function.
     - The rows of the y_test, y_train datasets are merged into a single dataset Y using the rbind() function.
     - The rows of the subject_test, subject_train datasets are merged into a single dataset- subject, using the rbind() function.
     - Respective column names are assigned.
     - The subject, Y, X datasets are merged into a single dataset- mergedData, using the cbind() function.
  3. Subsetting the merged data -
     - The mergedData dataset is subsetted to contain columns for subject_ID, activity_ID and mean and standard deviation data, this is done using the select() function, the resultant dataset is assigned to mergedData itself.
  4. Applying descriptive activity labels - 
     - Descriptive labels from the activities dataset are applied to the mergedData dataset as follows - 
     - mergedData$activity_ID <- activities[mergedData$activity_ID,2]
     - Column header for activity_ID is changed to activity.
  5. Labeling the dataset with descriptive variable names, the variable names have been modified as follows - 
     - names(mergedData)<-gsub("^t", "Time", names(mergedData))
     - names(mergedData)<-gsub("^f", "Frequency", names(mergedData))
     - names(mergedData)<-gsub("-mean()", "Mean", names(mergedData))
     - names(mergedData)<-gsub("-std()", "STD", names(mergedData))
     - names(mergedData)<-gsub("-freq()", "Frequency", names(mergedData))
     - names(mergedData)<-gsub("angle", "Angle", names(mergedData))
     - names(mergedData)<-gsub("gravity", "Gravity", names(mergedData))
     - names(mergedData)<-gsub("tBody", "TimeBody", names(mergedData))
     - names(mergedData)<-gsub("Acc", "Accelerometer", names(mergedData))
     - names(mergedData)<-gsub("Gyro", "Gyroscope", names(mergedData))
     - names(mergedData)<-gsub("Mag", "Magnitude", names(mergedData))
  6. Creating a second tidy dataset and finishing up - 
     - The mergedData dataset is grouped according to subject_ID and activity using group_by() function
     - The variables for each group are summarized - mean is taken, using the summarize_all() function
     - The summarized dataset is assigned to new dataset called - tidyData
     - tidyData is written to a txt file called - tidyData.txt
     
## Variable descriptions for the final tidy dataset - 

1. subject_ID - Identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
2. activity   - Describes the activity that was performed, namely - WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING & LAYING.
3. Features - The rest of the columns contain the mean and standard deviation related values that were collected for the various features listed in the features dataset.
