library(shiny)
library(dplyr)
library(leaflet)

data_2015_16 <- read.csv("../data/merged/MERGED2015_16_PP.csv",
                         stringsAsFactors = F)

shinyServer(function(input, output){
  

# Map Section -------------------------------------------------------------
  
  # Select map dataframe
  data_15_map <- data_2015_16 %>%
                            select(name = INSTNM, city = CITY,
                                   state = STABBR, insturl = INSTURL,
                                   lat = LATITUDE, lng = LONGITUDE,
                                   tuition_in = TUITIONFEE_IN,
                                   tuition_out = TUITIONFEE_OUT)
  
  # Convert lat and lon to numeric
  data_15_map$lat <- as.numeric(data_15_map$lat)
  data_15_map$lng <- as.numeric(data_15_map$lng)

  
  # Convert map dataframe to reactive object
  subset_df <- reactive({
    a <- subset(data_15_map, tuition_in < input$price)
    })
  
  # Create map
  output$map <- renderLeaflet(
    leaflet(subset_df()) %>%
      addTiles() %>%
      addCircles()
  )
  
}) # End of shinyServer
