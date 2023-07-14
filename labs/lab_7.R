## load required  libraries
library(dplyr)

## compare the score of anime TV shows anime that isnt a tv show
#3 null hyothesis: average score is the same
## alternate hypothesis: average score is different
animedata <- dataanime
tv <-  filter(animedata,Type == "TV")
ntv <- filter(animedata,Type != 'TV')


## this should be two tailed because the average score could be the same or one could be lower/higher than the other

t.test(tv$Score,ntv$Score,alternative = "two.sided")
#p value is 5.182e-08, or around 0.0017 (i think)
# not significant
# null rejected, alternate hypothesis accepted