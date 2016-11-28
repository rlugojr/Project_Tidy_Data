#Tidy data "Make" script
#Project Tidy Data - make.R
#Getting and Cleaning Data
#by Ray Lugo, Jr.
#2016-11-25

#make.R orchestrates the entire dataset processing, codebook object generation and the rendering of all MD files.
#with one script, all work is completed in about 15 seconds, including dataset download, on my personal workstation.
#(although your mileage may vary depending on your compute resources and Internet bandwidth.)

#running the scripts from a main script also gives the benefit of sharing the environment space without having to create and manage one specifically.
#this is also useful for running ad-hoc items in the console or GUI since the objects will be available.

#NOTE: run_analysis.R does a lot of "garbage collection" to remove objects and free memory as it processes.  When initiated,
#the first command is RM(list=ls()) so please be sure to run this in a new session or save and close your current work so as not to lose any other data.


#The purpose of "make.R" is to run the following scripts in series:
#1. run_analyis.R
#2. build_codebook.R
#3. render README.Rmd
#4. render run_analysis.Rmd
#5. render codebook.Rmd




source(file = "run_analysis.R", verbose = TRUE, keep.source = TRUE)
source(file = "build_codebook.R", verbose = TRUE, keep.source = TRUE)


library(rmarkdown)
library(knitr)

render("README.Rmd")
render("run_analysis.Rmd")
render("codebook.Rmd")
