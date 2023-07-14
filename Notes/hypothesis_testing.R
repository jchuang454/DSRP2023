## load required  libraries
library(dplyr)
library(ggplot2)

## compare the mass of male and female star wars characters
#3 null hyothesis: average mass is the same
## alternate hypothesis: average mass of male and female characters is different
swHumans <- starwars |> filter(species == "Human", mass>0)
males <- swHumans |> filter(sex=="male")
females <- swHumans |> filter(sex == 'female')

t.test(males$mass,females$mass,paired=F,alternative = "two.sided")
#p value is 0.06
# not significant
# supports our null hypothesis, failed to reject our null hypothesis

## ANOVA #####
iris

anova_results <- aov(data = iris,Sepal.Length ~ Species)
## are any groups different from each other?
summary(anova_results)

## which ones?
TukeyHSD(anova_results)
## all the mean sepal lengths are different

anova_results <- aov(Sepal.Width ~ Species, iris)
summary(anova_results)
TukeyHSD(anova_results)

## is there a significant difference in the mean petal lengths or petal widths by species
anova_results <- aov(Petal.Width ~ Species,iris)
summary(anova_results)
TukeyHSD(anova_results)

### Starwars
head(starwars)
unique(starwars$species)

## which 3 species are the most common?
top3species <- starwars |>
  summarize(.by = species,
            count = sum(!is.na(species))) |>
  slice_max(count,n=3)
top3species

starwars_top3species <- starwars|>
  filter(species %in% top3species$species)

starwars_top3species

##is there a significant difference in the mass of each of hte top 3 species
anova_results <- aov(data=starwars_top3species,mass~species)
summary(anova_results)
TukeyHSD(anova_results)

anova_results <- aov(data=starwars_top3species,height~species)
summary(anova_results)
TukeyHSD(anova_results)

# if we want to compare ctegorical variables we need to do something else
#null hypothesis: category 1 and 2 are independent
#alternaate: category 1 and 2 are not independent (there is an association)
# chi squared statistic
#to get counts per group combination, we can use
con_table <- table(data$var1, data$var2)
# for accurate results, make sure you have 10+ in each group
chisq_results <- chisq.test(con_table)
#to get the significance we can pull out the p value from the results
chisq_results$p.value
chisq_results$residuals
#negative residual means observed<expected
#positive residual means observed>expected
#farther from 0, the greater the difference

## Chi-Squared####
starwars_clean <-starwars|>
  filter(!is.na(species),
         !is.na(homeworld))
View(table(starwars$species,starwars$homeworld))
t <- table(starwars_clean$species,starwars_clean$homeworld)
chisq.test(t)

table(mpg$manufacturer,mpg$class)
table(mpg$cyl,mpg$displ)


#3 how do we get a contingency table of year and drv?
t <- table(mpg$year,mpg$drv)
t
chisq_result <- chisq.test(t)
chisq_result
chisq_result$p.value
chisq_result$residuals
#3 not significant bc p value greater than .05

install.packages("corrplot")
library(corrplot)

corrplot(chisq_result$residuals)
#smaller and lighter it is the closer it is to zero
# bigger and darker it is the closer it is to 1
# blue is positive, red is negative

heros <- heroes_information
head(heros)

## clean data
heros_clean <- heros |>
  filter(Alignment != "-",
         Gender != "-")

## plot the counts of alignment and gender
ggplot(heros_clean,aes(x=Gender,y=Alignment))+
  geom_count()+
  theme_minimal()

## make contingency table
t <- table(heros_clean$Alignment, heros_clean$Gender)
t

## chi squared test
chisq_results <- chisq.test(t)
chisq_results$p.value
chisq_results$residuals

corrplot(chisq_results$residuals,is.cor=F)
#the bigger and redder something is, the less common it is