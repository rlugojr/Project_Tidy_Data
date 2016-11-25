#Ray Lugo, Jr

#Codebook of dtTidy metadata

code.book.dtTidyAvg <- data.frame(
    subjectID <- unique(dtTidyAvg$subjectID),
    activityName <- unique(dtTidyAvg$activityName),
    domain <- unique(dtTidyAvg$domain),
    signal_type <- unique(dtTidyAvg$signal_type),
    sensor <- unique(dtTidyAvg$sensor),
    statistic <- unique(dtTidyAvg$statistic),
    jerk <- unique(dtTidyAvg$jerk),
    magnitude <- unique(dtTidyAvg$magnitude),
    axis <- unique(dtTidyAvg$axis),
    obs <- describe(dtTidyAvg$obs),
    average <- describe(dtTidyAvg$average)
)

description(code.book.dtTidyAvg) <- "Tidy, agreggated version of original dataset."
wording(code.book.dtTidyAvg) <- "Tidy version of original dataset, aggregated by observational variables and calculating the mean(value) of the included observations."

code.book.dtTidyAvg  <- within(code.book.dtTidyAvg, {
    description(subjectID) <- "Study Participant ID number."
    description(activityName) <- "Activity performed when observation was recorded."
    description(domain) <- "Time-domain(t) only or Fast Fourier Transform(f) applied."
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

    #measurement(average) <- "interval"

    foreach(x <- c(obs,average),{
        annotation(x)["Remark"] <- "These measurements were sampled accross the dataset without specifying variables.  Therefore the calculated values above do not reflect any actual observations."
    })
})



description(code.book.dtTidyAvg)

codebook(code.book.dtTidyAvg)


#dim(dtTidyAvg)
#head(dtTidyAvg)
#tail(dtTidyAvg)

#glimpse(dtTidyAvg)

#summary(dtTidyAvg)




