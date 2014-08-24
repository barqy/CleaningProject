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

Description of the process:
The resulting aggregated data set is created from "train" and "test" datasets in corresponding directories.
For instance, in "test" data set the data is stored in X\_test.txt file. 
Its columns are features as per features.txt file, 561 columns in total.
We need only those columns which have mean() or std() in the feature names.

The rows in the data set correspond to the subject and activity, which are in subject\_test.txt and y\_test.txt files.
These files are merged with the data set, so that subject and activity columns are puplated in a long data set.
The activities are given by their ids, so we replace them by match merging them with activity\_labels.txt file.

Finally, we merge train and test data into one long data set with subject numbers and activity names, which has only the
features we selected (means and stds). So, we aggregate this set by subject and acrivity, and write into a resulting file.
