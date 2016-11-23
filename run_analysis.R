#
#
#

#check for data folder.  Create one if none exists
if (!file.exists("./data")){dir.create("./data")}



#get UCI data package using libcurl for OS independence.
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
sourceFile <- "./data/uci.zip"
if (!file.exists(sourceFile)){
    download.file(url, destfile = "./data/uci.zip", method = "libcurl")
}
