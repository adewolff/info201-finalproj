library(leaflet)
library(shinythemes)
source("./scripts/comparisonbarchart.R", local = TRUE)

shinyUI(
  navbarPage(
    theme = shinytheme("superhero"),
    h3("College Finder"),
    
    
    # about panel -------------------------------------------------------------
    
    tabPanel(
      h4("About"),
      titlePanel(h3("About College Finder")),
      mainPanel(HTML(
        "Overwhelmed by your college choices? Stressed about tuition? Don't
        know which college to attend? Use College Finder to narrow down your
        choices. <br> <br>
        This is College Finder. With an interactive map that lets you find
        institutions in the United States based on tuition. There is also a tab
        that lets you view the racial breakdown for a particular institution.
        We know that you may be conflicted over your top two choices, which is
        why we have a tab that lets you compare two institutions side-by-side.
        <br> <br>
        College Finder was created by three University of Washington
        undergraduate students in INFO 201: Jennifer Chen, Sukhman Dhillon, and
        Alex de Wolff. We know how stressful the process can be when it comes to
        finding the right college which is why we have created College Finder.
        <br>"
      ))
      ), # End of tabPanel
    
    
    # map panel ---------------------------------------------------------------
    
    tabPanel(
      h4("Map"),
      titlePanel(h3("Geographic Map of Institutions")),
      sidebarLayout(
        sidebarPanel(
          sliderInput("price",
                      "Maximum price of tuition per year:",
                      min = 1000, max = 53000,
                      value = 10000, step = 1000
          ),
          selectInput("loc",
                      "State to look in:",
                      choices = as.list(state.abb),
                      selected = "WA", multiple = TRUE
          )
        ), # End of sideparPanel
        mainPanel(
          leafletOutput("map")
        ) # End of mainPanel
      ) # End of sidebarLayout
    ), # End of tabPanel
    
    
    # Diversity panel ----------------------------------------------------------
    
    tabPanel(
      h4("Diversity"),
      titlePanel(h3("Diversity at a Specific Institution")),
      sidebarLayout(
        sidebarPanel(
          selectInput(
            "barvariable",
            label = "Choose Institution",
            choices = diversity$Institution
          ),
          "Pick or search for an institution in the United States to view the
          racial breakdown. This bar graph shows the undergraduate
          student body broken down by race in percentages (%). Note
          that some institutions are absent because they had no data
          for diversity."
        ), # end of sidebarPanel
        mainPanel(
          plotOutput("barchart", width = "100%", height = "450px")
        ) # End of mainPanel
        ) # End of sidebarLayout
    ), # End of tabPanel
    
    # Comparing two colleges panel --------------------------------------------
    
    tabPanel(
      h4("Comparison"),
      titlePanel(h3("Compare 2 Colleges")),
      sidebarLayout(
        sidebarPanel(
          "Universities to Compare:",
          
          textInput("uni_1", "Enter 1st University",
                    "University of Washington-Seattle Campus"),
          textInput("uni_2", "Enter 2nd University",
                    "Washington State University")
        ), # end of sidebarPanel
        mainPanel(
          tableOutput("table")
        ) # End of mainPanel
      ) # End of sidebarLayout
    ) # End of tabPanel
      ) # End of shinyUI, navbarPage
      )