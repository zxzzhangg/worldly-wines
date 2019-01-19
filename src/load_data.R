#
# Worldly Wines shiny app
#
# By Zixin Zhang and Evan Yathon
# January 2019
#
# This is data wrangling script to clean up our dataset. 
# The original dataset can be accessed from https://www.kaggle.com/zynicide/wine-reviews
#
#
library(tidyverse)

data <- read.csv("data/winemag-data-130k-v2.csv")

# Filter out the NA's values and remove the unnecessary columns.
#
# Classify the wines into three quality levels: Low Quality, Medium Quality and High Quality 
# based on the points they recieved. 

wines <- data %>% 
  select(-X, -region_2, -taster_twitter_handle, -designation, -taster_name) %>% 
  filter(country != "", region_1 != "", price != "", points != "") %>%
  mutate(quality = ifelse(points < 86, "Low Quality", 
                           ifelse(between(points,86,91), "Medium Quality", 
                                  ifelse(points > 91, "High Quality", NA))))
# To write up a new csv file
write.csv(wines, file = "data/wines.csv")








