## This script will grab data from one locatioin and merge it
## together to create one tidy dataset

## reading data into objects, assumes all datasets are in one
## wording directory
SubTest <- read.table("subject_test.txt")
xTest <- read.table("X_test.txt")
yTest <- read.table("y_test.txt")
SubTrain <- read.table("subject_train.txt")
xTrain <- read.table("X_train.txt")
yTrain <- read.table("Y_train.txt")

## Step 1 says merge training and test data sets into one dataset
## this actually gives us 3 datasets: one for subjects(sub),
## one for result variables (x), and one for activity labels (y)
subjects <- rbind(SubTest,SubTrain)
results <- rbind(xTest,xTrain)
activities <- rbind(yTest,yTrain)

## for my own best pratice I remove the initial objects 
rm(SubTest,xTest,yTest,SubTrain,xTrain,yTrain)

## Step 2 says to extract measurements for only the mean and standard
## deviation for each measurement. Because the row and columns match from
## features.txt to results we can create a vector of rows to act as our
## subsetting columns in the results data
features <- read.table("features.txt")
## creates the vector of indicies where mean or std are present
goodcolumns <- grep("-mean\\(\\)|-std\\(\\)",features[,2])
results <- results[,goodcolumns]
names(results) <- features[goodcolumns,2]

## Step 3 says to use descriptive activity names which means replace
## or add the name from activity_labels to the activities dataset 
## (originally Y) where the numbers matched
names(activities) <- "ActivityId"
act_labels <- read.table("activity_labels.txt", as.is = TRUE, col.names = c("ActivityId", "ActivityName"))
activities <- join(activities,act_labels,by="ActivityId")
activities$ActivityName <- gsub("_","",activities$ActivityName)
activities$ActivityName <- tolower(as.character(activities$ActivityName))

## Steps 4 says the same thing as Step 3, I'm using this step to
## scrub the names of the results column names and create any missing 
## column names before binding and creating my first clean dataset
names(results) <- gsub("\\(|\\)","",names(results))
names(results) <- tolower(names(results))
names(subjects) <- "subject"
tidy_data1 <- cbind(subjects,activities,results)
write.table(tidy_data1,"tidy_data_MEASURES.txt")

## for the sake of memory we can now remove any uneeded objects
## rm(act_labels,features,results,subjects)

## Step 5 wants a subset of the larger data set that only consist of the
## average for each variable (columns 3 to 68) for each subject/activity 
library(data.table)
data <- data.table(tidy_data1)
tidy_data2 <- data[, lapply(.SD, mean), by=c("subject","ActivityName")]
tidy_data2 <- tidy_data2[order(tidy_data2$subject),]
write.table(tidy_data2,"tidy_data_FINAL.txt")
