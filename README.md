# Getting and Cleaning Data Course Project


## The Raw Data
##### The raw data includes the following files:
* "README.txt": See this file for more information on the below files and their contents.
* "features_info.txt": Shows information about the variables used on the feature vector.
* "features.txt": List of all features.
* "activity_labels.txt": Links the class labels with their activity name.
* "train/X_train.txt": Training set.
* "train/y_train.txt": Training labels.
* "test/X_test.txt": Test set.
* "test/y_test.txt": Test labels.

The experiments used to gather the data in the above files were been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 
Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured. 
The experiments have been video-recorded to label the data manually. 
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

Source: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


## The Script
##### run_analysys.R 
The script processes the raw data and creates a separate tidy data set using the following steps:

1. Load the activity labels and features.

2. Get a subset of the features we care about. My subset includes features with "mean" or "std" anywhere in the name (not just at the end of the name).

3. Rename the features to be more descriptive and readable.

4. Merge the train and test data.

5. Reshape the merged data and output to tidy.txt.

Note that the script assumes the filenames for the raw data are original. 
The working directory must be set to the folder that contains the raw data before running the script ("UCI HAR Dataset").

## The Tidy Data
#####tidy.txt
The tidy dataset is a tab-delimited file that contains the means of all of the features per subject and activity. 
Each subject has one row for each activity, and each row contains a column for each feature. 

In order to easily read the output via R, please use this code:
```
data <- read.table("tidy.txt", header = TRUE, sep="\t")
View(data)
```

## The Code Book
##### CodeBook.md
The code book describes the variables, the data, and the transformations performed to clean up the data.


