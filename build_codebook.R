#Codebook of dtTidy metadata
#Project Tidy Data - build_codebook.R
#Getting and Cleaning Data
#by Ray Lugo, Jr.
#2016-11-25

#The purpose of this script is to create metadata that can be used to generate a codebook
#which details the table, columns and values contained in the final data set, including
#cursory statistics for each.


library(memisc)

Data <- as.data.set(tbl_df(dtTidyAvg))

Data  <- within(Data, {
    description(subjectID) <- "Study Participant ID number."
    description(activityName) <- "Activity performed when observation was recorded."
    description(domain) <- "Time-domain (t) only or Fast-Fourier Transform (f) applied."
    description(signal_type) <- "Categorization of generated signal."
    description(sensor) <- "The instrument used for signal measurement."
    description(statistic) <- "Statistical function used to calculate the original value."
    description(jerk) <- "Jerk signals calculated?"
    description(magnitude) <- "Magnitude calculated?"
    description(axis) <- "Axis observed, as calculated from the triaxial signal."
    description(obs) <- "The number of observations used to calculate the average."
    description(average) <- "The average of the aggregated measurements."

    wording(subjectID) <- "ID number associated with each study participant, used to maintain anonimity."
    wording(activityName) <- "Actions performed while signal measurements were recorded."
    wording(domain) <- "Specifies if signals generated were time-domain(t) only or had Fast Fourier Transform(f) applied."
    wording(signal_type) <- "Denotes if the generated signal was processed using a low pass Butterworth filter with corner frequency of 0.3Hz"
    wording(sensor) <- "The instrument used to measure and record the signal."
    wording(statistic) <- "The statistical function that was used to calculate the original observed value."
    wording(jerk) <- "Specifies if the body-linear acceleration and angular velocity were derived in time to record Jerk signals."
    wording(magnitude) <- "Specifies if the 'Euclidean norm' was used to calculate the three dimensional signals."
    wording(axis) <- "Specifies which axis (X, Y, X) of the triaxial signal was isolated and recorded."
    wording(obs) <- "The number of observations aggregated and used to calculate the average value"
    wording(average) <- "The average value, calculated from the aggregation of observations with the same variable values."

    foreach(x <- c(obs,average),{
        annotation(x)["Remark"] <- "All values in the dataset were used for the summary analysis and therefore are not accurate representations of actual observations."
    })
})

#build "object" to hold report parts
code.book.dtTidyAvg <- codebook(Data)
code.book.dtTidyAvg.tableName <- "tidyDataAvg"
code.book.dtTidyAvg.columnDefs <- description(Data)
code.book.dtTidyAvg.description <- "Tidy, agreggated dataset."
code.book.dtTidyAvd.wording <- "Tidy version of original dataset, aggregated by observational variables and calculating the mean(value) of the included observations."

#example report
cat("\n","-------------------------------------------------------------------\n\n", sep = "")
cat(code.book.dtTidyAvg.tableName, " - ", code.book.dtTidyAvg.description, "\n\n", sep = "")
cat(code.book.dtTidyAvd.wording, "\n\n", sep = "")
cat("-------------------------------------------------------------------\n\n", sep = "")
cat("Data Definitions\n","________________\n", sep = "")
print(code.book.dtTidyAvg.columnDefs)
cat("\n\n\n")
print(code.book.dtTidyAvg)


