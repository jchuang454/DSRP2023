2+2

number <- 5
number
number + 1
number <- number + 1
number

#this is a comment 
number <- 10 #fox
number

#header with 4 pound signs ####

# R Objects ####
number <- 5
ls() #print the name of all objects
rm(object) #removes object(s)

decimal <- 1.5
letter <- "a"
word <- "hello"
logic <- TRUE
logic2 <- T
logic3 <- F
#if you highlight part of a line it only runs the
#highlighted part
ls()

## types of variables
class(number) #numeric
class(decimal)
class(letter) #character
class(word)
class(logic)#logical

## more variation in types
typeof(number)
typeof(decimal)

##we can change th etype of an obbject
as.character(number)
as.integer(number)
as.integer((decimal))

## rounding numbers
round(decimal) #rounds up or down
22/7 #3.142857
round(22/7)
?round
round(22/7,3) #to 3 decimal points

ceiling(22/7) #ceiling always rounds up
floor(22/7) #floor always rounds down

?as.integer
word_as_int <- as.integer("hello") # NA object

## NA Values
NA + 5

## naming
name <- "Sarah"
NAME <- "Joe"
n.a.m.e <-"Sam"
n_a_m_e <- "lisa"

#3 illegal naming characters
n+ame <- "Paul" #operators: + 1 / *
3name <- "e" #starting with a number
#conditionals: & | < > !
,name <- "test" #undeerscore, comma, etc

##good naming conventions
camelCase <- "start with capital letter"
snake_case <- "underscores between words"

##Object manipulation
number + 7
decimal
number + decimal

name
paste(name,"Parker") #concatenates character vectors
paste("Fox","says","hi")
paste0("fox",":)")#no space
paste(name,number)
logic <- T
paste0(name,logic)

paste("Fox","ate",x,"chips and said", word)

?grep
#food <- "Watermelon"
#grepl("me",food) #is the pattern in the character robject
#sub("me","you",food)
#food <- "watermelon"
#sub("me","fox",food)
#sub("me","",food)

animal <- "bigfox"
sub("big","cute",animal)
#plus sign in console means needs more info
#can press escape to return to > prompt

## Vectors ####
#make a vector of numerics
numbers <- c(2,4,6,8,10)
range_of_vals <- 1:5 #all integers form 1 to 5
5:10 #all ints from 5 to 10
seq(2,10,2) #from 2 to 10 by 2s
seq(from =2 , to = 10, by = 2)
seq(by=2,from=2,to=10)# can put parameters out of order if named
seq(1,10,2) #odd numbers between 1 and 10

rep(3,5)
rep(c(1,2),5) #repeating the entire vector 5 times

#make a vector of characters
letters <- c("a","b","c")
letters
paste("a","b","c") #paste is different from c()

letters <- c(letters,"d")
letter
letters <- c(letters,letter)
letters
letters <- c("x",letters,"w")
letters

n <- ame <- "test"
n
n=ame <- "test"
n

#get all the values between 1 and 5 by 0.5
seq(1,5,0.5)
seq(from=1,to=5,by=0.5)

#how do we get [1 1 1 2 2 2]
?rep
c(rep(1,3),rep(2,3))
rep(c(1,2), each=3)

#make a vector of random numbers between 1 and 20
c(seq(1,20,1))
numbers <- 1:20
five_nums <- sample(numbers,5)#choose 5 random nums
five_nums

five_nums <- sort(five_nums)
rev(five_nums) #reverse order

fifteen_nums <- sample(numbers,15, replace = T)
sort(fifteen_nums)
length(fifteen_nums) # length of a vector
unique(fifteen_nums)#unique values

#how do we get the number of unique values?
length(unique(fifteen_nums))

table(fifteen_nums)#get the count of the values in the vector

fifteen_nums+5
fifteen_nums/2

nums1 <- c(1,2,3)
nums2 <-c(4,5,6)
nums1+nums2

nums3 <- c(nums1,nums2)
nums3
nums3+nums1
#1+1,2+2,3+3,1+4,2+5,6+3 
# values are recycled to add together
#when lengths are different

nums3+1
sum(nums3)

#Vector indexing
numbers
numbers[1]
numbers[5]
numbersrev <- rev(numbers)
numbersrev[1]
#note: this index starts at 1 not 0
numbersrev[1:5]
numbersrev[c(1,5,2,6)]
i <- 5
numbers[i]

#Datasets ####
?mtcars
#every row is an observation, every column is a variable
mtcars #print entire dataset into console

View(mtcars) #open in new window
#it can be hard to view if its rlly big

summary(mtcars) #gives summary of dataset
#tells name of every variable and some statistics
str(mtcars) #for structure of dataset

names(mtcars)#names of variables
head(mtcars) #variables and first 6 rows
head(mtcars,3)

#3pull out individual variables as vectors
mpg <- mtcars[,1]
mpg
mtcars[2,2]#second row, second column
mtcars[3,] #3rd row only

#first 3 columns
mtcars[,1:3]

#use the names to pull out characters
mtcars$gear #use dollar sign to select columns
mtcars[,c("gear","mpg")] #pull out gear and mpg columns

sum(mtcars$gear)

####Iris dataset ####
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
c
values <- c(first5, 3,9)
upper
lower

#removes outliers
values[values>lower & values<upper]
#keep values lower than upper and higher than lower

## read in data
getwd() #get working directory
read.csv("")
