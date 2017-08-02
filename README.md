# Getting and cleanning cata final project

To clean and analyze the information described in codeBook the following procedure was performed.

## 1. Obtain the data
The .zip file was downloaded, unzipped and stored in the workspace.

## 2. Merges the training and the test set to create one data set
The data of the tables were read and the names were placed in the columns pertinently. The y_train, subject_train and x_train lists and y_test, subject_test and x_test lists were joined. This information was subsequently stored in a single list.

## 3. Extracts only the measurements on the mean and standard deviation for each measurement.
To extract the standard and average deviation measures, the names of the columns of the table with all the data were taken and these names were searched as regular expressions. The results were stored in another table with the measures of interest.

## 4 Uses descriptive activity names to name the activities in the data set 
## 5 Appropriately labels the data set with descriptive variable names.

The activities of the tables with the descriptive names were named and the data organized so that another file could be generated later with the average of each activity and each subject.

## 6 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

A text file named secondData.txt was obtained and attached to the repository.
The code for the analysis is called run_analysis.R and it is also included.
