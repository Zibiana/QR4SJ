library(tidyverse)

# bring in clean data
library(readr)
anti_trans_bills_clean <- read_csv("anti-trans-bills-clean.csv")
View(anti_trans_bills_clean)

#The first exercise is to create a graph for the number of each type of bill. I chose a bar graph for this one since we have a finite number of categorical variables
#First collect the type
anti_trans_bills_type <- anti_trans_bills_clean %>% group_by(`Bill Type`) %>% summarise(n = n())

#Now make the graph  but flip axes so that we can read the labels 
graph_1 <- anti_trans_bills_type %>% ggplot(aes(x = `Bill Type`, y = n)) + geom_bar(stat = "identity") + coord_flip() + ggtitle("Anti-Trans Legislation by Bill Type: 2018 - 2023")

#The second exercise is to create a graph for the total number of bills proposed over the period. I chose a line graph to represent the passage of time
#filter by year
anti_trans_bills_by_year <- anti_trans_bills_clean %>% group_by(year) %>% summarise(n = n())

# a little bit of cleaning
anti_trans_bills_by_year <- na.omit(anti_trans_bills_by_year)
anti_trans_bills_by_year <- anti_trans_bills_by_year %>% filter(year != 1905) #Need to omit this observation
anti_trans_bills_by_year <- anti_trans_bills_by_year %>% filter(year != 2017) #There is only one bill here, and it is causing distortion in the graphs

#line graph
total_bills_by_year <- anti_trans_bills_by_year %>% ggplot(aes(x = year, y = n)) + geom_line() + ggtitle("Anti-Trans Legislation Introduced: 2018 - 2023")

#The third exercise is to graph the total number of billes signed into law and enacted. For the same reason, I chose a line graph

#filter by year and status
anti_trans_bills_by_year_enacted <- anti_trans_bills_clean %>% filter(Status == "Signed/Enacted") %>%    group_by(year) %>% summarise(n = n())

# a little bit of cleaning
anti_trans_bills_by_year_enacted <- na.omit(anti_trans_bills_by_year_enacted)
anti_trans_bills_by_year_enacted <- anti_trans_bills_by_year_enacted %>% filter(year != 1905) #Need to omit this observation
anti_trans_bills_by_year_enacted <- anti_trans_bills_by_year_enacted %>% filter(year != 2017) #There is only one bill here, and it is causing distortion in the graphs

#line graph
total_bills_by_year_enacted <- anti_trans_bills_by_year_enacted %>% ggplot(aes(x = year, y = n)) + geom_line() + ggtitle("Anti-Trans Legislation Enacted: 2018 - 2023")
