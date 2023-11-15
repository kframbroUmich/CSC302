#MidTerm Data File
#set working directory and load file
setwd("C:/Users/k_fra/OneDrive/UM-Flint/CSC302/Data/FBALL")
allGames=read.csv("weather_20131231.csv",head=TRUE)
#load all libraries
library(dplyr)
library(ggplot2)
#read data and setup dataframes
allGames <- allGames %>%
  mutate(winner = ifelse(home_score > away_score, "Home", "Away"))
detHomeGames=select(filter(allGames,home_team=='Detroit Lions'),id,away_team,
                    home_score,temperature,date,winner)
detAwayGames=select(filter(allGames,away_team=='Detroit Lions'),id,home_team,
                    away_score,temperature,date,winner)
detHomeGames <- detHomeGames %>% rename("team"="away_team","score"="home_score")
detAwayGames <- detAwayGames %>% rename("team"="home_team","score"="away_score")
detHomeGames['type']='home'
detAwayGames['type']='away'
detGames <- rbind(detAwayGames,detHomeGames)
detGames = detGames %>%
  group_by(type,temperature) %>%
  summarise(score = mean(score))

# Calculate the correlation coefficient
correlation <- cor(detGames$temperature, detGames$score)

#ggplot(df_Aggr, aes(x = temperature, y = score,group="type")) +geom_point(stat = "summary", fun = "mean")
#  geom_point(stat = "summary", fun = "mean")

#create scatterplot with regression line and proper titles
ggData<-ggplot(detGames, aes(x = temperature, y = score,group="type"))+
  geom_point(aes(col=type), size=3)+
  labs(title="Avg. Points vs Temperature", 
       subtitle=paste("From all Detroit Lions Games(Correlation =", round(correlation, 2),")"),
       y="Points Scored", x="Game Temperature (°F)",color="Game Type",
       caption="Lions Weather Data (1960-2013)")+
  scale_x_continuous(breaks=seq(0, 100, by=10))+
  scale_y_continuous(breaks=seq(0,50,by=5))+
  geom_smooth(method = lm, se = FALSE, fullrange = TRUE)+
  theme(plot.title=element_text(hjust=0.5),plot.subtitle=element_text(hjust=0.5))

#plot Data
plot(ggData)

#save Plot to hard drive
ggsave('mid01.png')
    