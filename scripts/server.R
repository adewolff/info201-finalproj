library(shiny)
library(dplyr)
library(leaflet)
library(htmltools)

data_2015_16 <- read.csv("../data/merged/MERGED2015_16_PP.csv",
                         stringsAsFactors = F)

shinyServer(function(input, output){
  

# Map Section -------------------------------------------------------------
  
  # Select map dataframe
  data_15_map <- data_2015_16 %>% filter(HIGHDEG == 3 | HIGHDEG == 4) %>%
    select(name = INSTNM, city = CITY,
           state = STABBR, insturl = INSTURL,
           lat = LATITUDE, lng = LONGITUDE,
           tuition_in = TUITIONFEE_IN,
           tuition_out = TUITIONFEE_OUT)
  
  # Convert lat, lon, tuition to numeric
  data_15_map$lat <- as.numeric(data_15_map$lat)
  data_15_map$lng <- as.numeric(data_15_map$lng)
  data_15_map$tuition_in <- as.numeric(data_15_map$tuition_in)
  data_15_map$tuition_out <- as.numeric(data_15_map$tuition_out)
  
  # Remove NA from tuition
  data_15_map <- data_15_map %>%
    filter(!is.na(tuition_in) & !is.na(tuition_out))

  
  # Filter by schools with tution matching input
  subset_df <- reactive({
    a <- subset(data_15_map, tuition_in <= input$price)
    })
  
  # Create map
  output$map <- renderLeaflet(
    leaflet(subset_df()) %>%
      addTiles() %>%
      addCircleMarkers(label = ~htmlEscape(name),
                       popup = paste0("<strong>", subset_df()$name, "</strong>",
                                      "<br>",
                                      "In-State tuition: $",
                                      subset_df()$tuition_in))
  )
  
}) # End of shinyServer
