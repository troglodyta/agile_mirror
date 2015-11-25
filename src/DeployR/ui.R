library(shiny)
library(shinysky)
library(shinyjs)
shinyUI(bootstrapPage(
  shinyjs::useShinyjs(),
  titlePanel("Shiny prototype"),
  
  sidebarLayout(
    sidebarPanel(
      navbarPage("App Title",
                 tabPanel("T-test"),
                 tabPanel("F-test")),
      radioButtons(
        "radioInputData", label = h5("Load data:"),
        choices = list("In app" = "app",
                       "From file" = "file"),selected = "app",inline = TRUE
      ),
      fileInput(
        'file1', 'Choose file to upload',
        accept = c(
          'text/csv',
          'text/comma-separated-values',
          'text/tab-separated-values',
          'text/plain',
          '.csv',
          '.tsv'
        )
      ),
      numericInput(
        inputId = "numberOfData", label = "Data count", 10, min = 2, max = 1000, step = 1
      )
      
    ),
    mainPanel(navbarPage(
      "",
      tabPanel("Data",
               mainPanel(
                 h2("dz from t for correlated samples"),
                 shinyalert("shinyalert1", FALSE,auto.close.after = 5),
                 flowLayout(
          
                   div(class = "well container-fluid",
                       style = "overflow-y:scroll; min-height:300px; width: 250px"
                       ,hotable("hotable1"))  ,
                   
                   
                   
                   div(class = "well container-fluid",
                       style = "overflow-y:scroll; margin-left: 35px; min-height: 300px; width: 500px"
                       ,hotable("hotable2"))
                 )
               )),
      tabPanel(
        "Plots",
        plotOutput(outputId = "main_plot", height = "300px"),
        plotOutput(outputId = "main_plot2", height = "300px")
      ),
      tabPanel("Descriptive statistics")
      
    ))
  )
  
))