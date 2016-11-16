# Course project goals
# 1 Merges the training and the test sets to create one data set.
# 2 Extracts only the measurements on the mean and standard deviation for each measurement.
# 3 Uses descriptive activity names to name the activities in the data set
# 4 Appropriately labels the data set with descriptive variable names.
# 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
#   for each activity and each subject.

library(dplyr)

source("clean_features.R")


# Loading definitions, add correct columns name
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("activityId", "activityName"), stringsAsFactors = F)
features_labels <- read.table("./UCI HAR Dataset/features.txt", col.names = c("featureId", "featureName"), stringsAsFactors = F)

# Convert featureName to make all the content syntactically valid for read.table
features_names <- makeFeaturesHumanReadable(features_labels$featureName)

# Loading datas, directly named labels file with one column to avoid manipulation issues with default naming (V1, V2...)
# GOAL 4 features_names contains the name corresponding to each column of *_data
# Note that some values in features_names are equals, R will add .1 to the second occurence, .2 to the third one...
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features_names)
test_labels <-  read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c("activityId"))
test_subjects <-  read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c("subjectId"))
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features_names)
train_labels <-  read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c("activityId"))
train_subjects <-  read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c("subjectId"))

# Bind columns from *_data & *_labels
# *_labels contains the labels numbers (each number match an entry from activity_labels)
test_data <- cbind(test_labels, test_data)
train_data <- cbind(train_labels, train_data)

# Bind columns from *_data & *_subjects
# *_subjects contains the subjects numbers
test_data <- cbind(test_subjects, test_data)
train_data <- cbind(train_subjects, train_data)

# GOAL 1 Bind the training and the test sets
data <- rbind(test_data, train_data)

# GOAL 3 Merge activity_labels with data to get the Activity Name for each rows in the data frame
data <- merge(activity_labels, data, by = "activityId")

# GOAL 2 only keep columns that contain "Mean" or "StandardDeviation" inside their header
# Also keep Activities columns, grep with value = T to get the text values and not the indices
data <- data[, c("activityName", "subjectId", grep("Mean|StandardDeviation", names(data), value = T))]

# GOAL 5 Using dplyr, group the data by activity and subject = 6 * 30 = 180 rows and summarize each other columns with mean
data_tidy <- data %>% group_by(activityName, subjectId) %>% summarize_each(funs(mean))

write.table(data_tidy, file = "tidyData.txt", row.names = F)
