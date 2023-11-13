setwd('C:/Users/k_fra/OneDrive/UM-Flint/CSC302/Data')
df1=data.frame(Name=c('James','Paul','Richards','Marico','Samantha','Ravi','Raghu',
                      'Richards','George','Ema','Samantha','Catherine'),
               State=c('Alaska','California','Texas','North Carolina','California','Texas',
                       'Alaska','Texas','North Carolina','Alaska','California','Texas'),
               Sales=c(14,24,31,12,13,7,9,31,18,16,18,14))
aggregate(df1$Sales, by=list(df1$State), FUN=sum)
library(dplyr)
df1 %>% group_by(State) %>% summarise(sum_sales = sum(Sales))

#The code above creates a Data Frame containing a columdn for salesmen(Name),
#it then add a column for the state of each saleman(State), and finally a column
#for the sales (Sales).  It then totals the sales by State using different methods
#the first with the aggregate method default in R and second using the dplyr library
#in a more formated method.


library(tidyr)

#2
worldCup=read.csv('WorldCupMatches.csv',
                  header=T)
#2.a

cat(paste('The number of Rows in the Data is ',nrow(worldCup),
          '\nThe Number of Columns in the Data is',ncol(worldCup)))

#2.b
print(summary(worldCup))

#2.c
print(paste("The number of unique Cities is ",count(unique(worldCup['City']))))

#2.d
worldCup %>% summarise(Avg_Attendance=mean(Attendance,na.rm=TRUE))

#2.e
worldCup %>% group_by(Home.Team.Name) %>% 
  summarise(Goals = sum(Home.Team.Goals)) %>% 
  print(n=10)

#2.f
library(ggplot2)
df=worldCup %>% group_by(Year) %>% 
  summarise(Avg_Attendance= mean(Attendance,na.rm=T))
print(df)
ggplot(df, aes(x = Year, y = Avg_Attendance)) +
  geom_line() +
  labs(title = "Attendance Over Time")
#The Attendance data does show an upward trend over the years presented

#3
m_df=read.csv('metabolite.csv',
                  header=T)

#3.a
print(paste('The number of Alzheimer patients is ',
            length(which(m_df$Label == 'Alzheimer'))))
#3.b
print(colSums(is.na(m_df)))

#3.c
m_df_na_dop=m_df[is.na(m_df['Dopamine'])==F,]
dim(m_df_na_dop)

#3.d
m_df_na_dop <- m_df_na_dop %>% 
  mutate(across(c4.OH.Pro,~replace_na(., median(., na.rm=TRUE))))
print(m_df_na_dop)
#3.e
n_df=m_df[, which(colMeans(!is.na(m_df))  > 0.25)]
colnames(n_df)

