load ('C:/Users/k_fra/OneDrive/UM-Flint/CSC302/Data/house_prices.rda')
library(ggplot2)
library(tidyverse)
library(lubridate)
#1.A
house_prices$year <-format(as.Date(house_prices$date, format="%Y-%d-%m"),"%Y")
df <- house_prices
ggplot(df, aes(x = year, y = house_price_index, color=state)) +
  geom_line() +
  facet_wrap(~ state, nrow=1) + 
  scale_x_discrete(breaks = c('1980','2000','2020'),label=c('80','00','20')) + 
  labs(x = "Year", y = "House Price Index", title = "House Price Index Trend by State")
#1.B

house_prices$year <- format(as.Date(house_prices$date, format="%Y-%d-%m"),"%Y")
house_prices

ggplot(house_prices, aes(x=year, y=house_price_index, color=state)) + 
  geom_line() +
  facet_wrap(~ state, nrow = 1) +
  scale_x_discrete(breaks=c('1980','2000','2020'), labels=c('80', '00', '20'))

#1.C

#2
house_prices$year <- format(as.Date(house_prices$date, format="%Y-%d-%m"),"%Y")
house_prices
house_prices%>%gather(key=measure, value=value, -c(house_price_index, date, state))->house_reshaped

ggplot(house_reshaped, aes(x=date, y=house_price_index, color=state)) + 
  geom_line() +
  facet_wrap(~ state, nrow = 1) +
  scale_x_continuous(breaks = ymd(c("1980-01-01", "2000-01-01", "2020-01-01")), labels = c("80", "00", "20"))

