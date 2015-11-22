library(shiny)
library(shinysky)

shinyUI(bootstrapPage(
  titlePanel("Shiny prototype"),
  
  sidebarLayout(
    sidebarPanel(navbarPage(
      "App Title",
      tabPanel("T-test"),
      tabPanel("F-test")
    )),
    mainPanel(
      navbarPage(
        "",
        tabPanel("Data",
                 mainPanel(
          h2("dz from t for correlated samples"),
          
          flowLayout(
            
            #fluidRow(
              style='width: 1000px;',
             # column(6,
                     div(class = "well container-fluid",
                         style = "overflow-y:scroll; max-height: 300px; width: 250px;"
                         ,hotable("hotable1"))  ,    
             # ),
              
             # column(6,
                     div(class = "well container-fluid",
                         style = "overflow-y:scroll; margin-left: 35px; max-height: 300px; width:400px"
                         ,hotable("hotable2")) 
             # )
            #)
          )
          
          
          
        )),
        tabPanel("Plots"),
        tabPanel("Descriptive statistics")
        
      )
      
      
      
    )
  )
  
  
  #   selectInput(inputId = "n_breaks",
  #               label = "Number of bins in histogram (approximate):",
  #               choices = c(10, 20, 35, 50),
  #               selected = 20),
  #
  #   checkboxInput(inputId = "individual_obs",
  #                 label = strong("Show individual observations"),
  #                 value = FALSE),
  #
  #   checkboxInput(inputId = "density",
  #                 label = strong("Show density estimate"),
  #                 value = FALSE),
  #
  #   plotOutput(outputId = "main_plot", height = "300px"),
  #
  #   # Display this only if the density is shown
  #   conditionalPanel(condition = "input.density == true",
  #                    sliderInput(inputId = "bw_adjust",
  #                                label = "Bandwidth adjustment:",
  #                                min = 0.2, max = 2, value = 1, step = 0.2)
  
))