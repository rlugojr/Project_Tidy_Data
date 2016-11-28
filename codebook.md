-   [Codebook Description](#codebook-description)
-   [Overview of the original dataset.](#overview-of-the-original-dataset.)
-   [Data Processing Method](#data-processing-method)
-   [Overview of run\_analysis.R](#overview-of-run_analysis.r)
-   [Link to step-by-step commented documentation of run\_analysis.R](#link-to-step-by-step-commented-documentation-of-run_analysis.r)
-   [Initial Tidy data set.](#initial-tidy-data-set.)
-   [Summarized Tidy data set](#summarized-tidy-data-set)
    -   [Listing of Variables](#listing-of-variables)
    -   [Detailed Variable Information](#detailed-variable-information)
    -   [Initial statistics about the summarized tidy data set.](#initial-statistics-about-the-summarized-tidy-data-set.)
    -   [Sources](#sources)

### Codebook Description

This codebook provides details on:

-   Overview of the original dataset.
-   Data processing method.
-   Overview of run\_analysis.R
-   Link to step-by-step commented documentation of run\_analysis.R
-   Overview of the initial Tidy data set.
-   Overview of the Summarized Tidy data set
-   Data Dictionary of all variables in the summarized Tidy dataset.
-   Initial statistics about the summarized tidy data set.

### Overview of the original dataset.

### Data Processing Method

### Overview of run\_analysis.R

Short, high-level description of what the cleaning script does.

### Link to step-by-step commented documentation of run\_analysis.R

[link to the readme document that describes the code in greater detail]()

### Initial Tidy data set.

### Summarized Tidy data set

UCI\_Analysis\_Summary\_Tidy - Tidy, agreggated, perfect dataset.

r paste0(code.book.dtTidyAvd.wording, "")

#### Listing of Variables


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

#### Detailed Variable Information

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

#### Initial statistics about the summarized tidy data set.

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

#### Sources

<https://gist.github.com/stevenworthington/3178163> &lt;- function to load specified data files into data.tables withe the same name as the originating file.
