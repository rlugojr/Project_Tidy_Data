-   [Original Experiment](#original-experiment)
    -   [Human Activity Recognition using Smartphones](#human-activity-recognition-using-smartphones)
    -   [Data Collection Process](#data-collection-process)
    -   [Data Set Information](#data-set-information)
-   [Data Preparation](#data-preparation)
    -   [Analysis](#analysis)
    -   [Loading](#loading)
    -   [Preparation](#preparation)
    -   [Transformation](#transformation)
    -   [Tidy Data Set](#tidy-data-set)
    -   [TidyAvg Data Set](#tidyavg-data-set)
    -   [Tidy Data Codebook](#tidy-data-codebook)
-   [Relevant Papers:](#relevant-papers)
-   [Citations](#citations)
-   [Attributions](#attributions)

<table style="width:8%;">
<colgroup>
<col width="8%" />
</colgroup>
<tbody>
<tr class="odd">
<td><a href="https://github.com/rlugojr/Project_Tidy_Data" class="uri">https://github.com/rlugojr/Project_Tidy_Data</a></td>
</tr>
<tr class="even">
<td>### Project Overview #### Purpose</td>
</tr>
<tr class="odd">
<td>The purpose of this project is to demonstrate applied knowledge of the following:</td>
</tr>
<tr class="even">
<td>1. Retrieve and load a dataset provided by another analyst or team using R. 2. Understand the overall experiment and associated metadata documents in order to design and develop an accurate method for processing the observational data. The ability to gain sufficient knowledge is essential to successful preparation of data in an optimal format and structure for analysis and reporting. 3. Process the data, using the information provided and insight gained, according to the principles of &quot;tidy&quot; datasets. 4. Run validation tests to ensure that the newly processed dataset maintained its integrity through comparison of key meta-statistics with the original dataset. 5. Assure quality of processed data by confirming that no additional data was created or observations omitted, and that the original values were in no way corrupted, modified or lost during conversion. 5. Document all steps, functions and scripts used. 6. Create a Codebook that documents the data processing code and workflow, all variable and value metadata, high level statistics and sample data from the resulting dataset, along with version numbers of any 3rd part software used. 7. Publish the documentation and &quot;tidy&quot; dataset in a format that is easily accessible and ready for analyis.</td>
</tr>
<tr class="odd">
<td>#### Reproducing Results</td>
</tr>
<tr class="even">
<td>The R Script files contained in this repository were designed with the following assumptions:</td>
</tr>
<tr class="odd">
<td>1. The computer you will be using has an active Internet connection. 2. RStudio (preferrably) will be used to run the script files. 3. The required libraries installed and\or loaded. 4. The data achive for the project has not been downloaded. 5. You have set your preferred working directory before running any scripts. 6. The scripts are run in a new session or current session is saved (<strong>IMPORTANT!!! The script run_analyis.R will remove all objects from memory before running! This was meant to ensure that the environment was free of clutter and that no prior versions of the intermediate tables were present in memory. Each run will execute rm(list=ls()) so remove or comment out that line if you do not want this type of behavior from a script!!!</strong>)</td>
</tr>
<tr class="even">
<td>The scripts have been programmed to create a sub-directory named &quot;data&quot;, then download the data ZIP archive and also check the list of package dependencies to install any that may be missing. Once all necessary packages are installed and loaded, data processing will execute and then the codebook is generated. These scripts can be run multiple times since they will not redownload any already available dependencies and data file but will clear the environment and overwrite or replace output files as needed.</td>
</tr>
<tr class="odd">
<td>#### Instructions</td>
</tr>
<tr class="even">
<td><code>1. Clone the repository or download the files into a folder. 2. In R, &quot;setwd()&quot; to the folder containing the repo files. 3. From the R CLI, run &quot;make.R&quot;. 4. Take a deep breathe and exhale on a 5-count. 5. Data processing should be complete. *Files are ready in about 10 seconds, depending on your wrangling rig and Internet connection speed.</code></td>
</tr>
<tr class="odd">
<td>#### More Info</td>
</tr>
<tr class="even">
<td>Continue reading from here to learn about the experiment that generated this dataset or skip to the &quot;Data Preparation&quot; section to get a high level overview of the data preparation methods and results.</td>
</tr>
</tbody>
</table>

### Original Experiment

#### Human Activity Recognition using Smartphones

This experiment was designed to capture data from smartphone sensors in order to create a database which would allow for the automatic recognition of a smartphone user's activities based upon a comparison of said user's device readings against the database of observed readings. Thirty volunteer subjects, aged 19 through 48 years of age, performed six activities (walking, walking\_upstairs, walking\_downstairs, sitting, standing and laying) while wearing a Samsung Galaxy II on their waists. Using the smartphone's embedded accelerometer and gyroscope, the scientists captured triaxial linear acceleration and triangular velocity at a constant rate of 50Hz.

#### Data Collection Process

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, were separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

#### Data Set Information

The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers were included in the "training" data and the remaining 30% in the "test" data.
Overall dataset is comprised of: \* 561-feature vector with time and frequency domain variables and 10,299 observations (no incomplete or missing observations.) \* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. \* Triaxial Angular velocity from the gyroscope. \* Corresponding activity labels. \* A unique identifier assigned to each of the experiment's participants (or subjects)

The dataset used for this project can be retrieved here: [UCI Human Activity Recognition Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

------------------------------------------------------------------------

### Data Preparation

#### Analysis

The dataset and documentation is packaged in a ZIP archive. It contains:

<table>
<colgroup>
<col width="21%" />
<col width="78%" />
</colgroup>
<thead>
<tr class="header">
<th>File Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>README.txt</td>
<td>An overview of the data collection process and equipment used along with a list of files with descriptions.</td>
</tr>
<tr class="even">
<td>Features.txt</td>
<td>Provides detailed information on the experiment, data collection process and the specifics of how the signals captured were mapped into features (one &quot;feature&quot; has compound values, created from the concatenation of certain abbreviations in a specified order.) It also provides</td>
</tr>
<tr class="odd">
<td>features.txt</td>
<td>List of all features (used as column headers for our purposes.)</td>
</tr>
<tr class="even">
<td>activity_labels.txt</td>
<td>Activities table with each activity ID and corresponding activity name.</td>
</tr>
<tr class="odd">
<td>train/X_train.txt</td>
<td>Full Training set.</td>
</tr>
<tr class="even">
<td>train/y_train.txt</td>
<td>Activity ID number associated with each observation (row)</td>
</tr>
<tr class="odd">
<td>test/X_test.txt</td>
<td>Full Test set.</td>
</tr>
<tr class="even">
<td>test/y_test.txt</td>
<td>Activity ID number associated with each observation (row)</td>
</tr>
<tr class="odd">
<td>train/subject_train.txt</td>
<td>Each row identifies the partiipant who performed the activity for each observation. Range is from 1 to 30.</td>
</tr>
</tbody>
</table>

#### Loading

Using R's base function "download.file" and the mode="libcurl" (for cross platform compatibility), the ZIP archive was downloaded to the "./data" directory. <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

Created a vector to hold the ZIP filename (with internal path) for the files to load into tables.

Used unzip() to extract only the files that were needed.

With the help of a cool function found on Github (<https://gist.github.com/stevenworthington/3178163>), passed the filenames vector to the function and it created a data.table for each specified file, named after it's corresponding filename.

#### Preparation

After visually inspecting the files and running a few functions for validation, I started building the main data table. 1. Added header to the 2 "x" tables. 2. Created column names for the other 4 tables. 3. Used cbind() to combine all the train columns into one table. 4. Same for the 'train' data table. 5. rbind() the two tables, train and test. 6. Created a vector to hold the column names that would be kept. This was populated using grep and regex to identify the "mean"| "std""records.

#### Transformation

1.  Used chained dplyr methods and column names vector to select only necessary columns, filter and arrange the table that contains 100% of the observations into a new data.frame.
2.  Used melt() to change the structure of the table.
3.  Created "tidy" data set by using a series of chained methods: select(), a series of mutate() commands to apply grep() statements to separate compund value in the measurements field into their own variables (columns) with meaningful names, another select() to limit columns and finally arrange() to set column and sort order.
4.  Created "tidyAvg" data set, using summzarize(), group\_by for aggregation and then arrange to set column and sort order.

#### Tidy Data Set

This is a glimpse of the first "tidy" data set:

    ##        subjectID     activityName    domain signal_type        sensor
    ## 1              1           laying frequency        body accelerometer
    ## 2              1           laying frequency        body accelerometer
    ## 3              1           laying frequency        body accelerometer
    ## 4              1           laying frequency        body accelerometer
    ## 5              1           laying frequency        body accelerometer
    ## 6              1           laying frequency        body accelerometer
    ## ...         <NA>             <NA>      <NA>        <NA>          <NA>
    ## 679729        30 walking_upstairs      time     gravity accelerometer
    ## 679730        30 walking_upstairs      time     gravity accelerometer
    ## 679731        30 walking_upstairs      time     gravity accelerometer
    ## 679732        30 walking_upstairs      time     gravity accelerometer
    ## 679733        30 walking_upstairs      time     gravity accelerometer
    ## 679734        30 walking_upstairs      time     gravity accelerometer
    ##        statistic  jerk magnitude axis value
    ## 1           mean FALSE     FALSE    X    -1
    ## 2           mean FALSE     FALSE    X -0.99
    ## 3           mean FALSE     FALSE    X -0.99
    ## 4           mean FALSE     FALSE    X -0.99
    ## 5           mean FALSE     FALSE    X -0.99
    ## 6           mean FALSE     FALSE    X -0.99
    ## ...         <NA>  <NA>      <NA> <NA>   ...
    ## 679729    stdDev FALSE      TRUE <NA> -0.17
    ## 679730    stdDev FALSE      TRUE <NA> -0.16
    ## 679731    stdDev FALSE      TRUE <NA> -0.16
    ## 679732    stdDev FALSE      TRUE <NA> -0.16
    ## 679733    stdDev FALSE      TRUE <NA> -0.15
    ## 679734    stdDev FALSE      TRUE <NA> -0.09

#### TidyAvg Data Set

This is a glimpse of the deliverable, summary "tidy" dataset:

    ##     subjectID     activityName    domain signal_type        sensor
    ## 1           1           laying frequency        body accelerometer
    ## 2           1           laying frequency        body accelerometer
    ## 3           1           laying frequency        body accelerometer
    ## 4           1           laying frequency        body accelerometer
    ## 5           1           laying frequency        body accelerometer
    ## 6           1           laying frequency        body accelerometer
    ## ...      <NA>             <NA>      <NA>        <NA>          <NA>
    ## 11         30 walking_upstairs      time     gravity accelerometer
    ## 21         30 walking_upstairs      time     gravity accelerometer
    ## 31         30 walking_upstairs      time     gravity accelerometer
    ## 41         30 walking_upstairs      time     gravity accelerometer
    ## 51         30 walking_upstairs      time     gravity accelerometer
    ## 61         30 walking_upstairs      time     gravity accelerometer
    ##     statistic  jerk magnitude axis obs average
    ## 1        mean FALSE     FALSE    X  17   -0.94
    ## 2        mean FALSE     FALSE    Y  17   -0.84
    ## 3        mean FALSE     FALSE    Z  16   -0.92
    ## 4        mean FALSE     FALSE <NA> 100    -0.9
    ## 5        mean FALSE      TRUE <NA>  50   -0.86
    ## 6        mean  TRUE     FALSE    X  17   -0.95
    ## ...      <NA>  <NA>      <NA> <NA> ...     ...
    ## 11       mean FALSE      TRUE <NA>  65   -0.14
    ## 21     stdDev FALSE     FALSE    X  22   -0.95
    ## 31     stdDev FALSE     FALSE    Y  22   -0.92
    ## 41     stdDev FALSE     FALSE    Z  21   -0.86
    ## 51     stdDev FALSE     FALSE <NA> 130   -0.91
    ## 61     stdDev FALSE      TRUE <NA>  65   -0.33

#### Tidy Data Codebook

### Relevant Papers:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra, Jorge L. Reyes-Ortiz. Energy Efficient Smartphone-Based Activity Recognition using Fixed-Point Arithmetic. Journal of Universal Computer Science. Special Issue in Ambient Assisted Living: Home Care. Volume 19, Issue 9. May 2013

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 4th International Workshop of Ambient Assited Living, IWAAL 2012, Vitoria-Gasteiz, Spain, December 3-5, 2012. Proceedings. Lecture Notes in Computer Science 2012, pp 216-223.

Jorge Luis Reyes-Ortiz, Alessandro Ghio, Xavier Parra-Llanas, Davide Anguita, Joan Cabestany, Andreu CatalÃ . Human Activity and Motion Disorder Recognition: Towards Smarter Interactive Cognitive Environments. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

### Citations

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

### Attributions

Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2) 1 - Smartlab - Non-Linear Complex Systems Laboratory DITEN - UniversitÃ  degli Studi di Genova, Genoa (I-16145), Italy. 2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living Universitat PolitÃ¨cnica de Catalunya (BarcelonaTech). Vilanova i la GeltrÃº (08800), Spain activityrecognition '@' smartlab.ws

<https://gist.github.com/stevenworthington/3178163> &lt;- function to load specified data files into data.tables withe the same name as the originating file.
