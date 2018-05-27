library(shiny)
library(dplyr)
library(leaflet)
library(htmltools)

data_2015_16 <- read.csv("../data/merged/MERGED2015_16_PP.csv",
                         stringsAsFactors = F)

shinyServer(function(input, output){
  

# Map Section -------------------------------------------------------------
  
  # Define reactive variables

  
  # Select map dataframe
  data_15_map <- data_2015_16 %>% filter(HIGHDEG == 3 | HIGHDEG == 4) %>%
    filter(ST_FIPS < 56) %>% filter(CCBASIC > 14)
  
    # select(name = INSTNM, city = CITY,
    #        state = STABBR, insturl = INSTURL,
    #        lat = LATITUDE, lng = LONGITUDE,
    #        tuition_in = TUITIONFEE_IN, tuition_out = TUITIONFEE_OUT,
    #        adm_rate = ADM_RATE)
  
  # Convert lat, lon, tuition to numeric
  data_15_map$LATITUDE <- as.numeric(data_15_map$LATITUDE)
  data_15_map$LONGITUDE <- as.numeric(data_15_map$LONGITUDE)
  data_15_map$TUITIONFEE_IN <- as.numeric(data_15_map$TUITIONFEE_IN)
  data_15_map$TUITIONFEE_OUT <- as.numeric(data_15_map$TUITIONFEE_OUT)
  
  # Remove NA from tuition
  data_15_map <- data_15_map %>%
    filter(!is.na(TUITIONFEE_IN) & !is.na(TUITIONFEE_OUT))

  
  # Filter by schools with tution matching input
  subset_df <- reactive({
    a <- subset(data_15_map, TUITIONFEE_IN <= input$price &
                  STABBR == input$loc)
    })

  
  # Create map
  output$map <- renderLeaflet(
    leaflet(subset_df()) %>%
      addTiles() %>%
      addCircleMarkers(label = ~htmlEscape(INSTNM),
                       popup = paste0("<strong>", subset_df()$INSTNM,
                                      "</strong>",
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
                                      ))
  )
  
}) # End of shinyServer
