# set the working directory
setwd("~/Desktop/Assignment upgrad/Baseball-Playoffs-Prediction/")
library(ggplot2)
library(caret) # used for building the confusion matrix

# read the data frame
data <- read.csv("baseball_train.csv")

# splitting to training and testing data set for the known samples given to train
train_size <- floor(0.75 * nrow(data))
set.seed(721)
train_index <- sample(seq_len(nrow(data)), size = train_size)
train <- data[train_index, ]
test <- data[-train_index, ]

# using Linear Regression. Perfoming line fitting
#predictM <- lm(Playoffs ~  OBP + SLG + BA, data = train)
predictM <- lm(Playoffs ~  RS + RA + OBP + SLG + BA, data = train)
summary(predictM)

# prdicting using the linear model
prediction <- predict(predictM, newdata = test)

prediction[prediction < mean(prediction)] <- round(0)
prediction[prediction > mean(prediction)] <- round(1)
prediction[prediction < mean(prediction)] <- round(0)
prediction[prediction > mean(prediction)] <- round(1)

# checking the result using confusion matrix
# having an accuracy of 72.69% at seed(721)
result <- confusionMatrix(prediction, test$Playoffs)
result

# using the linear model to predict unkown playoffs label.
unknow <- read.csv("baseball_unknown.csv")
predictunknown <- predict(predictM, newdata = unknow)
predictunknown[predictunknown < mean(predictunknown)] <- round(0)
predictunknown[predictunknown > mean(predictunknown)] <- round(1)
predictunknown[predictunknown < mean(predictunknown)] <- round(0)
predictunknown[predictunknown > mean(predictunknown)] <- round(1)

predictunknown
unknow$Playoffs <- predictunknown
# saving the result
write.csv(file = "unknown_playoffs.csv", x = unknow)
