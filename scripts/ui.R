shinyUI(navbarPage(
  "College Finder",


  # about panel -------------------------------------------------------------

  tabPanel(
    "About",
    titlePanel("About College Finder"),
    mainPanel("test")
  ), # End of tabPanel


  # map panel ---------------------------------------------------------------

  tabPanel(
    "Map",
    titlePanel("Geographic map of colleges"),
    sidebarLayout(
      sidebarPanel(
        "stuff goes here"
      ), # End of sideparPanel
      mainPanel(
        "More stuff goes here"
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
        selectInput(
          "uni_1",
          label = h3("Choose Institution 1"),
          choices = new_data$Institution
        ),
        
        selectInput(
          "uni_2",
          label = h3("Choose Institution 2"),
          choices = new_data$Institution
        )
        ), # end of sidebarPanel
      mainPanel(
        h1("Here is the relevant information"),
        dataTableOutput('table')
        
        
        
      ) # End of mainPanel
    ) # End of sidebarLayout
  ) # End of tabPanel
) # End of shinyUI, navbarPage
)