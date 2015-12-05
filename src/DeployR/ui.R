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
        "radioComputingMode", label = h5("Typ"),
        choices = list(
          "T-test-Yes_Yes_No" = "1",
          "T-test-Yes_Yes_Yes" = "2",
          "T-test-Yes_No_Yes" = "3",
          "T-test-Yes_No_No_Yes" = "4",
          "T-test-Yes-No-No-No" = "5",
          "F-Test-No_Yes_Yes_No" = "6"
        ),selected = "1",inline = FALSE
      ),
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
        inputId = "numberOfData1", label = "Data1 count", 10, min = 2, max = 1000, step = 1
      ),
      
      numericInput(
        inputId = "numberOfData2", label = "Data2 count", 10, min = 2, max = 1000, step = 1
      )
      
    ),
    mainPanel(navbarPage(
      "",
      tabPanel("Data",
               mainPanel(
                 h2(textOutput("text1")),
                 shinyalert("shinyalert1", FALSE,auto.close.after = 5),
                 flowLayout(
                   div(
                     class = "well container-fluid",
                     style = "overflow-y:scroll; min-height:300px; width: 260px",
                     
                     div(style = "float : left; width: 100px; margin: 0; padding: 0",
                         hotable("inputData1")),
                     div(style = "float : left; width: 100px; margin: 0; padding: 0",
                         hotable("inputData2"))
                   ),
                   
                   
                   
                   
                   div(class = "well container-fluid",
                       style = "overflow-y:scroll; margin-left: 40px; min-height: 300px; width: 500px"
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