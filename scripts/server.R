library(shiny)
library(dplyr)
library(ggplot2)
library(reshape2)
source("../scripts/comparisontable.R")
source("../scripts/comparisonbarchart.R")

# Start Shiny Server
shinyServer(function(input, output) {

  # Create diversity bar chart
  output$barchart <- renderPlot({
    dataPoint <- filter(diversity, Institution == input$barvariable)
    dataPoint <- melt(dataPoint, value.name = "Percentage", varnames =
                        c("Institution", "Race"))

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
        stat = "identity", fill = rainbow(n=9)
      ) +
      xlab("Race") +
      ylab("Percentage of Undergraduate Students") +
      ggtitle(paste("Racial Breakdown by Institution")) +
      theme(axis.text = element_text(size=12),
            axis.title = element_text(size=14, face="bold"),
            plot.title = element_text(size=20, face="bold", hjust = 0.5))
  })
 
    output$table <- renderDataTable(final_data_table)
  
}) # End of shinyServer
