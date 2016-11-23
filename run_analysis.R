#load libraries using very cool approach found here https://gist.github.com/stevenworthington/3178163
ipak <- function(pkg){
    new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
    if (length(new.pkg))
        install.packages(new.pkg, dependencies = TRUE)
    sapply(pkg, require, character.only = TRUE)
}

libraries <- c("dtplyr","dplyr","readr","stringr")
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
        tblHeader <- read.delim(paste("./data/",loadfile, sep = ""), header = FALSE, sep = " ", stringsAsFactors = FALSE, col.names = c("num","name"))
    } else {

        tblname <- tolower(gsub(".txt","",loadfile))
        assign(tblname, fread(paste("./data/",loadfile, sep = ""), header = FALSE))
    }
}

rm("url","sourceFile","datafiles","loadfiles","loadfile","tblname")

#add column headers to "x" tables
colnames(x_test) <- tblHeader$name
colnames(x_train) <- tblHeader$name

#add colmn name to "y" tables
colnames(y_test) <- "activityID"
colnames(y_train) <- "activityID"

#add colmn name to "y" tables
colnames(subject_test) <- "SubjectID"
colnames(subject_train) <- "SubjectID"

testData <- data.table(subject_test, x_test, y_test)
trainData <- data.table(subject_train, x_train, y_train)

dtAll <- rbind(testData, trainData)

rm("subject_test","subject_train","tblHeader","testData","trainData","x_test","x_train","y_test","y_train")






