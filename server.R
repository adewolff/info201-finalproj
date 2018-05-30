library(shiny)
library(dplyr)
library(ggplot2)
library(reshape2)
library(leaflet)
library(htmltools)
source("./scripts/comparisonbarchart.R", local = TRUE)
source("./scripts/comparisontable.R", local = TRUE)

data_2015_16 <- read.csv("./data/MERGED2015_16_PP.csv",
                         stringsAsFactors = F
)

# Start Shiny Server
shinyServer(function(input, output) {
  # Create diversity bar chart
  output$barchart <- renderPlot({
    comparison_chart(input$barvariable)
  })
  reactiveDf <- reactive({
    # Make the relevant table
    uni_1_info <- filter(new_data, new_data$Institution == input$uni_1)
    uni_2_info <- filter(new_data, new_data$Institution == input$uni_2)
    vector_of_index <- c(
      "Institution Name", "City", "No_of_Undergrads",
      "UG_men", "UG_women", "Cost for UG",
      "Average_SAT_Score"
    )
    vector_uni_1 <- c(
      uni_1_info$Institution, uni_1_info$City,
      uni_1_info$Number_of_Undergraduates, uni_1_info$UG_Men,
      uni_1_info$UG_Women, uni_1_info$Cost_of_Attendance,
      uni_1_info$Avg_SAT_Score
    )
    vector_uni_2 <- c(
      uni_2_info$Institution, uni_2_info$City,
      uni_2_info$Number_of_Undergraduates, uni_2_info$UG_Men,
      uni_2_info$UG_Women, uni_2_info$Cost_of_Attendance,
      uni_2_info$Avg_SAT_Score
    )
    final_data_table <- data.frame(vector_of_index, vector_uni_1, vector_uni_2)
    colnames(final_data_table) <- c("", "University 1", "University 2")
    return(final_data_table)
  })
  output$table <- renderTable({
    reactiveDf()
  },
  striped = TRUE, hover = TRUE)
  # Map Section -------------------------------------------------------------
  # Select map dataframe
  data_15_map <- data_2015_16 %>%
    filter(HIGHDEG == 3 | HIGHDEG == 4) %>%
    filter(ST_FIPS < 56) %>%
    filter(CCBASIC > 14) %>%
    filter(UGDS > 0) %>%
    filter(DISTANCEONLY == 0)

  # Update charter college location
  data_15_map[data_15_map$INSTNM == "Charter College", "CITY"] <- "Anchorage"
  data_15_map[data_15_map$INSTNM == "Charter College", "STABBR"] <- "AK"

  # Convert lat, lon, tuition to numeric
  data_15_map$LATITUDE <- as.numeric(data_15_map$LATITUDE)
  data_15_map$LONGITUDE <- as.numeric(data_15_map$LONGITUDE)
  data_15_map$TUITIONFEE_IN <- as.numeric(data_15_map$TUITIONFEE_IN)
  data_15_map$TUITIONFEE_OUT <- as.numeric(data_15_map$TUITIONFEE_OUT)

  # Remove NA from tuition
  data_15_map <- data_15_map %>%
    filter(!is.na(TUITIONFEE_IN) & !is.na(TUITIONFEE_OUT))

  # Change NA admission rate to Not available
  data_15_map[data_15_map$ADM_RATE == "NULL", "ADM_RATE"] <- "Not Available"

  # Filter by schools with tution matching input
  subset_df <- reactive({
    a <- subset(data_15_map, TUITIONFEE_IN <= input$price &
                  STABBR == input$loc)
  })

  # Create map
  output$map <- renderLeaflet(
    leaflet(subset_df()) %>%
      addTiles() %>%
      addCircleMarkers(
        label = ~ htmlEscape(INSTNM),
        popup = paste0(
          "<strong>", subset_df()$INSTNM,
          "</strong>",
          "<br>",
          '<a href="https://', subset_df()$INSTURL, '">Website</a>',
          "<br>",
          "In-State Tuition: $",
          subset_df()$TUITIONFEE_IN,
          "<br>",
          "Out Of State Tuition: $",
          subset_df()$TUITIONFEE_OUT,
          "<br>",
          "<br>",
          "Admission Rate: ",
          subset_df()$ADM_RATE
        )
      )
  )
}) # End of shinyServer