library(tidyverse)

# bring in clean data
library(readr)
anti_trans_bills_clean <- read_csv("anti-trans-bills-clean.csv")
View(anti_trans_bills_clean)

#Filter to those bills that completed the cycle (definitively did or did not get enacted)
anti_trans_passed_failed <- anti_trans_bills_clean %>% filter(Status == "Dead/Failed" | Status == "Signed/Enacted")

#A little bit of cleaning
anti_trans_by_status <- anti_trans_passed_failed %>% group_by(year, Status) %>% summarise(n = n())
anti_trans_by_status <- na.omit(anti_trans_by_status)
anti_trans_by_status <- spread(anti_trans_by_status, Status, n)
anti_trans_by_status <- anti_trans_by_status %>% mutate(Percent_Enacted = `Signed/Enacted`/(`Signed/Enacted` + `Dead/Failed`))

#Make the graphs
Total_Enacted_Graph <- anti_trans_by_status %>% ggplot(aes(x = year, y = `Signed/Enacted`)) + geom_bar(stat = "identity") + ggtitle("Total Bills Enacted by Year: 2018 - 2023")
Percent_Enacted_Graph <- anti_trans_by_status %>% ggplot(aes(x = year, y = `Percent_Enacted`)) + geom_bar(stat = "identity") + ggtitle("Percentage of Bills Enacted by Year: 2018 - 2023")
