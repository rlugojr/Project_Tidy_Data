#Tidy data processing script
#Project Tidy Data - run_analysis.R
#Getting and Cleaning Data
#by Ray Lugo, Jr.
#2016-11-25

#The purpose of "run_analysis.R" is to:
#1. Merge the training and the test sets to create one data set.
#2. Extract only the measurements on the mean and standard deviation for each measurement.
#3. Use descriptive activity names to name the activities in the data set.
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#_______________________________________________________________________________

#Script Begins

#clear workspace of prior objects to free memory.
rm(list = ls())

#function to install and load libraries that are not already installed or loaded
#using very cool approach found here https://gist.github.com/stevenworthington/3178163
ipak <- function(pkg){
    new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
    if (length(new.pkg))
        install.packages(new.pkg, dependencies = TRUE)
    sapply(pkg, require, character.only = TRUE)
}
print(paste("started at :", Sys.time()))

print("loading libraries.")
#create vector of libraries and pass into the above function.
libraries <- c("data.table","dtplyr","dplyr","readr","stringr", "psych", "reshape2")
ipak(libraries)

#remove the objects since they will not be used again this session
rm("libraries","ipak")

#check for data folder.  Create one if none exists
if (!file.exists("./data")) { dir.create("./data")}

#get "UCI data" archive by using libcurl, which allows for OS independence.
#set the url value.
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#create a sourcefile variable for reference when downloading and unzipping
sourceFile <- "./data/uci.zip"

print("downloading data archive.")
#check if file has already been downloaded.  If it does not exist, then download it.
if (!file.exists(sourceFile)) {
    download.file(url, destfile = "./data/uci.zip", method = "libcurl")
}

#create a vector with the exact files needed for data processing
datafiles <- c("UCI HAR Dataset/features.txt","UCI HAR Dataset/activity_labels.txt",
               "UCI HAR Dataset/test/subject_test.txt","UCI HAR Dataset/test/X_test.txt","UCI HAR Dataset/test/y_test.txt",
               "UCI HAR Dataset/train/subject_train.txt","UCI HAR Dataset/train/X_train.txt","UCI HAR Dataset/train/y_train.txt")

print("unzipping data files")
#using "unzip", extract only those file.  using "jumkpaths" removes any internal folder structure
#to allow all files to be placed as designated, in this case, all in the root of the "./data" folder.
unzip(sourceFile, datafiles, list = FALSE, junkpaths = TRUE, exdir = "./data", unzip = "internal")

#use "gsub" with a simple regex to get loadfile names for the extracted files
#from the original vector, so that we know which files should be available
loadfiles <- gsub("UCI HAR Dataset/(test/|train/)?","",datafiles)

print("loading files into data tables.")
#load each file into its own table which is named dynamically using the file's name (sans extension)
for (loadfile in loadfiles) {
    if (loadfile == "features.txt") {
        #handle the "features" table separately for use as the header of specific tables
        tblHeader <- read.delim(paste0("./data/",loadfile), header = FALSE, sep = " ", stringsAsFactors = FALSE, col.names = c("num","name"))
    } else {
        #load table into data.table using file name as the table name.
        tblname <- tolower(gsub(".txt","",loadfile))
        assign(tblname, fread(paste0("./data/",loadfile), header = FALSE))
    }
    #update user on progress.
    print(paste("table",tolower(gsub(".txt","",loadfile)),"has been loaded."))
}

#free up memory by removing unecessary objects
rm("url","sourceFile","datafiles","loadfiles","loadfile","tblname")

print("adding column names.")
#get column names from headers table
allColNames <- tblHeader$name

#add column names to the "x" tables using headers from "features" file
#which is stored in the table "tblHeader"
colnames(x_test) <- allColNames
colnames(x_train) <- allColNames

#assign meaningful column names to "y" tables
colnames(y_test) <- "activityID"
colnames(y_train) <- "activityID"

#assign meaningful column names to "subject" tables
colnames(subject_test) <- "subjectID"
colnames(subject_train) <- "subjectID"

#assign meaningful column names to activity_labels
colnames(activity_labels)<-c("activityID", "activityName")

#lowercase activityName values for consistency
activity_labels$activityName <- tolower(activity_labels$activityName)

#isolate names of columns to keep.
#using "grep" and a simple regex that identifies "mean" or "std"
keepCols <- grep("(mean[^F]|std)",names(x_test))

print("creating tables for processing")
#create new tables using subset of columns from "x" tables
#keeping only the identified column names.
x_test_keep <- dplyr::select(x_test, keepCols)
x_train_keep <- dplyr::select(x_train, keepCols)

#free up memory by removing unecessary objects
rm("tblHeader","x_test","x_train")

