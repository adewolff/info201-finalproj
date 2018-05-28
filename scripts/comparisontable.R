library(dplyr)

df <- read.csv("C:/Users/Administrator.UWIT-61OPTP3AKR/Desktop/Info/info201-finalproj/data/MERGED2015_16_PP.csv",stringsAsFactors = FALSE)

# Create a new data (Important Data)
new_data <- df %>% select("INSTNM", "CITY","UGDS", "UGDS_MEN",
                          "UGDS_WOMEN", "COSTT4_A",
                          "SAT_AVG")

colnames(new_data) <- c("Institution", "City", "Number_of_Undergraduates", "UG_Men",
                        "UG_Women", "Cost_of_Attendance", "Avg_SAT_Score")


# Remove 'Null' values- Non UG College
new_data <- filter(new_data, new_data$Number_of_Undergraduates != "NULL" & new_data$Number_of_Undergraduates != 0)
new_data$Cost_of_Attendance[new_data$Cost_of_Attendance=="NULL"] <- "Not Availible"
new_data$Avg_SAT_Score[new_data$Avg_SAT_Score=="NULL"] <- "Not Availible"


# Mulitply decimals by 100 to get percentage
new_data$UG_Men[new_data$UG_Men == "NULL"] <- 0
new_data$UG_Women[new_data$UG_Women == "NULL"] <- 0
new_data$UG_Men <-as.numeric(as.character(new_data$UG_Men)) * 100
new_data$UG_Women <-as.numeric(as.character(new_data$UG_Women)) * 100

#Make the relevant table

uni_1_info <- filter(new_data, new_data$Institution == uni_1)
uni_2_info <-  filter(new_data, new_data$Institution == uni_2)

vector_of_index <- c("Institution Name", "City", "No_of_Undergrads", "UG_men", "UG_women","Cost for UG", "Average_SAT_Score")
vector_uni_1 <- c(uni_1_info$Institution,uni_1_info$City, uni_1_info$Number_of_Undergraduates, uni_1_info$UG_Men, uni_1_info$UG_Women,uni_1_info$Cost_of_Attendance, uni_1_info$Avg_SAT_Score)
vector_uni_2 <- c(uni_2_info$Institution, uni_2_info$City, uni_2_info$Number_of_Undergraduates, uni_2_info$UG_Men, uni_2_info$UG_Women,uni_2_info$Cost_of_Attendance, uni_2_info$Avg_SAT_Score)

final_data_table <- data.frame(vector_of_index,vector_uni_1, vector_uni_2)
colnames(final_data_table) <- c("Aspect", "University 1", "University 2")