library(tidyverse)

# bring in clean data
library(readr)
anti_trans_bills_clean <- read_csv("anti-trans-bills-clean.csv")
View(anti_trans_bills_clean)
# focus on year and stats to create multibar and multiline graph. To keep it simple, focus on failed and passed.
anti_trans_bills_year_status <- anti_trans_bills_clean %>% group_by(year, Status) %>% summarize(n = n())
anti_trans_bills_year_status <- anti_trans_bills_year_status %>% filter(Status == "Dead/Failed" | Status == "Signed/Enacted")

# a little bit of cleaning
anti_trans_bills_year_status <- na.omit(anti_trans_bills_year_status)
anti_trans_bills_year_status <- anti_trans_bills_year_status %>% filter(year != 1905) #Need to omit this observation
anti_trans_bills_year_status <- anti_trans_bills_year_status %>% filter(year != 2017) #There is only one bill here, and it is causing distortion in the graphs

#create a multibar graph and a multiline graph
graph_status_bar <- anti_trans_bills_year_status %>% ggplot(aes(x = year, y = n, fill = Status)) + geom_bar(stat = "identity", position = "dodge") + ggtitle("Failed and Enacted Anti-Trans Bills: 2018 - 2023")
graph_status_line <- anti_trans_bills_year_status %>% ggplot(aes(x = year, y = n, color = Status)) + geom_line()  + ggtitle("Failed and Enacted Anti-Trans Bills: 2018 - 2023")

#Comparing stacked graphs with counts vs percentages - focus on bill type

anti_trans_bills_year_type <- anti_trans_bills_clean %>% group_by(year, `Bill Type`) %>% summarize(n = n())

# a little bit of cleaning
anti_trans_bills_year_type <- na.omit(anti_trans_bills_year_type)
anti_trans_bills_year_type <- anti_trans_bills_year_type %>% filter(year != 1905) #Need to omit this observation
anti_trans_bills_year_type <- anti_trans_bills_year_type %>% filter(year != 2017) #There is only one bill here, and it is causing distortion in the graphs

#Create graphs
graph_type_count <- anti_trans_bills_year_type %>% ggplot(aes(x = year, y = n, fill = `Bill Type`)) + geom_bar(stat = "Identity") + ggtitle("Anti-Trans Bills Introduced by Type: 2018 - 2023")
graph_type_percent <- anti_trans_bills_year_type %>% ggplot(aes(x = year, y = n, fill = `Bill Type`)) + geom_col(position = "fill") + ggtitle("Anti-Trans Bills Introduced by Type: 2018 - 2023")
