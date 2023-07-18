library(parsnip)
library(rsample)
library(yardstick)
library(dplyr)
library(rsample)
library(xgboost)
library(ranger)
library(Metrics)
library(reshape2)

## collect data
animedata <- dataanime

## clean and process data
newanimedata <- animedata|>
  select(Type,Status,Sources,Rating,Score,
         `Scored by`,Members,Favorites)

newanimedata<- mutate(newanimedata,
                     Type = as.integer(as.factor(Type)),
               Status = as.integer(as.factor(Status)),
               Sources = as.integer(as.factor(Sources)),
               Rating = as.integer(as.factor(Rating)),
               Score = as.integer(Score),
               `Scored by` = as.integer(`Scored by`),
               Members = as.integer(Members),
               Favorites = as.integer(Favorites))
#i had to change the score from a decimal to an integer
# so these predictions will be off

head(newanimedata$Favorites)

cor(newanimedata)

## visualize data
animeCors <- newanimedata |>
  cor()|>
  melt()|>
  as.data.frame()

ggplot(animeCors,aes(x=Var1,y=Var2,fill=value))+
  geom_tile()+
  scale_fill_gradient2(low = "red",high = "blue", mid = "white",
                       midpoint = 0)

ggplot(newanimedata,aes(x= `Scored by`, y= Members))+
  geom_point()+
  theme_minimal()

ggplot(newanimedata,aes(x= Members, y= Favorites))+
  geom_point()+
  theme_minimal()

ggplot(newanimedata,aes(x= Members, y= Type))+
  geom_point()+
  theme_minimal()

# seperate data into train/test sets
reg_split <- initial_split(newanimedata,prop = 0.75)
reg_train <- training(reg_split)
reg_test <- testing(reg_split)

## choose a suitable model
# im going to try linear regression first
lm_fit <- linear_reg() |>
  set_engine("lm")|>
  set_mode("regression")|>
  fit(Members~., data = reg_train)

lm_fit$fit
summary(lm_fit$fit)
#adjusted r squared value of 0.9775, p value of <2.2e-16
reg_results <- reg_test

reg_results$lm_pred <- predict(lm_fit,reg_test)$.pred
rmse(reg_results$Members,reg_results$lm_pred)
mae(reg_results$Members,reg_results$lm_pred)

animeforest_reg_fit <- rand_forest()|>
  set_engine("ranger")|>
  set_mode("regression")|>
  fit(Members~`Scored by`+ Favorites + Rating + Score,data = reg_train) 

results <- reg_test
results$forest_pred <- predict(animeforest_reg_fit,reg_test)$.pred
rmse(results$Members,results$forest_pred)
mae(results$Members,results$forest_pred)
