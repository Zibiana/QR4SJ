library(tidyverse)

# bring in clean data
library(readr)
anti_trans_bills_clean <- read_csv("anti-trans-bills-clean.csv")
View(anti_trans_bills_clean)
# focus on year and status to create multibar and multiline graph. There will be so many categories that the examples illustrate what not to do
anti_trans_bills_year_status <- anti_trans_bills_clean %>% group_by(year, Status) %>% summarize(n = n())

# a little bit of cleaning
anti_trans_bills_year_status <- na.omit(anti_trans_bills_year_status)
anti_trans_bills_year_status <- anti_trans_bills_year_status %>% filter(year != 1905) #Need to omit this observation
anti_trans_bills_year_status <- anti_trans_bills_year_status %>% filter(year != 2017) #There is only one bill here, and it is causing distortion in the graphs

#create a multibar graph and a multiline graph
graph_status_bar <- anti_trans_bills_year_status %>% ggplot(aes(x = year, y = n, fill = Status)) + geom_bar(stat = "identity", position = "dodge") + ggtitle("Anti-Trans Bills by Status and Year: 2018 - 2023")
graph_status_line <- anti_trans_bills_year_status %>% ggplot(aes(x = year, y = n, color = Status)) + geom_line() + ggtitle("Anti-Trans Bills by Status and Year: 2018-2023")

