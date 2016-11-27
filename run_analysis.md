-   [run\_analysis.R - Tidy data processing script](#run_analysis.r---tidy-data-processing-script)
    -   [****Script Begins****](#script-begins)
        -   [Prepare the environment](#prepare-the-environment)
        -   [Retrieve unprocessed data.](#retrieve-unprocessed-data.)
    -   [****Script Ends****](#script-ends)

run\_analysis.R - Tidy data processing script
---------------------------------------------

The purpose of "run\_analysis.R" is to:
1. Create a 'tidy' data table from the "train"" and "test"" sets.
2. Use descriptive activity names to name the activities in the data set.
3. Appropriately labels the data set with descriptive variable names.
4. Extract only the measurements on the mean and standard deviation for each measurement.
5. Using the 'tidy' data set, creates a second tidy data set which summarizes the tidy table, providing the mean value on the aggregated rows for each valid combination of variables, activity and subject.

------------------------------------------------------------------------

### ****Script Begins****

#### Prepare the environment

1.  Clear workspace of prior objects to free memory.

        rm(list = ls())

2.  Function to install and load libraries that are not already installed or loaded using very cool approach found here <https://gist.github.com/stevenworthington/3178163>

        ipak <- function(pkg){
        new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
        if (length(new.pkg))
            install.packages(new.pkg, dependencies = TRUE)
        sapply(pkg, require, character.only = TRUE)
        }
        print(paste("started at :", Sys.time()))

3.  Create vector of libraries and pass into the above function.

        print("loading libraries.")
        libraries <- c("data.table","dtplyr","dplyr","readr","stringr", "psych", "reshape2")
        ipak(libraries)

4.  Remove the objects since they will not be used again this session

        rm("libraries","ipak")

#### Retrieve unprocessed data.

1.  Check for data folder. create one if none exists.

        if (!file.exists("./data")) { dir.create("./data")}

2.  Get "UCI data" archive by using libcurl, which allows for OS independence. set the url value.

        url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

3.  Create a sourcefile variable for reference when downloading and unzipping

        sourceFile <- "./data/uci.zip"

4.  Check if file has already been downloaded. If it does not exist, then download it. \`\`\` print("downloading data archive.")

if (!file.exists(sourceFile)) { download.file(url, destfile = "./data/uci.zip", method = "libcurl") }


    #### Load specific data files into respective data tables.

    9. Create a vector with the exact files needed for data processing

datafiles &lt;- c("UCI HAR Dataset/features.txt","UCI HAR Dataset/activity\_labels.txt", "UCI HAR Dataset/test/subject\_test.txt","UCI HAR Dataset/test/X\_test.txt","UCI HAR Dataset/test/y\_test.txt", "UCI HAR Dataset/train/subject\_train.txt","UCI HAR Dataset/train/X\_train.txt","UCI HAR Dataset/train/y\_train.txt")

print("unzipping data files")


    10. Using "unzip", extract only those file.  using "jumkpaths" removes any internal folder structure to allow all files to be placed as designated, in this case, all in the root of the "./data" folder.

unzip(sourceFile, datafiles, list = FALSE, junkpaths = TRUE, exdir = "./data", unzip = "internal")


    11. Use "gsub" with a simple regex to get loadfile names for the extracted files from the original vector, so that we know which files should be available

loadfiles &lt;- gsub("UCI HAR Dataset/(test/|train/)?","",datafiles)

print("loading files into data tables.")


    12. Load each file into its own table which is named dynamically using the file's name (sans extension)

for (loadfile in loadfiles) { if (loadfile == "features.txt") { \#handle the "features" table separately for use as the header of specific tables tblHeader &lt;- read.delim(paste0("./data/",loadfile), header = FALSE, sep = " ", stringsAsFactors = FALSE, col.names = c("num","name")) } else { \#load table into data.table using file name as the table name. tblname &lt;- tolower(gsub(".txt","",loadfile)) assign(tblname, fread(paste0("./data/",loadfile), header = FALSE)) } \#update user on progress. print(paste("table",tolower(gsub(".txt","",loadfile)),"has been loaded.")) }


    13. Free up memory by removing unecessary objects

rm("url","sourceFile","datafiles","loadfiles","loadfile","tblname")


    #### Add meaningful column names

    14. Get column names from headers table

print("adding column names.") allColNames &lt;- tblHeader$name


    15. Add column names to the "x" tables using headers from "features" file which is stored in the table "tblHeader"

colnames(x\_test) &lt;- allColNames colnames(x\_train) &lt;- allColNames


    16. Assign meaningful column names to "y" tables

colnames(y\_test) &lt;- "activityID" colnames(y\_train) &lt;- "activityID"


    17. Assign meaningful column names to "subject" tables

colnames(subject\_test) &lt;- "subjectID" colnames(subject\_train) &lt;- "subjectID"


    18. Assign meaningful column names to activity_labels

colnames(activity\_labels)&lt;-c("activityID", "activityName")


    19. Lowercase activityName values for consistency

activity\_labels*a**c**t**i**v**i**t**y**N**a**m**e* &lt; −*t**o**l**o**w**e**r*(*a**c**t**i**v**i**t**y*<sub>*l*</sub>*a**b**e**l**s*activityName)


    #### CBIND and RBIND to create "master" data table.

    20. Isolate names of columns to keep. Using "grep" and a simple regex that identifies "mean" or "std"

keepCols &lt;- grep("(mean\[^F\]|std)",names(x\_test))

print("creating tables for processing")


    21. Create new tables using subset of columns from "x" tables, keeping only the identified column names.

x\_test\_keep &lt;- dplyr::select(x\_test, keepCols) x\_train\_keep &lt;- dplyr::select(x\_train, keepCols)


    22. Free up memory by removing unecessary objects

rm("tblHeader","x\_test","x\_train")


    23. Create single data.table for each type of dataset using cbin, one for "test" data and another for "train" data.

print("combining tables")

testData &lt;- cbind(subject\_test, x\_test\_keep) testData &lt;- cbind(testData, y\_test) trainData &lt;- cbind(subject\_train, x\_train\_keep) trainData &lt;- cbind(trainData, y\_train)


    24. Concat rows from both tables into one table in order to process the data all at once since it is small enough to fit into memory.

dtTemp &lt;- rbind(testData, trainData)


    #### Add meaningful activity names to associated observations through join by activityID

    25. Join main table with the "activity_labels" table to associate the corresponding "activityName" values

dtTemp &lt;- inner\_join(dtTemp, activity\_labels, by = "activityID" )


    26. Create new data.table from temp table

dtAll &lt;- tbl\_df(dtTemp)


    27. Free up memory by removing unecessary objects

rm("subject\_test","subject\_train","testData","trainData","x\_test\_keep","x\_train\_keep","y\_test","y\_train", "dtTemp", "activity\_labels")


    #### Create first level *tidy* dataset

    28. create tidy dataset by rearranging columns and normalizing the dataset. Store names of columns that will not need to be reshaped in a vector. Pivot remaining columns to make a row per obeservation using reshape2::melt(). Use dplyr::mutate() to create new columns with values generated from the current "measurement" value. Select and arrange the columns into a new table, leaving out the "activityID" field

print("creating first tidy dataset.")

colID &lt;- c("activityID","subjectID","activityName") dtTidy &lt;- dtAll %&gt;% melt(id = colID, variable.name = "measurement") %&gt;% dplyr::select(-activityID) %&gt;% mutate(domain = ifelse(str\_sub(measurement, start = 1, end = 1) == "t", "time","frequency"), signal\_type = ifelse(str\_count(measurement, "Body") != 0, "body", "gravity"), sensor = ifelse(str\_count(measurement, "Acc") != 0, "accelerometer", "gyroscope"), statistic = ifelse(str\_count(measurement, "mean") != 0, "mean", "stdDev"), jerk = ifelse(str\_count(measurement, "Jerk") != 0, TRUE, FALSE), magnitude = ifelse(str\_count(measurement, "Mag") != 0,TRUE, FALSE), axis = ifelse(str\_detect(str\_sub(measurement, start = str\_length(measurement)),c("X","Y","Z")), (str\_sub(measurement, start = str\_length(measurement))), NA)) %&gt;% dplyr::select(subjectID,activityName,domain,signal\_type, sensor, statistic, jerk, magnitude, axis, value) %&gt;% arrange(subjectID,activityName,domain,signal\_type, sensor, statistic, jerk, magnitude, axis, value)


    29.Create levels for variables

print("creating factors.")

dtTidy*s**u**b**j**e**c**t**I**D* &lt; −*a**s*.*f**a**c**t**o**r*(*d**t**T**i**d**y*subjectID) dtTidy*a**c**t**i**v**i**t**y**N**a**m**e* &lt; −*a**s*.*f**a**c**t**o**r*(*d**t**T**i**d**y*activityName) dtTidy*d**o**m**a**i**n* &lt; −*a**s*.*f**a**c**t**o**r*(*d**t**T**i**d**y*domain) dtTidy*s**i**g**n**a**l*<sub>*t*</sub>*y**p**e* &lt; −*a**s*.*f**a**c**t**o**r*(*d**t**T**i**d**y*signal\_type) dtTidy*s**e**n**s**o**r* &lt; −*a**s*.*f**a**c**t**o**r*(*d**t**T**i**d**y*sensor) dtTidy*s**t**a**t**i**s**t**i**c* &lt; −*a**s*.*f**a**c**t**o**r*(*d**t**T**i**d**y*statistic) dtTidy*j**e**r**k* &lt; −*a**s*.*f**a**c**t**o**r*(*d**t**T**i**d**y*jerk) dtTidy*m**a**g**n**i**t**u**d**e* &lt; −*a**s*.*f**a**c**t**o**r*(*d**t**T**i**d**y*magnitude) dtTidy*a**x**i**s* &lt; −*a**s*.*f**a**c**t**o**r*(*d**t**T**i**d**y*axis)


    30. Display first tidy data.table.

print("here is a glimpse of dtTidy") glimpse(dtTidy)


    31. Free up memory by removing unecessary objects

rm("dtAll", "colID", "allColNames", "keepCols")


    #### Create Summarized *tidy* dataset (deliverable)

    32. create summarized tidy dataset. Use dplyr::group_by to specify columns used for grouping by value. Use dplyr::summarize() to specify aggregation method on value column. Arrange the resulting set so that variable columns are listed before the aggregated value column, from left to right.

print("creating second tidy dataset.")

dtTidyAvg &lt;- dtTidy %&gt;% group\_by(subjectID, activityName, domain, signal\_type, sensor, statistic, jerk, magnitude, axis) %&gt;% summarize(obs = n(),average = mean(value)) %&gt;% arrange(subjectID, activityName, domain, signal\_type, sensor, statistic, jerk, magnitude, axis, average)


    33. Display second tidy data.table.

print("here is a glimpse of dtTidyAvg") glimpse(dtTidyAvg)


    #### Validate records by joining both processed tables and verifying row counts match.

    34. Validate resulting tables by joining and comparing count of rows

dtMatch &lt;- inner\_join(dtTidy,dtTidyAvg) ifelse(count(dtMatch) == count(dtTidy),print("results validated!"),print("Did not pass validation. Check script and data.")) rm("dtMatch")


    #### Write dataset to tab delimited text file.


    35. Write CSV files for each table to the "./data" folder.

print("writing datasets to csv files in './data' folder.") \#Uncomment next line to export the first Tidy dataset to file. \#write.csv(dtTidy, "./data/UCI\_Analysis\_Tidy.csv", na = "NA") write.table(dtTidyAvg, "./data/UCI\_Analysis\_Summary\_Tidy.txt", quote = FALSE, na = "NA") print(paste0("data table exported to ", getwd(),"/data/UCI\_Analysis\_Summary\_Tidy.txt"))

print(paste("processing completed at :", Sys.time())) \`\`\`

### ****Script Ends****
