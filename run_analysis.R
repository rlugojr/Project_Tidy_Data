#load libraries using very cool approach found here https://gist.github.com/stevenworthington/3178163
ipak <- function(pkg){
    new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
    if (length(new.pkg))
        install.packages(new.pkg, dependencies = TRUE)
    sapply(pkg, require, character.only = TRUE)
}

libraries <- c("data.table","dtplyr","dplyr","readr","stringr", "tidyr", "reshape2")
ipak(libraries)

rm("libraries","ipak")

#check for data folder.  Create one if none exists
if (!file.exists("./data")) { dir.create("./data")}

#get UCI data package using libcurl for OS independence.
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
sourceFile <- "./data/uci.zip"
if (!file.exists(sourceFile)) {
    download.file(url, destfile = "./data/uci.zip", method = "libcurl")
}

#extract only data used for analysis
datafiles <- c("UCI HAR Dataset/features.txt","UCI HAR Dataset/activity_labels.txt",
               "UCI HAR Dataset/test/subject_test.txt","UCI HAR Dataset/test/X_test.txt","UCI HAR Dataset/test/y_test.txt",
               "UCI HAR Dataset/train/subject_train.txt","UCI HAR Dataset/train/X_train.txt","UCI HAR Dataset/train/y_train.txt")
unzip(sourceFile, datafiles, list = FALSE, junkpaths = TRUE, exdir = "./data", unzip = "internal")

#get loadfile names from extracted files
loadfiles <- gsub("UCI HAR Dataset/(test/|train/)?","",datafiles)

#load each file into its own table
for (loadfile in loadfiles) {
    if (loadfile == "features.txt") {
        tblHeader <- read.delim(paste0("./data/",loadfile), header = FALSE, sep = " ", stringsAsFactors = FALSE, col.names = c("num","name"))
    } else {

        tblname <- tolower(gsub(".txt","",loadfile))
        assign(tblname, fread(paste0("./data/",loadfile), header = FALSE))
    }
}

rm("url","sourceFile","datafiles","loadfiles","loadfile","tblname")

#get column names from headers table
allColNames <- tblHeader$name

#add column headers to "x" tables
colnames(x_test) <- allColNames
colnames(x_train) <- allColNames

#add colmn name to "y" tables
colnames(y_test) <- "activityID"
colnames(y_train) <- "activityID"

#add colmn name to "subject" tables
colnames(subject_test) <- "subjectID"
colnames(subject_train) <- "subjectID"

#add column name to activity_labels
colnames(activity_labels)<-c("activityID", "activityName")

#isolate names of columns to keep.
keepCols <- x_test[,grep("(mean[^F]|std)",names(x_test))]

#subset tables using column names to keep
x_test_keep <- select(x_test, keepCols)
x_train_keep <- select(x_train, keepCols)

#cleanup
rm("tblHeader","x_test","x_train")

#Create single data.table for each type of dataset
testData <- cbind(subject_test, x_test_keep)
testData <- cbind(testData, y_test)
trainData <- cbind(subject_train, x_train_keep)
trainData <- cbind(trainData, y_train)

#concat rows from both tables into one data.table
dtTemp <- rbind(testData, trainData)

#join the activity_labels table to get the corresponding activity values
dtTemp <- inner_join(dtTemp, activity_labels, by = "activityID" )

dtAll <- as.data.table(dtTemp)

#cleanup
rm("subject_test","subject_train","testData","trainData","x_test_keep","x_train_keep","y_test","y_train", "dtTemp", "activity_labels")

#pivot data to make a row per obeservation using reshape2::melt()
#and drop the "activityID" field
colID <- c("activityID","subjectID","activityName")
dtTidy <- dtAll %>%
    melt(id = colID, variable.name = "measurement") %>%
    select(-activityID) %>%
    mutate(domain = ifelse(str_sub(measurement, start = 1, end = 1) == "t", "time","frequency"),
           accelerator = ifelse(str_count(measurement, "Body") != 0, "body", "gravity"),
           instrument = ifelse(str_count(measurement, "Acc") != 0, "accelerator", "gyroscope"),
           statistic = ifelse(str_count(measurement, "mean") != 0, "mean", "standard_deviation"),
           jerk = ifelse(str_count(measurement, "Jerk") != 0, "TRUE", "FALSE"),
           magnitude = ifelse(str_count(measurement, "Mag") != 0,"TRUE", "FALSE"),
           axis = ifelse(str_detect(str_sub(measurement, start = str_length(measurement)),c("X","Y","Z")), (str_sub(measurement, start = str_length(measurement))), NA)) %>%
    select(subjectID,activityName,domain,accelerator, instrument, statistic, jerk, magnitude, axis, value) %>%
    arrange(subjectID,activityName,domain,accelerator, instrument, statistic, jerk, magnitude, axis, value)

#cleanup
rm("dtAll", "colID", "allColNames", "keepCols")

#create summarized tidy dataset.
dtTidyAvg <- dtTidy %>%
    group_by(subjectID, activityName, domain, accelerator, instrument, statistic, jerk, magnitude, axis) %>%
    summarize(average = mean(value)) %>%
    arrange(subjectID, activityName, domain, accelerator, instrument, statistic, jerk, magnitude, axis)


