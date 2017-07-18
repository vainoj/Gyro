#Combinig train and test data
#Notice: assuming all data files are in the working directory.

#Read train and test data
processFile = function(filepath) {
  con = file(filepath, "r")
  ln <- 0
  DF <- {}
  while ( TRUE) {
    line = readLines(con, n = 1)
    if ( length(line) == 0 ) {
      break
    }
    ln <- ln + 1
    rawLine <- strsplit(line, " ")
    df <- data.frame(matrix(unlist(rawLine)))
    df2 <- df[!(df == "")]
    df3 <- as.numeric(df2)
    DF <- rbind(DF[1:ln-1,], df3)
    print(ln)
  }
  
  close(con)
  return(DF)
}


fpath1 <- "X_train.txt"
fpath2 <- "X_test.txt"

resTrain <- processFile(fpath1)
resTest <- processFile(fpath2)

#Combine train and test data
resComb <- rbind(resTrain, resTest)

#Locate mean() and std() variables
features <- read.table("features.txt")
meanV <- grep("mean", features$V2)
stdv <- grep("std", features$V2)
selectedFeatures <- c(meanV, stdv)

#Select only mean() and std() columns
selectedData <- resComb[,selectedFeatures]

#Read labels
trainLabels <- read.csv("y_train.txt", header = FALSE)
testLabels <- read.csv("y_test.txt", header = FALSE)

#Insert descriptive activity names
v <- c(trainLabels$V1, testLabels$V1)
v[v == 1] <- "WALKING"
v[v == 2] <- "WALKING_UPSTAIRS"
v[v == 3] <- "WALKING_DOWNSTAIRS"
v[v == 4] <- "SITTING"
v[v == 5] <- "STANDING"
v[v == 6] <- "LAYING"

dfSelected <- data.frame(selectedData)
dfSelected <- cbind.data.frame(selectedData, v)

colnames(dfSelected)<-features$V2[selectedFeatures]
colnames(dfSelected)[80] <- "Activity"

# Second data set
#Read subject information
sTrain <- read.csv("subject_train.txt", header = FALSE)
sTest <- read.csv("subject_test.txt", header = FALSE)

vTemp <- c(sTrain$V1, sTest$V1)

newDataset <- dfSelected

#Calculate average for activities                               
temp1 <- colMeans(newDataset[newDataset$Activity == "WALKING",1:79])
temp2 <- colMeans(newDataset[newDataset$Activity == "WALKING_UPSTAIRS",1:79])
temp3 <- colMeans(newDataset[newDataset$Activity == "WALKING_DOWNSTAIRS",1:79])
temp4 <- colMeans(newDataset[newDataset$Activity == "SITTING",1:79])
temp5 <- colMeans(newDataset[newDataset$Activity == "STANDING",1:79])
temp6 <- colMeans(newDataset[newDataset$Activity == "LAYING",1:79])

newDataset <- rbind.data.frame(temp1,temp2, temp3, temp4, temp5, temp6)

#Calculate average for subjects
for (s in (1:30)) {
  temp <- colMeans(dfSelected[vTemp == s, 1:79])
  newDataset <- rbind.data.frame(newDataset, temp)
}


#Set row and col names for the second dataset
row.names(newDataset) <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING", paste("Subject ", 1:30))
colnames(newDataset) <- features$V2[selectedFeatures]

#Write output file for the second data set
write.table(newDataset, file="data2.txt", row.names = FALSE)