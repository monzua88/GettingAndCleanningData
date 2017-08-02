################
# Get the data#
################

if(!file.exists("./datos")){dir.create("./datos")} #create the folder
url.dir <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" #store the url in a variable
download.file(url.dir ,destfile="./datos/datos.zip") # download the content of the url in the folder we had create
unzip(zipfile="./datos/datos.zip",exdir="./datos") # unzip the file in the folder.


#################################################################
#1 Merges the training and the test set to create one data set.##
#################################################################

features <- read.table("./datos/UCI HAR Dataset/features.txt") #read the data in features file and store it in features
activityLabels <- read.table("./datos/UCI HAR Dataset/activity_labels.txt") #read the data in activity_labels file and store it in activityLabels
xTest <- read.table("./datos/UCI HAR Dataset/test/X_test.txt") #read the data in X_test file and store it in xTest
yTest <- read.table("./datos/UCI HAR Dataset/test/y_test.txt") #read the data in y_test file and store it in xTest
subjectTest <- read.table("./datos/UCI HAR Dataset/test/subject_test.txt") #read the data in subject_test file and store it in subjectTest
xTrain <- read.table("C:./datos/UCI HAR Dataset/train/x_train.txt") #read the data in x_train file and store it in xTrain
yTrain <- read.table("./datos/UCI HAR Dataset/train/y_train.txt") #read the data in y_train file and store it in yTrain
subjectTrain <- read.table("./datos/UCI HAR Dataset/train/subject_train.txt") #read the data in subject_train file and store it in subjectTrain
colnames(xTest) <- features[,2] #change the column names of xTest for the second column of features
colnames(yTest) <- "activityId" #change the colum name of yTest for "activityId"
colnames(subjectTest) <- "subjectId" #change the colum name of subjectTest for "subjectId"
colnames(xTrain) <- features[,2] #change the column names of xTrain for the second column of features 
colnames(yTrain) <-"activityId" #change the colum name of yTrain for "activityId"
colnames(subjectTrain) <- "subjectId" #change the colum name of subjectTest for "subjectId"
colnames(activityLabels) <- c("activityId","activityType") #change the columns name of activityLabels to "activityId" and "activityType"
trainData <- cbind(yTrain, subjectTrain, xTrain) #Obtain a list with the data of yTrain, subjectTrain and xTrain
testData <- cbind(yTest, subjectTest, xTest) #Obtain a list with the data of yTest, subjectTes and xTest
mergedData <- rbind(trainData, testData) #Obtain a list with all data

############################################################################################
#2 Extracts only the measurements on the mean and standard deviation for each measurement.##
############################################################################################

columns <- colnames(mergedData) #save the column names of mergedData in columns
meanDev <- (grepl("activityId",columns)|grepl("subjectId",columns)|grepl("mean..",columns)|grepl("std..",columns)) #Find activityId, subjectId, mean.. or std.. in meanDev
meanStdData <- mergedData[ , meanDev == TRUE] #List of standar deviation and mean of each variable. 

############################################################################
#3 Uses descriptive activity names to name the activities in the data set.##
#4 Appropriately labels the data set with descriptive variable names.#######
############################################################################

activityNames <- merge(meanStdData, activityLabels, by='activityId', all.x=TRUE) #Merge meanStdData and activityLabels by activityId adding all the columns needed for the variables of both lists

##################################################################################################################################################
#4 Appropriately labels the data set with descriptive variable names.#############################################################################
#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.#
##################################################################################################################################################

secondData <- aggregate(. ~subjectId + activityId, activityNames, mean) #Organize the data of activityNames with the mean of the variables
secondData <- secondData[order(secondData$subjectId, secondData$activityId),] #Organize the data for each subject by activity
write.table(secondData, "secondData.txt", row.names = FALSE)
