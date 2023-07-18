ifelse()
case_when()
#saving plots

#3load require packages
library(dplyr)

x <- c(1,3,5,7,9)
ifelse(x<5,"small number", "big number")

head(iris)
mean(iris$Petal.Width)
iris_new <- iris

## add categorical column
iris_new <- mutate(iris_new,
                   petal_size = ifelse(Petal.Width >1,"big","small"))
iris_new

iris_new <- mutate(iris_new,
                   petal_size = case_when(
                     Petal.Width <1 ~ "small",
                     Petal.Width <2 ~ "medium",
                     Petal.Width >= 2 ~ "big",
                     .default ~ NA
                   ))
iris_new

iris_new <- mutate(iris_new,
                   petal_size = case_when(
                     Petal.Width <1 ~ "small",
                     Petal.Width <2 ~ "medium",
                     TRUE ~ "big"
                   ))
iris_new
library(ggplot2)

ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width))+
  geom_point()
ggsave("plots/scatterPlot.png")

## installing new packages
install.packages("tidymodels")
library(parsnip)
library(rsample)
library(yardstick)
install.packages("ranger")
install.packages("xgboost")

## two main types of supervised learning
#classification: assign observations into specific categories
#for example: will it be cold or hot tomorrow
#regression: predict numeric values
# example: whats the temperature going to be tomorrow
#classification groups into classes, regression predicts a numeric value

#steps to training a ml model
#1. collect data
#2. clean/process data (filter out rows/columns, omit na values,
#code categorical variables as numeric integers, normalize numeric values)

### supervised machine learning models ####

### load required packages
library(dplyr)

## step 1: collect data
head(iris)

## step 2: clean and process data
#3 get rid of NAs or set them to the mean
noNAs <- na.omit(starwars)
# only use na.omit when you have specifically selected for the 
# variables you want to include in the model
noNAs <- filter(starwars,!is.na(mass),!is.na(height))

#replace with means
replaceWithMeans <- mutate(starwars,
                           mass = ifelse(is.na(mass),
                                         mean(mass),
                                         mass))
#3 encoding categories as factors or integers
# if categorical variable is a character, make it a factor
intSpecies <- mutate(starwars,
                     species = as.integer(as.factor(species)))
# if categorical variable is already a factor, make it an integer
irisAllNumeric <- mutate(iris,
                         Species = as.integer(Species))

## step 3: visualize data
#3 make a pca
#calculate correlations
cor(irisAllNumeric)
install.packages(reshape2)
library(reshape2)

irisCors <- irisAllNumeric |>
  cor()|>
  melt()|>
  as.data.frame()

ggplot(irisCors,aes(x=Var1,y=Var2,fill=value))+
  geom_tile()+
  scale_fill_gradient2(low = "red",high = "blue", mid = "white",
                       midpoint = 0)
#high correlation?
ggplot(irisAllNumeric,aes(x= Petal.Length, y= Sepal.Length))+
  geom_point()+
  theme_minimal()
# low correlation?
ggplot(irisAllNumeric,aes(x= Sepal.Width, y= Sepal.Length))+
  geom_point()+
  theme_minimal()

#step 4: perform feature selection
# choose which variables you want to classify or predict
# choose which variables you want to use as features in your model
# for iris data...
# classify on species (classification)and predict on sepal.length (regression)
#heart of machine learning

#step 5: seperate data into test/train sets
#you should have at least twice as much training as testing data
#you can also create a seperate validation set that is about 15-25% of the data
library(rsample)

#3 set a seed for reproducability
set.seed(71723)

#3 put 75% of data into the training set
reg_split <- initial_split(irisAllNumeric,prop=.75)
# use the split to form testin gand training sets
reg_train <- training(reg_split)
reg_test <- testing(reg_split)

#3 classification dataset splits (use iris instead of irisallnumeric)
class_split <-initial_split(iris,prop = .75)
  
class_train <- training(class_split)
class_test <- testing(class_split)

#step 6: choose suitable models
#linear regression, logistic regression, boosted decision tree or 
#random forest
#tidymodel structure
#fit <- function_name() |>
#  set_engine("engine_name")|>
#  set_mode("regression" or "classification") |>
#  fit(dependent_var ~ indep_var1 + indep_var2...,
#      data = train_data)
#linear regression: simple, limited to only linear relationships
#ez to understand/interpret, only uses numeric data
#function name is linear_reg(), engine name is "glm" or "lm"

