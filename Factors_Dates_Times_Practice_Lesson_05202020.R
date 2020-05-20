################################################################
# Title: Factors, Dates & Times in R Lesson
# Purpose: Practice skills in using dates and times and forcats
# Created by: L Pandori
# Created: 5/20/2020
################################################################

##### Data prep and package upload #####
# load libraries
library(tidyverse) 
library(lubridate)
library(nycflights13)

# load data (copypasta from link)
impacts <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-07-23/wildlife_impacts.csv")

##### Q1 #####
# Plot which ariline operator has the highets count of bird strikes. Order the factors from lowest to highest # of strikes

# summary data
impact_summary <- impacts %>%
  group_by(operator) %>%
  summarize(
    n = length(state))

ggplot(data = impact_summary) + 
  geom_col(mapping = aes(x = fct_reorder(operator, n), y = n)) 

#### Q2  #####
# separate incident date into 3 separate columsn: month, day, year (in correct format)

impacts <- mutate(impacts, 
         month = month(incident_date),
         day = day(incident_date),
         year = year(incident_date))

##### Q3 #####
# Bird casualty plot by season 

ggplot(data = impacts) + 
  geom_bar(mapping = aes(x = quarter(incident_date)))

##### Q4 #####
# Create a plot to share (are there more strikes on days of the week with higher #'s of flights?)

  # summarize nycflights13 and impacts for same date range
  
  min(impacts$incident_date)
  max(impacts$incident_date)
  
  parse_date(flights, c(year,month,day))

  flights$date <- as_date(paste(flights$year, flights$month, flights$day, sep = '-'))
 