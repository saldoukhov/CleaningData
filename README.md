##Getting and Cleaning Data Course Project

###Usage:
	
- Download and unzip the dataset from [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones]() 
- In R, set the working directory to the folder where you uzipped the data set
- Install dplyr and tidyr packages if you haven't installed them previousely
- Load and run run_analysis.R script

This will create a tidy data table from the data set you have downloaded and assign it to a variable called ***tidy***. In addition, it will average the observation across subject, activity and feature (see the code book) and write the resulting file UCI HAR Clean.txt

###How the script works:
In Step 1, script loads the data using read.table and uses cbind and rbind to merge subject(f.e. subject\_train.txt) and activity(f.e. y\_train.txt) data with the observations(f.e. X\_train.txt) and merge test and training datasets into one.

In Step 2, column names are read from the features.txt file and attached to the data set, and subsequently a regular expression is used to drop any column that does not contain ***mean()*** or ***std()*** values

In Step 3, activity labels are read from the activity_labels.txt file and joined with the main dataset. At this point, we can call the dataset tidy

In Step 4, gather function from tidyr package is used to transform the dataset to a narrow form, which is a better fit for subsequent averaging. The result of the Step 4 is assigned to the ***tidy*** variable and can be used for subsequent analysis  

In Step 5, the tidy dataset is grouped using dplyr package and averaged across subject, activity and feature
  

 