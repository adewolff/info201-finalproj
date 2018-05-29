shinyUI(navbarPage(
  "College Finder",


  # about panel -------------------------------------------------------------

  tabPanel(
    "About",
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
                          value = 10000, step = 1000),
               selectInput("loc",
                           "State to look in:",
                           choices = as.list(state.abb),
                           selected = "WA",multiple = TRUE)
             ), # End of sideparPanel
             mainPanel(
               leafletOutput("map")
             ) # End of mainPanel
           ) # End of sidebarLayout
  ), # End of tabPanel


  # graph panel -------------------------------------------------------------

  tabPanel(
    "Diversity",
    titlePanel("Diversity at a Specific Institution"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "barvariable",
          label = h3("Choose Institution"),
          choices = diversity$Institution
        )
      ), # end of sidebarPanel
      mainPanel(
        plotOutput("barchart", width = "100%", height = "400px")
      ) # End of mainPanel
    ) # End of sidebarLayout
  ), # End of tabPanel

  # Comparing two colleges panel --------------------------------------------

  tabPanel(
    "Comparison",
    titlePanel("Compare 2 Colleges"),
    sidebarLayout(
      sidebarPanel(
        h1("Compare 2 Universities here"),

        textInput("uni_1", "Enter 1st University", "Alabama A & M University"),
        textInput("uni_2", "Enter 2nd University", "Amridge University")


      ), # end of sidebarPanel
      mainPanel(
        h1("Here is the relevant information"),
        dataTableOutput('table')



      ) # End of mainPanel
    ) # End of sidebarLayout
  ) # End of tabPanel
) # End of shinyUI, navbarPage
)
