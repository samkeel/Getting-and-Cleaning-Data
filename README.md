#Getting and cleaning data course project
This directory is for the AGetting and Cleaning Data Coursera course project hosted through John Hopkins University.

#####Objectives
run_analysis.R performs the following:
- Merges the training and the test data to create a single dataset.
- Extracts only the mean and standard deviation measurements.
- Uses descriptive activity names and labels in the dataset
- Creates a second, independant tidy data set with the average of each variable and activity.

#####Functions
- Set the users working directory
- Download the data file as a zip file
- Unzips the files
- Loads the training and test data
- Combines the two sets of data into a single dataframe using rbind
- Extracts the mean and standard deviation from the combined dataset using grep
- Applies approriate column names
- For consistentcy the column names are converted to lowercase 
- Exports a single dataframe to the working directory in a text file named "averagesData.txt"
- Exports a second tidfy dataframe text file to the working directory named "averages.txt" that contains averages for each subject and activity.

*Note that there has been no assumptions on number of records, only the location of the files.*
