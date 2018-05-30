library(shiny)
library(dplyr)
library(ggplot2)
library(reshape2)
source("../scripts/comparisontable.R", local = TRUE)
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
 
  output$table <- renderTable({ reactive({ 
      #Make the relevant table
      
      uni_1_info <- filter(new_data, new_data$Institution == input$uni_1)
      uni_2_info <-  filter(new_data, new_data$Institution == input$uni_2)
      
      vector_of_index <- c("Institution Name", "City", "No_of_Undergrads", "UG_men", "UG_women","Cost for UG", "Average_SAT_Score")
      vector_uni_1 <- c(uni_1_info$Institution,uni_1_info$City, uni_1_info$Number_of_Undergraduates, uni_1_info$UG_Men, uni_1_info$UG_Women,uni_1_info$Cost_of_Attendance, uni_1_info$Avg_SAT_Score)
      vector_uni_2 <- c(uni_2_info$Institution, uni_2_info$City, uni_2_info$Number_of_Undergraduates, uni_2_info$UG_Men, uni_2_info$UG_Women,uni_2_info$Cost_of_Attendance, uni_2_info$Avg_SAT_Score)
      
      final_data_table <- data.frame(vector_of_index,vector_uni_1, vector_uni_2)
      colnames(final_data_table) <- c("Aspect", "University 1", "University 2")})
 
    return(final_data_table)
    })

})

# End of shinyServer
