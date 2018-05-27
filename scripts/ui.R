shinyUI(navbarPage("College Finder",
                   

# about panel -------------------------------------------------------------

                   tabPanel("About",
                            titlePanel("About College Finder"),
                            mainPanel("test")
                     
                   ), # End of tabPanel
                   

# map panel ---------------------------------------------------------------

                   tabPanel("Map",
                            titlePanel("Geographic map of colleges"),
                            sidebarLayout(
                              sidebarPanel(
                                sliderInput("price",
                                           "Maximum price of tuition per year:",
                                           min = 1000, max = 53000,
                                           value = 10000, step = 1000)
                              ), # End of sideparPanel
                              mainPanel(
                                leafletOutput("map")
                              ) # End of mainPanel
                            ) # End of sidebarLayout
                   ), # End of tabPanel


# graph panel -------------------------------------------------------------

                   tabPanel("graph",
                            titlePanel("Graph"),
                            sidebarLayout(
                              sidebarPanel(
                                "stuff goes here"
                              ), #end of sidebarPanel
                              mainPanel(
                                "More stuff goes here"
                              ) # End of mainPanel
                            ) # End of sidebarLayout
                            
                  ) # End of tabPanel
  
)) # End of shinyUI, navbarPage