CleaningProject
===============

This is the Course Project for Getting and Cleaning Data project on Coursera (https://class.coursera.org/getdata-006).

Download the data set from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Unzip the file into your working directory, the contents must go into a "UCI HAR Dataset" sub-directory in your working directory.

    >list.files()
    [1] "UCI HAR Dataset"

Call write\_tidy() function, it should create tidy\_aggds.txt file in the working directory. The file will contain the required tidy data set. The example of commands:

    >source("run_analysis.R")
    >write_tidy()
    >list.files()
    [1] "tidy_aggds.txt" "UCI HAR Dataset"

Look at the CodeBook.txt file for the file format and column descriptions.
