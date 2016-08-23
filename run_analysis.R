library(dplyr)

#reading of files
activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")
subject_test <- read.table("subject_test.txt")
subject_train <- read.table("subject_train.txt")
X_test <- read.table("X_test.txt")
X_train <- read.table("X_train.txt")
y_test <- read.table("y_test.txt")
y_train <- read.table("y_train.txt")

#Merges the training and the test sets to create one data set.
data_test <- cbind(y_test,X_test)
data_train <- cbind(y_train,X_train)
data <- rbind(data_test,data_train)
names(data) <- c("activity_id", as.character(features$V2))

#Extracts only the measurements on the mean and standard deviation 
# for each measurement.
columns <- sort(c(1,union(grep("mean",names(data)), grep("std",names(data)))))
data <- data[, columns]

#Uses descriptive activity names to name the activities in the data set
names(activity_labels) <- c("activity_id","activity_name")
data <- merge(activity_labels, data, by="activity_id")

#Appropriately labels the data set with descriptive variable names.
data <- data[,2:(length(names(data))-1)]

#From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.
data_gpr <- summarise_each(group_by(data, activity_name), funs(mean))
write.table(data_gpr,file="tidy_dataset.txt",row.name=FALSE)
