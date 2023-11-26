library (tidyr)
library (dplyr)
library(ggplot2)
setwd('C:/Users/k_fra/OneDrive/UM-Flint/CSC302/Data')
flights=read.csv('flights.csv',head=T)
head(flights)
flights$year <- as.factor(flights$year)
flights$month <- as.factor(flights$month)
ggplot(flights, aes(x = year, y = passengers, group = month, color = month)) +
  geom_line() +
  labs(title = "Monthly Passenger Count Over the Years",
    x = "Year", y = "Passengers", color = "Month" ) +
  theme_minimal()
