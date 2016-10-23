library(dplyr)
library(tidyr)

# Step 1. Merges the training and the test sets to create one data set
# read the training set merging the subject and activity columns
train <- cbind(read.table('./train/subject_train.txt'),
               read.table('./train/y_train.txt'),
               read.table('./train/X_train.txt'))
# read the test set merging the subject and activity columns
test <- cbind(read.table('./test/subject_test.txt'),
              read.table('./test/y_test.txt'),
              read.table('./test/X_test.txt'))
# append test to train
full <- rbind(train, test)
# drop intermediate results
rm(train, test)

# Step2. Extracts only the measurements on the mean and standard deviation for each measurement
# attaches column names for subject and actibity and the rest from the features.text file
names(full) <- c("subject", "activity", read.table("features.txt", stringsAsFactors=FALSE)[,2])
# drop columns which do not contain 'mean()' or 'std()'
full <- full[, c(1, 2, grep("mean\\(\\)|std\\(\\)", names(full)))]

# STEP 3. Uses descriptive activity names to name the activities in the data set
# read activity labels file simultaneousely preparing for join
labels <- read.table('activity_labels.txt', col.names = c('activity', 'label'))
# join the labels
full <- left_join(full, labels)
# move the activity labels to second position while dropping activity numbers
full <- select(full, subject, activity=label, 3:ncol(full))

# Step 4. Appropriately labels the data set with descriptive variable names
# transform to narrow form - subject, activity, feature, value using tidyr 
tidy <- gather(full, 'feature', 'value', -(1:2))

# Step 5. From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject
# prepare for averaging
tidy <- tidy %>% group_by(subject, activity, feature)
# average
result <- summarise(tidy, avg = mean(value))

# write the result to the file to upload
write.table(result, file='UCI HAR Clean.txt', row.names = FALSE)