## steps 6 and 7: choose a ml model and train it
#3linear regression
lm_fit <- linear_reg()|>
  set_engine("lm")|>
  set_mode("regression") |>
  fit(Sepal.Length ~ Petal.Length + Petal.Width + Species + Sepal.Width,
      data = reg_train)
lm_fit$fit
#sepal length = 2.3 + Petal.Length*0.7967 + Petal.Width*-0.4067 +
# Species*-0.3312 + Sepal.Width*0.5501
summary(lm_fit$fit)
#closer to 1 the r value is, the closer it is to a linear relationship
#linear regression
#null hypothesis: theres no relationship between the dependent variable and the independent variables
#summar(lm_fit$fit) to look at the significance for each variable

# logistic regression: (fits data to a more flexible function, used when y is 
# a binomial categorical variable, x values can be numeric or categorical)
# 1. filter data to only 2 groups in categorical variable of interest
# 2. make the categoricalv ariable a factor
# 3. make your training and testing splits

# for our purposes we are just going to filter test and training data
# dont do this
binary_test_data <- filter(class_test,Species %in% c("setosa","versicolor"))
binary_test_data <- filter(class_test,Species %in% c("setosa","versicolor"))

log_fit <- logistic_reg()|>
  set_engine("glm")|>
  set_mode("classification")|>
  fit(Species ~ Petal.Width + Petal.Length+., data= class_train)

log_fit$fit
summary(log_fit$fit)

#boosted trees and random forest
# uses a decision tree structure instead of a formula
#used to predict categorical or numerical variables
#less interpretable and more computationally intensive
# function name is boost_tree(), engine name is "xgboost"
#optional parameters: trees (amount of trees, default 15)
#random forest: functionname is rand_forest(), enginename is "ranger
# default 500 trees, minimal node size (default 5 for regression, 10 for classification)

#boosted decision trees
library(xgboost)
library(ranger)
boost_regfit <- boost_tree()|>
  set_engine("xgboost")|>
  set_mode("regression")|>
  fit(Sepal.Length~.,data = reg_train)
boost_regfit$fit

#classification
boost_classfit <- boost_tree()|>
  set_engine("xgboost")|>
  set_mode("classification")|>
  fit(Species ~.,data = class_train)
boost_classfit$fit
boost_classfit$fit$evaluation_log

#3 random forest
# regression
forest_reg_fit <- rand_forest()|>
  set_engine("ranger")|>
  set_mode("regression")|>
  fit(Sepal.Length~.,data = reg_train) #period means everything else

forest_reg_fit$fit
#classification
forest_class_fit <- rand_forest()|>
  set_engine("ranger")|>
  set_mode("classification")|>
  fit(Species~.,data = class_train)
forest_class_fit$fit

## step 8: evaluate model performance on test set
#calculate errors for regression
library(yardstick)
#lm_fit,boost_regfit,forest_reg_fit
reg_results <- reg_test

reg_results$lm_pred <- predict(lm_fit,reg_test)$.pred
reg_results$boost_pred <- predict(boost_regfit,reg_test)$.pred
reg_results$forest_pred <- predict(forest_reg_fit,reg_test)$.pred

mae(reg_results,Sepal.Length,lm_pred)
mae(reg_results,Sepal.Length,boost_pred)
mae(reg_results,Sepal.Length,forest_pred)
# lm pred had lowest error

rmse(reg_results,Sepal.Length,lm_pred)
rmse(reg_results,Sepal.Length,boost_pred)
rmse(reg_results,Sepal.Length,forest_pred)

#calculate accuracy for classification models
class_results <- class_test
install.packages("Metrics")
library(Metrics)

class_results$log_pred <- predict(log_fit,class_test)$.pred_class
class_results$boost_pred <- predict(boost_classfit,class_test)$.pred_class
class_results$forest_pred <- predict(forest_class_fit,class_test)$.pred_class

f1(class_results$Species,class_results$log_pred)
f1(class_results$Species,class_results$boost_pred)
f1(class_results$Species,class_results$forest_pred)
