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

##### Skills Practice (upload, tidy, write) #####
# Upload dataset from csv
nyc_squirrels <- read_csv('nyc_squirrels2.csv')

# This dataset has columns with various formats 
View(nyc_squirrels)

  # Some are parsed incorrectly
  class(nyc_squirrels$date)
  
  # Most are parsed accurately
  class(nyc_squirrels$running) # this has only true/false
  class(nyc_squirrels$zip_codes) # this is #'s
  class(nyc_squirrels$primary_fur_color) # this is colors
  
# Use parsing to designate column types when uploading (many ways)

# Parsing way # 1 - after loading data
  
  # note - as_date doesn't work well as mdy with a numeric col without   an established delimieter
  nyc_squirrels <- nyc_squirrels %>%
    mutate(date2 = mdy(nyc_squirrels$date))
  
  # check work
  class(nyc_squirrels$date2)

# Parsing way # 2 - while loading data 
  # nyc_squirrels2 <- read_csv('nyc_squirrels2.csv',
                             # col_types = cols(
                             # date = mdy(date)))
  
# Parsing way # 3 - in loading window 
  # file (click) --> import dataset --> adj --> copy/paste code
  # doesn't work w dates in this example, but let's change a col type
  
##### 4 Important Tidyr Functions with LL #####
# Note: bio dataset belongs to LL and is not open access (until published)
  
# pivot
  # pivot longer
  long_bio <- bio %>%
    pivot_longer(c(BB10A.CT:BB18A.O), names_to = "sample", values_to = "abundance")
  View(long_bio)
  
  # gather is a similar function
  long2 <- gather(bio, Sample, abundance, BB10A.CT:BB18A.O, factor_key=TRUE)
  View(long2)
  ?gather
  
  # pivot_wider
  ?pivot_wider
  fish_encounters
  fish_encounters %>%
    pivot_wider(names_from = station, values_from = seen)
  # Fill in missing values
  fish_encounters %>%
    pivot_wider(names_from = station, values_from = seen, values_fill = list(seen = 0))
  
  # do the same thing with spread
  ?spread
  fish_encounters %>% 
    spread(station, seen, fill = 0)
  
  
# separate and unite using squirrel data
  nyc_squirrels
  nyc_squirrels_new <- nyc_squirrels %>%
    separate(unique_squirrel_id, into = c("Hectare_ID", "Shift", "Date", "Hectare_Squirrel_Number"))
  View(nyc_squirrels_new)
  
  #Unite them dack into squirrel ID#
  nyc_squirrels_new <- nyc_squirrels_new %>%
    unite("unique_squirrel_ID", Hectare_ID, Shift, Date, Hectare_Squirrel_Number)
  
  ####complete cases####
  fun_squirrels <- nyc_squirrels_new %>%
    complete(other_activities)
  
  fun_squirrels <- fun_squirrels %>%
    fill(highlight_fur_color)
  View(fun_squirrels)
 
##### Squirrel Data Showdown Challenge #####
  # Step 1 -  Load data (practice loading the nyc_squirrels 2 csv)


  
  # Step 2 - Create a date2 column that contains formatted dates
  # How do you check your work?
  
  
  
  # Step 3 - Separate the original date column into month, day and year? (try without lubridate) and then unite them.

  
  
  # Step 4 - Change the location column into 2 separate colunns with the headings 'above ground' and 'ground plane' and make the values logical statements (true/false)

  
  
  # Step 5 - Can you create a plot of your choice and post it as a reply to the thread @PandoriEco
  

