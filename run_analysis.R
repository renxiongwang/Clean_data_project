#Read the data
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
features <- read.table("UCI HAR Dataset/features.txt")
activity <- read.table("UCI HAR Dataset/activity_labels.txt")

#Transfer the label
y_test <- activity[t(y_test),2]
y_train <- activity[t(y_train),2]

#combine the label and data
X_test <- cbind(y_test, X_test)
X_train <- cbind(y_train, X_train)

#merge
merge <-merge(X_test, X_train, by = intersect(names(X_test), names(X_train)), all = TRUE)

#get the names
names <- t(features[, 2])

#name the columns and rows
colnames(merge) <- c("features", as.character(names))

#Select mean and std
result <- merge[ , c(grep("mean", names), grep("std", names))]
#save as txt
write.table(result, file = "result.txt", row.names = FALSE)
