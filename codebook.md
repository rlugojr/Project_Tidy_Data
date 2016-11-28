-   [Codebook](#codebook)
    -   [Description](#description)
    -   [Overview of the original dataset.](#overview-of-the-original-dataset.)
    -   [Data Processing Method](#data-processing-method)
        -   [Software and Library Versions](#software-and-library-versions)
        -   [Overview of run\_analysis.R](#overview-of-run_analysis.r)
        -   [run\_analysis.R, step-by-step commented documentation](#run_analysis.r-step-by-step-commented-documentation)
        -   [Initial Tidy data set](#initial-tidy-data-set)
        -   [Summarized Tidy data set](#summarized-tidy-data-set)
        -   [Summarized Tidy Dataset Info](#summarized-tidy-dataset-info)
        -   [Listing of Variables](#listing-of-variables)
        -   [Detailed Variable Information](#detailed-variable-information)
        -   [Initial statistics about the summarized tidy data set.](#initial-statistics-about-the-summarized-tidy-data-set.)
    -   [Sources](#sources)

### Codebook

A codebook is essential documentation which provides detailed information on method(s) used for data preparation and any useful metadata that should be taken into consideration for data processing, data storage and retrieval. Precise and detailed information in a project codebook can help other researchers and analysts with their attempts to reproduce results, for the purpose of validation or perhaps to build upon your research for their experiments and analysis.

#### Description

This codebook provides details on:

-   Overview of the original dataset.
-   Data processing method.
-   Overview of run\_analysis.R
-   Link to step-by-step commented documentation of run\_analysis.R
-   Overview of the initial Tidy data set.
-   Overview of the Summarized Tidy data set
-   Data Dictionary of all variables in the summarized Tidy dataset.
-   Initial statistics about the summarized tidy data set.

#### Overview of the original dataset.

An overview of the experiment and method of data collection has been documented in this repository's [README.MD](https://github.com/rlugojr/Project_Tidy_Data#original-experiment)

The dataset used for this project can be retrieved here: [UCI Human Activity Recognition Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

#### Data Processing Method

Automation of data processing using R scripts simplified the overall task. Through analysis of the original dataset, understanding gained from the original documentation and the constant iterations and refinement while buidling the scripts, I was able to load the data, extract only the necessary tables of data, and use tools like reshapR and Dplyr to create "tidy" datasets which allow for easier manipulation, analyisis and reporting. Through the use of scripts that can accurately and repeatably recreate the final data set, another reseercher or analyst can be confident that they will have the advantage of working with their own exact copy of the dataset.

##### Software and Library Versions

    OS Version: 

    Windows >= 8 x64 (build 9200)

    R version:  R version 3.3.2 (2016-10-31) 

    RStudio version:  1.0.44

          Package  Version
    1  data.table    1.9.6
    2       dplyr    0.5.0
    3      dtplyr    0.0.1
    4       knitr   1.15.1
    5      memisc 0.99.7-1
    6       psych    1.6.9
    7       readr    1.0.0
    8    reshape2    1.4.2
    9   rmarkdown      1.2
    10    stringr    1.1.0

Notes: Memisc is a useful package for creating a manually tedious section of the casebook. Although you can do this using plain R code, the framework is available in Memisc and although the documentation is a bit lacking, once you understand how it works and how much time it will save in future projects, I am sure that this one will have a permanent place in the toolbox. Knitr was used to automate the documentation generation process. Incredibly flexible and simple to use. The dynamic nature of the documentation, if designed correctly, means that code changes would never cause the need for modifying every document which references the changed code. Another great addition to the toolbox, in my opinion.

##### Overview of run\_analysis.R

In order to create the final tidy dataset it was necessary to go through the steps of retreival of dataset, analysis of documents and data, preparation of data, transformation from its current form, and finally creating the tidy dataset. Each of these steps are explained in the [README.MD](https://github.com/rlugojr/Project_Tidy_Data#data-preparation) file and are automated through the use of R scripts.

The following software and packages were used and are recommended in order to prevent discrepancies due to differences in versions which could lead to incorrect data or negatively impact the scripts ability to complete the entire process successfully.

##### run\_analysis.R, step-by-step commented documentation

The data processing script file, run\_analysis.R, is also available in a Markdown document which details the scripted methods and programmatic logic, step by step alongside the actual code. This version is available here: [run\_analysis.md](https://github.com/rlugojr/Project_Tidy_Data/blob/master/run_analysis.md).

Please feel free to send pull requests with any improvements to the code. I always welcome improvement and the chance to learn how to refactor my code for the sake of speed and efficiency (and my personal edification.)

##### Initial Tidy data set

Details for processing the initial tidy dataset can be found here: [README.MD](https://github.com/rlugojr/Project_Tidy_Data#data-preparation)

This was an exercise in proper chaining of many different dplyr and reshape2 functions. Initially it required the use of CBIND and RBIND several times and in the correct order. Then, applying the headers and melting the columns and finally mutating the table to add the activity to each corresponding observation. I went further by taking the values of the measurement table and using a series of grep statements to split the values into their own variable columns, filling it either with their respective values or using TRUE\\FALSE as values for the variables that had no actual values but where binary in nature (was or was not) This produced a table with all variables as columns and one observation per row.

##### Summarized Tidy data set

Details for processing the summarized tidy dataset can be found here: [README.MD](https://github.com/rlugojr/Project_Tidy_Data#data-preparation)

The dataset in a tab-delimited text file can be downloaded here: [UCI\_Analysis\_Summary\_Tidy.txt](https://github.com/rlugojr/Project_Tidy_Data/data/UCI_Analysis_Summary_Tidy.txt)

This dataset was simple to generate when compared to the process for creating the initial tidy table. It was created with a chain of 3 functions. This was a much easier process only because the initial tidy table was available!

##### Summarized Tidy Dataset Info

    UCI_Analysis_Summary_Tidy  -  Tidy, agreggated, perfect dataset. 

    Tidy version of the source dataset which provides the mean(value) from the subset of observations grouped by every variable. 

##### Listing of Variables


     subjectID    'Study Participant ID number.'                               
     activityName 'Activity performed when observation was recorded.'          
     domain       'Time-domain (t) only or Fast-Fourier Transform (f) applied.'
     signal_type  'Categorization of generated signal.'                        
     sensor       'The instrument used for signal measurement.'                
     statistic    'Statistical function used to calculate the original value.' 
     jerk         'Jerk signals calculated?'                                   
     magnitude    'Magnitude calculated?'                                      
     axis         'Axis observed, as calculated from the triaxial signal.'     
     obs          'The number of observations used to calculate the average.'  
     average      'The average of value from the aggregated observations'      

##### Detailed Variable Information

    ===========================================================================

       subjectID 'Study Participant ID number.'

       "ID number associated with each study participant, used to maintain
       anonimity."

    ---------------------------------------------------------------------------

       Storage mode: integer
       Measurement: nominal

       Values and labels   N   Percent
                                      
                1   '1'  492   3.3 3.3
                2   '2'  492   3.3 3.3
                3   '3'  492   3.3 3.3
                4   '4'  492   3.3 3.3
                5   '5'  492   3.3 3.3
                6   '6'  492   3.3 3.3
                7   '7'  492   3.3 3.3
                8   '8'  492   3.3 3.3
                9   '9'  492   3.3 3.3
               10   '10' 492   3.3 3.3
               11   '11' 492   3.3 3.3
               12   '12' 492   3.3 3.3
               13   '13' 492   3.3 3.3
               14   '14' 492   3.3 3.3
               15   '15' 492   3.3 3.3
               16   '16' 492   3.3 3.3
               17   '17' 492   3.3 3.3
               18   '18' 492   3.3 3.3
               19   '19' 492   3.3 3.3
               20   '20' 492   3.3 3.3
               21   '21' 492   3.3 3.3
               22   '22' 492   3.3 3.3
               23   '23' 492   3.3 3.3
               24   '24' 492   3.3 3.3
               25   '25' 492   3.3 3.3
               26   '26' 492   3.3 3.3
               27   '27' 492   3.3 3.3
               28   '28' 492   3.3 3.3
               29   '29' 492   3.3 3.3
               30   '30' 492   3.3 3.3

    ===========================================================================

       activityName 'Activity performed when observation was recorded.'

       "Actions performed while signal measurements were recorded."

    ---------------------------------------------------------------------------

       Storage mode: integer
       Measurement: nominal

              Values and labels    N    Percent 
                                                
       1   'laying'             2460   16.7 16.7
       2   'sitting'            2460   16.7 16.7
       3   'standing'           2460   16.7 16.7
       4   'walking'            2460   16.7 16.7
       5   'walking_downstairs' 2460   16.7 16.7
       6   'walking_upstairs'   2460   16.7 16.7

    ===========================================================================

       domain 'Time-domain (t) only or Fast-Fourier Transform (f) applied.'

       "Specifies if signals generated were time-domain(t) only or had Fast
       Fourier Transform(f) applied."

    ---------------------------------------------------------------------------

       Storage mode: integer
       Measurement: nominal

       Values and labels    N    Percent 
                                         
         1   'frequency' 5760   39.0 39.0
         2   'time'      9000   61.0 61.0

    ===========================================================================

       signal_type 'Categorization of generated signal.'

       "Denotes if the generated signal was processed using a low pass
       Butterworth filter with corner frequency of 0.3Hz"

    ---------------------------------------------------------------------------

       Storage mode: integer
       Measurement: nominal

       Values and labels     N     Percent  
                                            
           1   'body'    12960    87.8  87.8
           2   'gravity'  1800    12.2  12.2

    ===========================================================================

       sensor 'The instrument used for signal measurement.'

       "The instrument used to measure and record the signal."

    ---------------------------------------------------------------------------

       Storage mode: integer
       Measurement: nominal

         Values and labels    N    Percent 
                                           
       1   'accelerometer' 9000   61.0 61.0
       2   'gyroscope'     5760   39.0 39.0

    ===========================================================================

       statistic 'Statistical function used to calculate the original value.'

       "The statistical function, mean or standard deviation, used to
       calculate the original observed value."

    ---------------------------------------------------------------------------

       Storage mode: integer
       Measurement: nominal

       Values and labels    N    Percent 
                                         
            1   'mean'   7380   50.0 50.0
            2   'stdDev' 7380   50.0 50.0

    ===========================================================================

       jerk 'Jerk signals calculated?'

       "Specifies if the body-linear acceleration and angular velocity were
       derived in time to record Jerk signals."

    ---------------------------------------------------------------------------

       Storage mode: integer
       Measurement: nominal

       Values and labels    N    Percent 
                                         
             1   'FALSE' 9000   61.0 61.0
             2   'TRUE'  5760   39.0 39.0

    ===========================================================================

       magnitude 'Magnitude calculated?'

       "Specifies if the 'Euclidean norm' was used to calculate the three
       dimensional signals."

    ---------------------------------------------------------------------------

       Storage mode: integer
       Measurement: nominal

       Values and labels     N     Percent  
                                            
             1   'FALSE' 11520    78.0  78.0
             2   'TRUE'   3240    22.0  22.0

    ===========================================================================

       axis 'Axis observed, as calculated from the triaxial signal.'

       "Specifies which axis (X, Y, X) of the triaxial signal was isolated and
       recorded."

    ---------------------------------------------------------------------------

       Storage mode: integer
       Measurement: nominal

       Values and labels    N    Percent 
                                         
                 1   'X' 2880   33.3 19.5
                 2   'Y' 2880   33.3 19.5
                 3   'Z' 2880   33.3 19.5
                NA M     6120        41.5

    ===========================================================================

       obs 'The number of observations used to calculate the average.'

       "The number of observations aggregated and used to calculate the
       average value"

    ---------------------------------------------------------------------------

       Storage mode: integer
       Measurement: interval

                Min:   12.000
                Max:  190.000
               Mean:   46.052
           Std.Dev.:   38.686
           Skewness:    1.263
           Kurtosis:    0.565

    ===========================================================================

       average 'The average of value from the aggregated observations'

       "The average value of the aggregated observations, grouped by the
       applicable variables."

    ---------------------------------------------------------------------------

       Storage mode: double
       Measurement: interval

                Min:  -0.998
                Max:   0.974
               Mean:  -0.474
           Std.Dev.:   0.460
           Skewness:   0.351
           Kurtosis:  -0.819

##### Initial statistics about the summarized tidy data set.

``` r
glimpse(dtTidyAvg)
```

    Observations: 14,760
    Variables: 11
    $ subjectID    <fctr> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...
    $ activityName <fctr> laying, laying, laying, laying, laying, laying, ...
    $ domain       <fctr> frequency, frequency, frequency, frequency, freq...
    $ signal_type  <fctr> body, body, body, body, body, body, body, body, ...
    $ sensor       <fctr> accelerometer, accelerometer, accelerometer, acc...
    $ statistic    <fctr> mean, mean, mean, mean, mean, mean, mean, mean, ...
    $ jerk         <fctr> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, T...
    $ magnitude    <fctr> FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE, ...
    $ axis         <fctr> X, Y, Z, NA, NA, X, Y, Z, NA, NA, X, Y, Z, NA, N...
    $ obs          <int> 17, 17, 16, 100, 50, 17, 17, 16, 100, 50, 17, 17,...
    $ average      <dbl> -0.9393346, -0.8368175, -0.9164070, -0.8958446, -...

``` r
headTail(dtTidyAvg, 20, 10, 10)
```

        subjectID     activityName    domain signal_type        sensor
    1           1           laying frequency        body accelerometer
    2           1           laying frequency        body accelerometer
    3           1           laying frequency        body accelerometer
    4           1           laying frequency        body accelerometer
    5           1           laying frequency        body accelerometer
    6           1           laying frequency        body accelerometer
    7           1           laying frequency        body accelerometer
    8           1           laying frequency        body accelerometer
    9           1           laying frequency        body accelerometer
    10          1           laying frequency        body accelerometer
    11          1           laying frequency        body accelerometer
    12          1           laying frequency        body accelerometer
    13          1           laying frequency        body accelerometer
    14          1           laying frequency        body accelerometer
    15          1           laying frequency        body accelerometer
    16          1           laying frequency        body accelerometer
    17          1           laying frequency        body accelerometer
    18          1           laying frequency        body accelerometer
    19          1           laying frequency        body accelerometer
    20          1           laying frequency        body accelerometer
    ...      <NA>             <NA>      <NA>        <NA>          <NA>
    110        30 walking_upstairs      time     gravity accelerometer
    21         30 walking_upstairs      time     gravity accelerometer
    31         30 walking_upstairs      time     gravity accelerometer
    41         30 walking_upstairs      time     gravity accelerometer
    51         30 walking_upstairs      time     gravity accelerometer
    61         30 walking_upstairs      time     gravity accelerometer
    71         30 walking_upstairs      time     gravity accelerometer
    81         30 walking_upstairs      time     gravity accelerometer
    91         30 walking_upstairs      time     gravity accelerometer
    101        30 walking_upstairs      time     gravity accelerometer
        statistic  jerk magnitude axis obs       average
    1        mean FALSE     FALSE    X  17 -0.9393345571
    2        mean FALSE     FALSE    Y  17 -0.8368175429
    3        mean FALSE     FALSE    Z  16 -0.9164069662
    4        mean FALSE     FALSE <NA> 100 -0.8958445953
    5        mean FALSE      TRUE <NA>  50 -0.8617676481
    6        mean  TRUE     FALSE    X  17 -0.9544305535
    7        mean  TRUE     FALSE    Y  17 -0.9067480194
    8        mean  TRUE     FALSE    Z  16 -0.9597127275
    9        mean  TRUE     FALSE <NA> 100 -0.9438443051
    10       mean  TRUE      TRUE <NA>  50 -0.9333003608
    11     stdDev FALSE     FALSE    X  17 -0.9209403441
    12     stdDev FALSE     FALSE    Y  17 -0.7921643902
    13     stdDev FALSE     FALSE    Z  16  -0.882923105
    14     stdDev FALSE     FALSE <NA> 100 -0.8529817734
    15     stdDev FALSE      TRUE <NA>  50 -0.7983009404
    16     stdDev  TRUE     FALSE    X  17 -0.9608811771
    17     stdDev  TRUE     FALSE    Y  17 -0.9196813212
    18     stdDev  TRUE     FALSE    Z  16 -0.9687004525
    19     stdDev  TRUE     FALSE <NA> 100  -0.953795086
    20     stdDev  TRUE      TRUE <NA>  50 -0.9218039756
    ...      <NA>  <NA>      <NA> <NA> ...           ...
    110      mean FALSE     FALSE    X  22   0.935345215
    21       mean FALSE     FALSE    Y  22 -0.2312744914
    31       mean FALSE     FALSE    Z  21 -0.0216597526
    41       mean FALSE     FALSE <NA> 130  0.2258696669
    51       mean FALSE      TRUE <NA>  65 -0.1376278572
    61     stdDev FALSE     FALSE    X  22 -0.9524628955
    71     stdDev FALSE     FALSE    Y  22 -0.9203957264
    81     stdDev FALSE     FALSE    Z  21 -0.8602658643
    91     stdDev FALSE     FALSE <NA> 130 -0.9097738463
    101    stdDev FALSE      TRUE <NA>  65 -0.3274108159

``` r
show(dtTidyAvg)
```

    Source: local data frame [14,760 x 11]
    Groups: subjectID, activityName, domain, signal_type, sensor, statistic, jerk, magnitude [6,120]

       subjectID activityName    domain signal_type        sensor statistic
          <fctr>       <fctr>    <fctr>      <fctr>        <fctr>    <fctr>
    1          1       laying frequency        body accelerometer      mean
    2          1       laying frequency        body accelerometer      mean
    3          1       laying frequency        body accelerometer      mean
    4          1       laying frequency        body accelerometer      mean
    5          1       laying frequency        body accelerometer      mean
    6          1       laying frequency        body accelerometer      mean
    7          1       laying frequency        body accelerometer      mean
    8          1       laying frequency        body accelerometer      mean
    9          1       laying frequency        body accelerometer      mean
    10         1       laying frequency        body accelerometer      mean
    # ... with 14,750 more rows, and 5 more variables: jerk <fctr>,
    #   magnitude <fctr>, axis <fctr>, obs <int>, average <dbl>

#### Sources

<http://vita.had.co.nz/papers/tidy-data.pdf> &lt;- H.Wickham's article describing the concept and application of Tidy datasets.

<https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/> &lt;- Very thoughtful bloke, indeed.

<https://gist.github.com/stevenworthington/3178163> &lt;- function to load specified data files into data.tables with the same name as the originating file.

<http://r.789695.n4.nabble.com/How-do-I-print-a-string-without-the-initial-1-td823144.html> &lt;- print without the annoying \[1\] output.

<http://yihui.name/knitr/> &lt;- Dynamic Documentation at it's best. Integrates smoothly with RStudio and Pandoc.

<http://www.martin-elff.net/knitr/memisc/codebook.html> &lt;- Get it, keep it, love it.
