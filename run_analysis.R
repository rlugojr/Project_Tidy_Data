#load libraries using very cool approach found here https://gist.github.com/stevenworthington/3178163
ipak <- function(pkg){
    new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
    if (length(new.pkg))
        install.packages(new.pkg, dependencies = TRUE)
    sapply(pkg, require, character.only = TRUE)
}

libraries <- c("dtplyr","dplyr","readr","stringr")
ipak(libraries)

#check for data folder.  Create one if none exists
if (!file.exists("./data")) { dir.create("./data")}

#get UCI data package using libcurl for OS independence.
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
sourceFile <- "./data/uci.zip"
if (!file.exists(sourceFile)) {
    download.file(url, destfile = "./data/uci.zip", method = "libcurl")
}

#extract only data used for analysis
datafiles <- c("UCI HAR Dataset/test/subject_test.txt","UCI HAR Dataset/test/X_test.txt","UCI HAR Dataset/test/y_test.txt",
               "UCI HAR Dataset/train/subject_train.txt","UCI HAR Dataset/train/X_train.txt","UCI HAR Dataset/train/y_train.txt")
unzip(sourceFile, datafiles, list = FALSE, junkpaths = TRUE, exdir = "./data", unzip = "internal")

#get loadfile names from extracted files
loadfiles <- gsub("UCI HAR Dataset/(test/|train/)","",datafiles)

#load each file into its own table
for (loadfile in loadfiles) {

    tblname <- tolower(gsub(".txt","",loadfile))

    assign(tblname, fread(paste("./data/",loadfile, sep = ""), header = FALSE))
}
