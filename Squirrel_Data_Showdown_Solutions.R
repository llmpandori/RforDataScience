################################################################
# Title: Squirrel Data Showdown
# Purpose: Practice skills in input, tidying & plotting
# Created by: L Pandori & L. Lees
# Created: 4/24/2020
################################################################

# Inspiration: Tidy Tuesday by R for Data Science
# Link: https://github.com/rfordatascience/tidytuesday
# Link to NYC Squirrel Census Dataset Information: https://github.com/rfordatascience/tidytuesday/tree/master/data/2019/2019-10-29

##### Data prep and package upload #####

# Load libraries (add others if you like)
library(tidyverse) 
library(lubridate)

# Load data (copypasta from link)
nyc_squirrels <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-10-29/nyc_squirrels.csv")

# Write a copy for upload practice
write_csv(nyc_squirrels, 'nyc_squirrels2.csv')
remove(nyc_squirrels)
 
##### Squirrel Data Showdown Challenge #####
  # Step 1 -  Load data (practice loading the nyc_squirrels 2 csv)

  nyc_squirrels <- read_csv('nyc_squirrels2.csv')
  
  # Step 2 - Create a date2 column that contains formatted dates
  # How do you check your work?
  
  nyc_squirrels <- nyc_squirrels %>%
    mutate(date2 = mdy(nyc_squirrels$date))
  
  # Step 3 - Separate the original date column into month, day and year? (try without lubridate) and then unite them.

# L. Lees Solution : 
  nyc_squirrels$date <- as.character(nyc_squirrels$date)
  nyc_squirrels$date <- parse_date(nyc_squirrels$date, "%m%d%Y")
  class(nyc_squirrels$date)
  
  #separate date
  date_squirrels<- nyc_squirrels %>%
    separate(date, into = c("year", "month", "day"))
  View(date_squirrels)
  
  #unite date back again
  date_squirrels <- date_squirrels %>%
    unite(date, year:day, sep = "-", remove = TRUE)
  class(date_squirrels$date)
  date_squirrels$date <- parse_date(date_squirrels$date)
  head(date_squirrels)
  
# C. Symons Solution: 
  nyc_squirrels5<-nyc_squirrels %>% 
    separate(date,into = c("month", "dayyear"),sep=2) %>% 
    separate(dayyear,into = c("day", "year"),sep=2) %>% 
    unite(unitedmdy, c("month", "day", "year"), sep="-")
  glimpse(nyc_squirrels5)
  
  class(nyc_squirrels5$unitedmdy)
  nyc_squirrels5$date <- parse_date(nyc_squirrels5$unitedmdy, "%m-%d-%Y")
  glimpse(nyc_squirrels5)
  # Step 4 - Change the location column into 2 separate colunns with the headings 'above ground' and 'ground plane' and make the values logical statements (true/false)
  
# L. Lees Solution
  location_squirrels <- nyc_squirrels%>%
    complete(location) 
  skim(location_squirrels)
  
  location_squirrels$location <- 
    if_else(is.na(location_squirrels$location), 
            "location_unspecified", 
            location_squirrels$location)
  
  location_squirrels <- location_squirrels%>%
    pivot_wider(names_from = location, values_from = location,
                values_fill = list(location="FALSE"))
  
  #change the values to true
  location_squirrels$`Above Ground` <- 
    if_else(location_squirrels$`Above Ground`== "Above Ground", 
            "TRUE", "FALSE")
  
  location_squirrels$`Ground Plane` <- 
    if_else(location_squirrels$`Ground Plane`== "Ground Plane", 
            "TRUE", "FALSE")
  
  location_squirrels$location_unspecified <- 
    if_else(location_squirrels$location_unspecified== "location_unspecified", 
            "TRUE", "FALSE")
  
  View(location_squirrels)
  
  #check type of data
  class(location_squirrels$`Above Ground`)
  class(location_squirrels$`Ground Plane`)
  class(location_squirrels$location_unspecified)
  
  location_squirrels$`Above Ground` <- 
    parse_logical(location_squirrels$`Above Ground`)
  location_squirrels$`Ground Plane` <- 
    parse_logical(location_squirrels$`Ground Plane`)
  location_squirrels$location_unspecified <- 
    parse_logical(location_squirrels$location_unspecified)
  
# C. Symons Solution
  location_squirrels <- nyc_squirrels%>%
    mutate(location2=replace_na(location, "no_location"))
  
  location_squirrels2<-location_squirrels %>% 
    pivot_wider(names_from = location, values_from = location2) %>% 
    mutate(unspecified=recode(`NA`, no_location ="T")) %>% 
    mutate(unspecified=parse_logical(unspecified)) %>% 
    mutate(ground_plane=recode(`Ground Plane`, `Ground Plane` ="T")) %>% 
    mutate(ground_plane=parse_logical(ground_plane)) %>% 
    mutate(above_ground=recode(`Above Ground`, `Above Ground` ="T")) %>% 
    mutate(above_ground=parse_logical(above_ground)) %>% 
    select(-`NA`,-`Above Ground`,-`Ground Plane`)
  
  glimpse(location_squirrels2)
  
# Step 5 - any plot is a success :)
  

