#set working directory
  setwd("~/R/dataClean/data")
#load library
  library(plyr)

#merge the training and the test sets to create one data set 
  #-trainging data
  xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
  yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
  subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
  #-test data 
  xTest <- read.table("UCI HAR Dataset/test/X_test.txt")
  yTest <- read.table("UCI HAR Dataset/test/y_test.txt")
  subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")

  #-combine the training and test data
  xData <- rbind(xTrain,xTest)
  yData <- rbind(yTrain, yTest)
  subjectData <- rbind(subjectTrain, subjectTest)

#extract only measurements on the mean and standard deviation for each measurement 
  features <- read.table("UCI HAR Dataset/features.txt")
  mean_good_features <- grep("-(mean|std)\\(\\)",features[,2])
  xData <- xData[, mean_good_features]	
  names(xData) <- features[mean_good_features,2]
  names(xData) <- gsub("\\(|\\)","",names(xData))
  names(xData) <- tolower(names(xData))

#Use descriptive names for the activity set
  activities <- read.table("UCI HAR Dataset/activity_labels.txt")
  activities[,2] = gsub("_","", tolower(as.character(activities[,2])))	
  yData[,1] <- activities[yData[,1],2]
  names(yData) <- "activity"

#Labels
  names(subjectData) <- "subject"
  allData <- cbind(xData, yData, subjectData)
  averagesData <- ddply(allData, .(subject, activity), function(x) colMeans(x[, 1:66]))
  write.table(averagesData, "averagesData.txt", row.name=FALSE)

#create a second dataset with the averages of each variable for each activity 
  average <- aggregate(x=allData, by=list(activities=allData$activity, subjectData=allData$subject), FUN=mean)
  average <- average[, !(colnames(average) %in% c("subjectData","activity"))]
  write.table(average, "averages.txt", row.name=FALSE)
