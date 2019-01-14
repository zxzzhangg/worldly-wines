
library(tidyverse)

data <- read.csv("data/winemag-data-130k-v2.csv")

data$country <- as.factor(data$country)

wines <- data %>% 
  select(-X, -region_2, -taster_twitter_handle, -designation, -taster_name) %>% 
  filter(country != "", region_1 != "", price != "", points != "") %>%
  mutate(quality = ifelse(points < 86, "Low Quality", 
                           ifelse(between(points,86,91), "Medium Quality", 
                                  ifelse(points > 91, "High Quality", NA))))

write.csv(wines, file = "data/wines.csv")








