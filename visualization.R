# visualization to know more about the spread of the data.
library(ggplot2)

data <- read.csv("baseball_train.csv")
class(data)

unique(data$Playoffs)
ggplot(data, aes(RS,RA, color = Playoffs)) + geom_point()
ggplot(data, aes(RS,OBP, color = Playoffs)) + geom_point()
ggplot(data, aes(RS,SLG, color = Playoffs)) + geom_point()
ggplot(data, aes(RS,BA, color = Playoffs)) + geom_point()

ggplot(data, aes(RA,RS, color = Playoffs)) + geom_point()
ggplot(data, aes(RA,OBP, color = Playoffs)) + geom_point()
ggplot(data, aes(RA,SLG, color = Playoffs)) + geom_point()
ggplot(data, aes(RA,BA, color = Playoffs)) + geom_point()