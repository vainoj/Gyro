#Combinig train and test data
#Notice: assuming all data files are in the working directory.


fpath1 <- "X_train.txt"
fpath2 <- "X_test.txt"

resTrain <- read.table(fpath1)
resTest <- read.table(fpath2)

resTrain <- apply(resTrain, 2, as.numeric)
resTest <- apply(resTest, 2, as.numeric)
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
newDataset <- cbind.data.frame(newDataset, vTemp)
colnames(newDataset)[81] <- "Subject"


finalDataset <- newDataset
count1 <- 0
for (i in 1:30) {
  for (j in 1:6) {
    if (j == 1)
      s <- "WALKING"
    if (j == 2)
      s <- "WALKING_UPSTAIRS"
    if (j == 3)
      s<- "WALKING_DOWNSTAIRS"
    if (j == 4)
      s <- "SITTING"
    if (j == 5)
      s <- "STANDING"
    if (j ==6 ) 
      s <- "LAYING"
    #print(paste(i, " ",s))
    count1 <- count1 + 1
    finalDataset[count1,1:79] = colMeans(newDataset[newDataset$Activity == s & newDataset$Subject == i,1:79])
    finalDataset[count1, 80] = s
    finalDataset[count1, 81] = i
    
  }
}

#filter out extra lines
finalDataset <- finalDataset[1:(30*6),]


#Write output file for the second data set
write.table(finalDataset, file="data2.txt", row.names = FALSE)