## load required  libraries
library(dplyr)
library(ggplot2)

## compare the score of anime TV shows anime that isnt a tv show
## null hyothesis: average score is the same
## alternate hypothesis: average score is different
animedata <- dataanime
tv <-  filter(animedata,Type == "TV")
ntv <- filter(animedata,Type != 'TV')


## this should be two tailed because the average score could be the same or one could be lower/higher than the other

t.test(tv$Score,ntv$Score,alternative = "two.sided")
#p value is 5.182e-08, or around 0.0017 (i think)
#  significant
# null rejected, alternate hypothesis accepted

#null hypothesis: the type of anime has no correlation with the 
#score it recieves
#alternate: the type has a correlation with the score
#since there are so many types, find just the top 3 most popular types and find the p scores of that
top3type <- animedata |>
  summarize(.by = Type,
            count = sum(!is.na(Type)))|>
  slice_max(count,n=3)
top3type
top3anime <- filter(animedata, Type %in% top3type$Type)
top3anime
result <- aov(Score~Type,data=top3anime)
summary(result)
TukeyHSD(result)
#p values:
#ova-movie: 0.3686
#tv-movie: 0.0634
#tv-ova: 0.0024
#there is a significant correlation with tv and ova but not with the others


## chi squared test
#null: the type of anime and the source where it comes from is not associated
#alternative: the type and source are associated
t <- table(animedata$Type,animedata$Sources)
results <- chisq.test(t)
results$p.value
#p value of 1.931e-179
#there is a significant association between the type of an anime 
#and the source that its from