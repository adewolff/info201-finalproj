library(shiny)
library(ggplot2)
library(reshape2)
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
      ggtitle(paste("Racial Breakdown by Institution"))
  })
}) # End of shinyServer
