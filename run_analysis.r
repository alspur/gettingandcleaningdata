# run_analysis.r

#load test data
x.test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y.test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject.test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#load train data
x.train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y.train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject.train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#merge test and train data using rbind
x.master <- rbind(x.test, x.train)
y.master <- rbind(y.test, y.train)
subject.master <- rbind(subject.test, subject.train)

#read in feature names
features <- read.table("./UCI HAR Dataset/features.txt")

#apply feature names to column names in x.master
colnames(x.master) <- features$V2

#change column name in y.master to "activity"
colnames(y.master) <- "activity"

#create descriptive labels for activities
y.master$activity <- factor(y.master$activity, levels = c(1,2,3,4,5,6),
                            labels = c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting",
                                                             "Standing", "Laying"))
#change subject.master column name
colnames(subject.master) <- "subject.id"

#join datasets by column
motion.data <- cbind(subject.master, y.master, x.master)

# load stringr and reshape2 packages
library(stringr)
library(reshape2)

# reshape data into a long format using the melt function
# new column "variable" will contian the various features and "value" will contain their observed value
motion.melt <- melt(motion.data, id = c("subject.id", "activity"))

# create an index of all observations that contain "mean()" in the variable column 
mean.idx <- grep("mean()", motion.melt$variable)
# extract all obserbations that contain "mean()" using mean.idx
motion.means <- motion.melt[mean.idx,]

# create an index of all observations that contain "std()" in the variable column 
std.idx <- grep("std()", motion.melt$variable)
# extract all obserbations that contain "std()" using std.idx
motion.std <- motion.melt[std.idx,]

motion.filtered <- rbind(motion.means, motion.std)
# Appropriately labels the data set with descriptive activity names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# load dplyr package
library(dplyr)

# summarise data by subject and activity

motion.summary <- motion.filtered %.%
    select(subject.id, activity, variable, value) %.%
    group_by(subject.id, activity, variable) %.%
    summarise(average = mean(value, na.rm = TRUE)) %.%
    arrange(subject.id, activity, variable)

# save summary as csv file

write.table(motion.summary, "tidyData.csv")
