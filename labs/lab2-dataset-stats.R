getwd() #get working directory
data <- read.csv("dataanime.csv")
head <- dataanime.head()
head

score <- dataanime$Score
mean = mean(score)
mean
median<- median(score)
median
range <- max(score)-min(score)
range
variance = var(score)
variance
standarddeviation = sd(score)
standarddeviation
iqr = IQR(score)
iqr

lower <- mean(sl) - 3*sd(sl)
upper <- mean(sl) + 3*sd(sl)
lower
upper
values <- c(score)
values
outliers <- values[values<lower & values>upper]

test <- c(2,9,score,10)
mean <- mean(test)
mean
median <- median(test)
median
