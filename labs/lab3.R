ggplot(data = dataanime, aes(x = Score, fill = Type))+
  geom_histogram()+
  labs(title="Anime by Score",
       x = "Score",
       y = "# of shows")

#numeric vs categorical
ggplot(data = dataanime, aes(x= Rating, y = Score))+
  geom_jitter()+
  labs(title="Score by Rating",
       x="Rating",
       y="Score")


#numeric vs numeric

ggplot(data= dataanime, aes(x = Favorites, y= Score))+
  geom_jitter()
  #labs(title="Score by episodes",
   #    x="Score",
    #   y = "Episodes")