print("combining tables")
#Create single data.table for each type of dataset using cbind.
#one for "test" data and another for "train" data.
testData <- cbind(subject_test, x_test_keep)
testData <- cbind(testData, y_test)
trainData <- cbind(subject_train, x_train_keep)
trainData <- cbind(trainData, y_train)

#concat rows from both tables into one table in order to process the data
#all at once since it is small enough to fit into memory.
dtTemp <- rbind(testData, trainData)

#join main table with the "activity_labels" table
#to associate the corresponding "activityName" values
dtTemp <- inner_join(dtTemp, activity_labels, by = "activityID" )

#create new data.table from temp table
dtAll <- tbl_df(dtTemp)

#free up memory by removing unecessary objects
rm("subject_test","subject_train","testData","trainData","x_test_keep","x_train_keep","y_test","y_train", "dtTemp", "activity_labels")

print("creating first tidy dataset.")
#create tidy dataset by rearranging columns and normalizing the dataset.
#store names of columns that will not need to be reshaped in a vector.
#pivot remaining columns to make a row per obeservation using reshape2::melt()
#use dplyr::mutate() to create new columns with values generated from the current "measurement" value.
#select and arrange the columns into a new table, leaving out the "activityID" field
colID <- c("activityID","subjectID","activityName")
dtTidy <- dtAll %>%
    melt(id = colID, variable.name = "measurement") %>%
    dplyr::select(-activityID) %>%
    mutate(domain = ifelse(str_sub(measurement, start = 1, end = 1) == "t", "time","frequency"),
           signal_type = ifelse(str_count(measurement, "Body") != 0, "body", "gravity"),
           sensor = ifelse(str_count(measurement, "Acc") != 0, "accelerometer", "gyroscope"),
           statistic = ifelse(str_count(measurement, "mean") != 0, "mean", "stdDev"),
           jerk = ifelse(str_count(measurement, "Jerk") != 0, TRUE, FALSE),
           magnitude = ifelse(str_count(measurement, "Mag") != 0,TRUE, FALSE),
           axis = ifelse(str_detect(str_sub(measurement, start = str_length(measurement)),c("X","Y","Z")), (str_sub(measurement, start = str_length(measurement))), NA)) %>%
    dplyr::select(subjectID,activityName,domain,signal_type, sensor, statistic, jerk, magnitude, axis, value) %>%
    arrange(subjectID,activityName,domain,signal_type, sensor, statistic, jerk, magnitude, axis, value)

print("creating factors.")
#create levels for variables
dtTidy$subjectID <- as.factor(dtTidy$subjectID)
dtTidy$activityName <- as.factor(dtTidy$activityName)
dtTidy$domain <- as.factor(dtTidy$domain)
dtTidy$signal_type <- as.factor(dtTidy$signal_type)
dtTidy$sensor <- as.factor(dtTidy$sensor)
dtTidy$statistic <- as.factor(dtTidy$statistic)
dtTidy$jerk <- as.factor(dtTidy$jerk)
dtTidy$magnitude <- as.factor(dtTidy$magnitude)
dtTidy$axis <- as.factor(dtTidy$axis)

#display first tidy data.table.
print("here is a glimpse of dtTidy")
glimpse(dtTidy)

#free up memory by removing unecessary objects
rm("dtAll", "colID", "allColNames", "keepCols")

print("creating second tidy dataset.")
#create summarized tidy dataset.
#Use dplyr::group_by to specify columns used for grouping by value.
#Use dplyr::summarize() to specify aggregation method on value column.
#arrange the resulting set so that variable columns are listed before the
#aggregated value column, from left to right.
dtTidyAvg <- dtTidy %>%
    group_by(subjectID, activityName, domain, signal_type, sensor, statistic, jerk, magnitude, axis) %>%
    summarize(obs = n(),average = mean(value)) %>%
    arrange(subjectID, activityName, domain, signal_type, sensor, statistic, jerk, magnitude, axis, average)

#display second tidy data.table.
print("here is a glimpse of dtTidyAvg")
glimpse(dtTidyAvg)

#Validate resulting tables by joining and comparing count of rows
dtMatch <- inner_join(dtTidy,dtTidyAvg)
ifelse(count(dtMatch) == count(dtTidy),print("results validated!"),print("Did not pass validation.  Check script and data."))
rm("dtMatch")

#write CSV files for each table to the "./data" folder.
print("writing datasets to csv files in './data' folder.")
#Uncomment next line to export the first Tidy dataset to file.
#write.csv(dtTidy, "./data/UCI_Analysis_Tidy.csv", na = "NA")
write.table(dtTidyAvg, "./data/UCI_Analysis_Summary_Tidy.txt", quote = FALSE, na = "NA", row.name=FALSE)
print(paste0("data table exported to ", getwd(),"/data/UCI_Analysis_Summary_Tidy.txt"))

print(paste("processing completed at :", Sys.time()))

#Script Ends
