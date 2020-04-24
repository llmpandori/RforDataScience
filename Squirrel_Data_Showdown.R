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
#Clear workspace
rm(lists=ls())

# Load libraries (add others if you like)
library(tidyverse) 

# Load data (copypasta from link)
nyc_squirrels <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-10-29/nyc_squirrels.csv")

# Write a copy for upload practice
write_csv(nyc_squirrels, 'nyc_squirrels2.csv')

##### Skills Practice (upload, tidy, write) #####

# This dataset has columns with various formats 
View(nyc_squirrels)

  # Some have dates (note they aren't yet formatted as dates)
  typeof(nyc_squirrels$date)
  # Most are pretty good 
  typeof(nyc_squirrels$running) # this has only true/false
  typeof(nyc_squirrels$zip_codes) # this is #'s
  typeof(nyc_squirrels$primary_fur_color) # this is colors
  
# Remove dataset to practice loading
remove(nyc_squirrels)
  
# Use parsing to designate column types when uploading (many ways)

# Parsing way # 1 - write by hand as you upload
  nyc_squirrels2 <- read_csv('nyc_squirrels2.csv',
                        col_types = (cols(
                            date = col_date(format = '%m%d%Y')
                             )))
  # check if type changed
  typeof(nyc_squirrels2$date)
  
  # parse
  parse_date(nyc_squirrels2, date)
  
  # test if this works
  head(nyc_squirrels2$date)
  
  
  nyc_squirrels2 <- read_csv("nyc_squirrels2.csv", 
                             col_types = cols(date = col_date(format = "%m/%d/%Y")))
  
  


# Parwing way # 3 - do it with an add-in
  # click dataset --> import --> 
