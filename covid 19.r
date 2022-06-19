install.packages('ggrepel')
install.packages('tidyverse')
library(ggrepel)
library(ggplot2)
library(tm)
library(wordcloud)
library(plyr)
library(syuzhet)
library(lubridate)
library(tidyverse)
dataset <- read.csv('D:/covid proj  dataset/owid-covid-data.csv')


plot_date <- '2021-01-19'
plot_title <- paste('Percentage of Population Vaccinated as Reported', plot_date, sep=" ")

# Manipulate Data
glimpse(dataset)
dataset <- dataset %>% 
  mutate(date = as.Date(date)) %>% 
  filter(date == plot_date) %>% 
  select(location, total_vaccinations_per_hundred, gdp_per_capita) 
dataset



# Find World Rate
world <- dataset$gdp_per_capita[which(dataset$location == 'World',)]


# Drop NAs 
dataset <- dataset %>% drop_na

# Plot Base
plot_base <- ggplot(data = dataset, aes(x=total_vaccinations_per_hundred, y=gdp_per_capita)) + 
  geom_point(color = "#00AFBB") + xlab('Percentage of Population Vaccinated') + 
  ylab('GDP Per Capita') + 
  theme_economist() + 
  ggtitle(plot_title) +
  geom_hline(yintercept=world, linetype="dashed", color = "red")

# Plot Using Geom_Text
plot_base + geom_text(aes(label=location)) 

# Plot Using Geom Text Repel
plot_base + geom_text_repel(aes(label=location),arrow = arrow(length = unit(0.005, "npc"))) 
