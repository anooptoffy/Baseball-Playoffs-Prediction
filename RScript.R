library(ggplot2)
setwd("~/Desktop/Assignment upgrad/Baseball-Playoffs-Prediction/")

data <- read.csv("baseball_train.csv")
class(data)

train <- data[,c("Team","RS","RA","OBP","SLG","BA")]
cls <- data[,c("Team","Playoffs")]

head(train)
head(cls)

unique(data$Playoffs)
ggplot(data, aes(RS,RA, color = Playoffs)) + geom_point()
ggplot(data, aes(RS,OBP, color = Playoffs)) + geom_point()
ggplot(data, aes(RS,SLG, color = Playoffs)) + geom_point()
ggplot(data, aes(RS,BA, color = Playoffs)) + geom_point()

ggplot(data, aes(RA,RS, color = Playoffs)) + geom_point()
ggplot(data, aes(RA,OBP, color = Playoffs)) + geom_point()
ggplot(data, aes(RA,SLG, color = Playoffs)) + geom_point()
ggplot(data, aes(RA,BA, color = Playoffs)) + geom_point()

ggplot(data, aes(RS, RA, BA, color = Playoffs)) + geom_point()

# splitting to training and testing data set for the known samples given
train_size <- floor(0.75 * nrow(data))
set.seed(234)
train_index <- sample(seq_len(nrow(data)), size = train_size)
train <- data[train_index, ]
test <- data[-train_index, ]

#predictM <- lm(Playoffs ~  OBP + SLG + BA, data = train)
predictM <- lm(Playoffs ~  RS + RA + OBP + SLG + BA, data = train)
summary(predictM)

prediction <- predict(predictM, newdata = test)
head(prediction)
head(test$Playoffs)
mean(prediction)

prediction[prediction < mean(prediction)] <- round(0)
prediction[prediction > mean(prediction)] <- round(1)
prediction[prediction < mean(prediction)] <- round(0)
prediction[prediction > mean(prediction)] <- round(1)

head(prediction)

SSE <- sum((test$Playoffs - prediction)^2)
SST <- sum((test$Playoffs - mean(test$Playoffs))^2)
1 - SSE/SST
library(caret)
result <- confusionMatrix(prediction, test$Playoffs)
result
unique(prediction)
length(prediction)
