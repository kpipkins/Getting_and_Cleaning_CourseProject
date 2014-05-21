Code Book for Getting and Cleaning Data Course Project
======================================================
## Resources
The data for this analysis can be downloaded <a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" title="Data Link">here</a>. For information about the files contained within this zip folder please go to the <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">UCI Repository</a>.

## Summary
This data represents an experiment that tracked 6 types of activities (such as walking, laying down, etc) for 30 volunteers (referred to as subjects). The results were collected using a smartphone. The results data has 561 columns in it. A complete data set for all results, the activitiy code and the subject would be 10299 rows and 563 columns. The names for the activities and 561 columns are contained in separate files. This exercise takes the disparate files below and pulls them together before subsetting and performing a calculation.

## Source Data
For the purpose of this analysis we are downloading 8 files from the dataset. 
- *subject_test.txt* numeric value for 30% of subjects in the test data
- *subject_train.txt* numeric value for 70% of subjects in the training data
- *X_test.txt* measurement variables for 30% of the 561 results
- *X_train.txt* measurement variables for 70% of the 561 results
- *Y_test.txt* activity code for 30% of the records
- *Y_train.txt* activity code for 70% of the records
- *featurs.txt* labels for the 561 measurement variables (used for column headers)
- *activity_labels.txt* labels for the activity codes in the 'Y' datasets (used to replace the code with description)

## Transformations
1. Read in the data
2. Bind Subjects, X and Y into complete records
3. Replace the Y activity codes with real labels
4. Scrub all measure column headers to remove parenthesis, forward slashes, etc and convert to lowercase
5. Rename column headers for subject and activity
6. Subset for just the mean and standard deviation columns
7. Bind the three good data sets for Subjects, Activities, and Measure Results together
8. Write the data out to a file
9. Create new object that calculates the mean for every subject, activity combination
10. Write the data out to a file

## Resulting Data
As a result of our analysis we create two files
- *tidy_data_MEASURES.txt* consist of 10299 rows (all records) and 68 columns (subject, activityid, activityname, and 66 mean and standard deviation columns from the measurement variables)
- *tidy_data_FINAL.txt* consist of 180 rows (each subject/activity combination) for 69 columns (subject, activityid, activityname, and 66 averages of the mean and standard deviation values) 

## Variables in Resulting Data
- *subject* is the number of the subject for the original X data sets
- *activities* is the name of the activity in place of the activity code in the original Y data sets
- *measure results* "t" denotes time, "f" denotes frequency; "mean" denotes the average, "std" denotes standard deviation, "x","y","z" denote the 3 axial signal directions, the larger description (for example: bodyaccjerk) refers to acceleration, gyroscope, jerk or magnitude as set of different caluclations. Please see the *features_info.txt* for more details on these variables.
