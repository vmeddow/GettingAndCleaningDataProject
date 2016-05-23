library(reshape2)

## Set working directory to UCI HAR Dataset before running this script


## Load activity labels
activityLabels <- read.table("activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])

## Load features
features <- read.table("features.txt")
features[,2] <- as.character(features[,2])

## Get only the measurements dealing with mean and standard deviation
## I decided to get any column with "mean" or "std" anywhere in the name, rather than just on the end
featuresSubset <- grep(".*mean.*|.*std.*", features[,2])

## Rename some of the features
featuresSubset.names <- features[featuresSubset,2]
featuresSubset.names <- gsub('-mean', 'Mean', featuresSubset.names)
featuresSubset.names <- gsub('-std', 'StandardDeviation', featuresSubset.names)
featuresSubset.names <- gsub('tBodyAcc', 'timeBodyAccelerometer', featuresSubset.names)
featuresSubset.names <- gsub('tBodyGyro', 'timeBodyGyroscope', featuresSubset.names)
featuresSubset.names <- gsub('tGravityAcc', 'timeGravityAccelerometer', featuresSubset.names)
featuresSubset.names <- gsub('fBodyBodyAcc', 'frequencyBodyAccelerometer', featuresSubset.names)
featuresSubset.names <- gsub('fBodyAcc', 'frequencyBodyAccelerometer', featuresSubset.names)
featuresSubset.names <- gsub('fBodyBodyGyro', 'frequencyBodyGyroscope', featuresSubset.names)
featuresSubset.names <- gsub('fBodyGyro', 'frequencyBodyGyroscope', featuresSubset.names)
featuresSubset.names <- gsub('Freq', 'Frequency', featuresSubset.names)
featuresSubset.names <- gsub('X', 'XAxis', featuresSubset.names)
featuresSubset.names <- gsub('Y', 'YAxis', featuresSubset.names)
featuresSubset.names <- gsub('Z', 'ZAxis', featuresSubset.names)
featuresSubset.names <- gsub('Mag', 'Magnitude', featuresSubset.names)
featuresSubset.names <- gsub('[-()]', '', featuresSubset.names)

## Load the train data
trainData <- read.table("train/X_train.txt")[featuresSubset]
trainActivities <- read.table("train/Y_train.txt")
trainSubjects <- read.table("train/subject_train.txt")
trainData <- cbind(trainSubjects, trainActivities, trainData)

## Load the test data
testData <- read.table("test/X_test.txt")[featuresSubset]
testActivities <- read.table("test/Y_test.txt")
testSubjects <- read.table("test/subject_test.txt")
testData <- cbind(testSubjects, testActivities, testData)

## Merge the train and test data
totalData <- rbind(trainData, testData)

## Add labels using the renamed features
colnames(totalData) <- c("subject", "activity", featuresSubset.names)

## Turn activities & subjects into factors
totalData$activity <- factor(totalData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
totalData$subject <- as.factor(totalData$subject)

## Make each row a unique id-variable combination
totalData.melted <- melt(totalData, id = c("subject", "activity"))

## Reshape the melted data
totalData.mean <- dcast(totalData.melted, subject + activity ~ variable, mean)

## Output tidy data to file 
write.table(totalData.mean, "tidy.txt", row.names = FALSE, quote = FALSE, sep="\t")
