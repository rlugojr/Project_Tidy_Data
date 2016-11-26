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
    description(sensor) <- "The measurement instrument."
    description(statistic) <- "Statistical function applied."
    description(jerk) <- "Jerk signals calculated."
    description(magnitude) <- "Magnitude calculated."
    description(axis) <- "Three dimensions of the axial signal."
    description(obs) <- "The number of observations used to calculate the average."
    description(average) <- "The average of the aggregated measurements."

    wording(subjectID) <- "ID number associated with study participant to maintain anonimity."
    wording(activityName) <- "Actions performed at the time that signal measurements were recorded."
    wording(domain) <- "Specifies if signals where generated were time-domain(t) only or had Fast Fourier Transform(f) applied."
    wording(signal_type) <- "The categories assigned to the generated signal using a low pass Butterworth filter with corner frequency of 0.3Hz"
    wording(sensor) <- "The instrument used to generate the signal."
    wording(statistic) <- "The statistical function that was used to generate the value."
    wording(jerk) <- "Specifies if the body-linear acceleration and angular velocity were derived in time to record Jerk signals."
    wording(magnitude) <- "Specifies if the Euclidean norm was used to calculate the three dimensional signals."
    wording(axis) <- "Specifies which direction of the axial signal, if not all, was recorded."
    wording(obs) <- "The number of observations used to calculate the average"
    wording(average) <- "The average of the recorded and calculated measurements for aggregted observational variables."

    foreach(x <- c(obs,average),{
        annotation(x)["Remark"] <- "These measurements were sampled accross the dataset without specifying variables.  Therefore the calculated values above do not reflect any actual observations."
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


