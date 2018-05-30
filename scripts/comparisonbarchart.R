## bar chart script
library(dplyr)
library(ggplot2)

# load in data
raw_data <- read.csv("./data/MERGED2015_16_PP.csv", stringsAsFactors = FALSE)

# Create a new data frame with diversity
diversity_raw <- raw_data %>% select("INSTNM", "UGDS_WHITE", "UGDS_BLACK",
                                        "UGDS_HISP", "UGDS_ASIAN", "UGDS_AIAN",
                                        "UGDS_NHPI", "UGDS_2MOR", "UGDS_NRA",
                                        "UGDS_UNKN")
# Rename column names
colnames(diversity_raw) <- c("Institution", "White", "Black", "Hispanic",
                             "Asian", "American Indian", "Pacific Islander",
                             "Two or More Races", "Non-resident Aliens",
                             "Unknown")

# Include which state college is located incase of duplicate names
diversity_raw$Institution <- paste(raw_data$INSTNM, raw_data$STABBR, sep=" in ")

# Remove 'NA' values
diversity <- na.omit(diversity_raw)

# Remove 'Null' values
diversity <- filter(diversity, White != "NULL")

# Change columns to numeric
diversity[, -1] <- sapply(diversity[, -1], as.numeric)

# Mulitply decimals by 100 to get percentage
for (i in colnames(diversity)[-1]) {
  diversity[i] <- diversity[i] * 100
}



comparison_chart <- function(institution) {
  dataPoint <- filter(diversity, Institution == institution)
  dataPoint <- melt(dataPoint,
                    value.name = "Percentage", varnames =
                      c("Institution", "Race")
  )
  
  ggplot(data = dataPoint) +
    geom_bar(
      mapping = aes(
        x = c(
          "White", "Black", "Hispanic", "Asian",
          "American Indian", "Pacific Islander",
          "Two or More Races", "Non-resident Aliens", "Unknown"
        ),
        y = Percentage
      ),
      stat = "identity", fill = rainbow(n = 9)
    ) +
    xlab("Race") +
    ylab("Percentage of Undergraduate Students") +
    ggtitle(paste("Racial Breakdown by Institution in Percents")) +
    theme(
      axis.text = element_text(size = 12),
      axis.title = element_text(size = 14, face = "bold"),
      plot.title = element_text(size = 20, face = "bold", hjust = 0.5)
    ) %>% return() 
}