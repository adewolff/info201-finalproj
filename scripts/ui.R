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
          label = "Choose Institution",
          choices = diversity$Institution
        )
      ), # end of sidebarPanel
      mainPanel(
        plotOutput("barchart")
      ) # End of mainPanel
    ) # End of sidebarLayout
  ), # End of tabPanel

  # Comparing two colleges panel --------------------------------------------

  tabPanel(
    "graph",
    titlePanel("Graph"),
    sidebarLayout(
      sidebarPanel(
        "stuff goes here"
      ), # end of sidebarPanel
      mainPanel(
        "More stuff goes here"
      ) # End of mainPanel
    ) # End of sidebarLayout
  ) # End of tabPanel
)) # End of shinyUI, navbarPage
