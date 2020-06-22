# GettingAndCleaningData
The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The R Script "run_analysis.R" does the following - 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Working of the R Script - run_analysis.R
The R script - run_analysis.R, performs the above 5 mentioned tasks.

0. Setting up -
   - Download and unzip the data
   - Read the training, testing, feature and activity data.
1. Merging -
   - Merge the testing and training data.
   - Assign names to the columns.
   - Merge the "subject", "X", "Y" datasets into the "mergedData" dataset.
2. Subsetting - 
   - Subset to get data only for means and standard deviations.
   - "mergedData" dataset is assigned the variables for subject_ID, activity_ID, and the variables for the mean and standard deviations.
3. Describing activity names - 
   - Assign proper activity labels to the corresponding activity_IDs.
   - Change the column header to "activity"
4. Appropriate labeling and describing variable names -
   - Labels to subject and activity columns have already been applied in the previous steps. 
   - Assign descriptive labels to the remaining columns, expand abbreviations and capitalize labels for consistency using the gsub function.
5. Creating the final tidy dataset -
   - The "mergedData" dataset is grouped according to "subject_ID", and "activity".
   - All the variables of the grouped data are then summarized - mean is taken, using the summarize_all function.
   - The grouped and summarized data is then assigned to the new dataset called "tidyData".
   - The new tidy dataset - "tidyData", is then written to a txt file - "tidyData.txt".
