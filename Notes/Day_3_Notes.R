## Conditionals ####
x <- 5 
x >3
x < 3
x == 3
x == 5
x != 3 #is x not equal to 3

numbers <- 1:5

numbers < 3
numbers == 3

numbers[1]
numbers[c(1,2)]
numbers[1:2]

numbers[numbers < 3]

#outlier thresholds
lower <- 2
upper <- 4

#combine with | (or)
numbers[numbers< lower | numbers > upper]

#use to get all values between thresholds
numbers[numbers >= lower & numbers <= upper]

#integer(0) means empty vector

## NA values
NA #unknown
NA + 5

sum(1,2,3,NA)
#NA values cause values to be NA
sum(1,2,3,NA,na.rm=T) #removes NA

mean(c(1,2,3,NA),na.rm=T)#pass in as a vector

#3Packages ####
install.packages("ggplot2") #install a package
install.packages(c("usesthis","credentials"))

library(ggplot2) # load required packages
?ggplot2
 

ggplot
#tidyverse is a group of packages for data visualization

#plots have a title, x and y axis
#parts of a graphical sentence include the data being ploted
#geometric objects (circls,lines) that appear on the plot
#a set of mappings from the variables in the data to
#the aesthetis (appearence) of the objects

#aes = aesthetic
ggplot(data = dataset, aes(x=column_name1,y=column_name2))+
  geom_plotType()+
  labs(title= "title",
       x = "x-axis",
       y = "y-axis")

## mpg dataset
str(mpg)
?mpg

ggplot(data = mpg, aes(x=hwy, y = cty)) +
  geom_point() +
  labs(title="car city vs highway milage",
  x = "highway mpg",
  y = "city mpg")

## Histogram
##just shows one variable and how often it occurs
#histograms are used to plot the frequency of 1 numeric variable
# geom_histogram, only one variable

ggplot(data = mpg, aes(x=hwy))+
  geom_histogram()

ggplot(data= iris, aes(x=Sepal.Length))+
  geom_histogram(bins=50)

ggplot(data = iris, aes(x=Sepal.Length))+
  geom_histogram(bins=5)

ggplot(data = iris, aes(x=Sepal.Length))+
  geom_histogram(binwidth = .25)

head(iris)
#default bins is 30

##Density plot
#helps show spread of the data

ggplot(data = iris, aes(x=Sepal.Length))+
  geom_density()
#y is optional, x must be a numeric variable
# y=after_stat(count), means y is count of data

#3 boxplot
#tells us about the middle 50% of the data

ggplot(data = mpg, aes(x=hwy))+
  geom_boxplot()

ggplot(data = iris, aes(x=Sepal.Length))+
  geom_boxplot()

ggplot(data = iris, aes(y=Sepal.Length))+
  geom_boxplot()

ggplot(data = iris, aes(x = Sepal.Length,y=Species))+
  geom_boxplot()

##violin plot
#like a density plot
#used to plot a numeric variable by a categorical variable
#used to show conditional distribution
ggplot(data = mpg, aes(x= class, y= hwy))+
  geom_violin()

ggplot(data = iris, aes(x = Sepal.Length, y=Species))+
  geom_violin()

ggplot(data= iris, aes(x = Species, y = Sepal.Length))+
  geom_violin() + geom_boxplot(width = 0.2)+
  labs(title = "Distribution of Iris Sepal 
       Lengths by Species",
       x = "Species",
       y = "sepal Length")

#3 colors
#657 built in color names
#can use hex codes or color palettes

ggplot(data= iris, aes(x = Species, y = Sepal.Length))+
  geom_violin(color="blue",fill="purple") +
  geom_boxplot(width = 0.2)

## Bar plot
#distribution of one categorical variable 
#or 1 numeric vs 1 categorical

ggplot(data = mpg, aes(x = class))+
  geom_bar()

ggplot(data = mpg, aes(x = class, y = hwy))+
  geom_bar(stat="summary",
           fun = "mean")
#to use a numeric variable for x we have to use stat= "summary" in geom_bar()
ggplot(data = iris, aes(x = Species, y = Sepal.Length, fill = Species))+
  geom_bar(stat = "summary",
           fun = "mean")
## Scatter plot
# 1 numeric vs 1 numeric or 1 numeric vs 1 categorical
# best to do 2 numeric
ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width))+
    geom_point()  

ggplot(data = iris, aes(x = Species, y = Sepal.Length))+
  geom_jitter()  
#use jitter to spread out points when doing
# one numeric by one categorical

ggplot(data = iris, aes(x = Species, y = Sepal.Length))+
  geom_jitter(width=0.2)  

## Line plot
#like scatterplot except we reduce it to a line
#1 numeric vs 1 numeric
#can only have one y vlaue per x value

ggplot(data = mpg, aes(x = hwy, y = cty))+
  geom_line(stat = "summary",
            fun = "mean")

ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width))+
  geom_point()+
  geom_line()
## dont do this
#do summary and mean so theres one point per length

ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width))+
  geom_point()+
  geom_smooth()

ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width))+
  geom_point()  +
  geom_smooth()+
  theme_dark()

ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width))+
  geom_point(aes(color = Species))+
  scale_color_manual(values=c("violet","lightblue","red"))

## factors
mpg$year <- as.factor(mpg$year)

iris$Species <- factor(iris$Species,level=c("versicolor","setosa","virginica"))
