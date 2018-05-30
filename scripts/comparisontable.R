library(dplyr)
library(shiny)
source("./ui.R")
df <- read.csv("./data/MERGED2015_16_PP.csv", stringsAsFactors = FALSE)

# Create a new data (Important Data)
new_data <- df %>% select(
  "INSTNM", "CITY", "UGDS", "UGDS_MEN",
  "UGDS_WOMEN", "COSTT4_A",
  "SAT_AVG"
)

colnames(new_data) <- c(
  "Institution", "City", "Number_of_Undergraduates", "UG_Men",
  "UG_Women", "Cost_of_Attendance", "Avg_SAT_Score"
)

# Remove 'Null' values- Non UG College
new_data <- filter(new_data, new_data$Number_of_Undergraduates != "NULL" &
  new_data$Number_of_Undergraduates != 0)
new_data$Cost_of_Attendance[new_data$Cost_of_Attendance == "NULL"] <-
  "Not Available"
new_data$Avg_SAT_Score[new_data$Avg_SAT_Score == "NULL"] <- "Not Available"

# Mulitply decimals by 100 to get percentage
new_data$UG_Men[new_data$UG_Men == "NULL"] <- 0
new_data$UG_Women[new_data$UG_Women == "NULL"] <- 0
new_data$UG_Men <- as.numeric(as.character(new_data$UG_Men)) * 100
new_data$UG_Women <- as.numeric(as.character(new_data$UG_Women)) * 100
