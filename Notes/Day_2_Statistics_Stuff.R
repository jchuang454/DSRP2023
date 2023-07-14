View(iris)
#iris data set, same as one from gstem i think

sepal5 <- iris[1:5,1]
sepal5
first5 <- iris$Sepal.Length[1:5]
first5

#Statistics ####

#data about data
#statistics are calculations which alow us to describe
#trends, identify typical values and notice potential
#irregularities

#Mean: average of the dataset
mean(first5)
mean(iris$Sepal.Length)

#Median: middle value
median(first5)
median(iris$Sepal.Length)

#Range: span of the dataset, max-min
range <- max(first5) - min(first5)
range
range(first5) #returns 4.6 5.1
range <- max(iris[,1]-min(iris[,1]))
range

#variance: a measure of the variation in the dataset
#higher number means the data is more spread out
variance = var(first5)
variance
variance = var(iris$Sepal.Length)
variance

#standard deviation: a measure of the spread of values in the dataset
sdd = sd(first5)
sdd

#interquartile range 
#q1 is median of lower half
#q3 is median of upper half
#like box plots

IQR(first5)#range of the  middle 50% of data
quantile(first5,0.25)
quantile(first5,0.75)

#outliers are extreme values in a dataset
#multiple outlier thresholds

threshold = mean(iris$Sepal.Length)+3*sd(iris$Sepal.Length)
threshold

sl <- iris$Sepal.Length

lower <- mean(sl) - 3*sd(sl)
upper <- mean(sl) + 3*sd(sl)

as.numeric(quantile(sl,0.25) - 1.5*IQR(sl))
quantile(sl,0.75) + 1.5*IQR(sl)

#3subsetting vectors
first5
first5 < 4.75
first5[first5 < 4.75]

values <- c(first5, 3,9)
upper
lower

#removes outliers
values[values>lower & values<upper]
#keep values lower than upper and higher than lower

