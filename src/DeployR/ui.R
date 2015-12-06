library(shiny)
library(shinysky)
library(shinyjs)
shinyUI(bootstrapPage(
  shinyjs::useShinyjs(),
  titlePanel("Shiny prototype"),
  
  sidebarLayout(
    sidebarPanel(
      navbarPage("",
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
                
                  div( style = "width: 200%;",
                   div(
                     class = "well container-fluid",
                     style = "overflow-y:scroll; min-height:300px;max-height:300px;width: 260px; display: inline-block;",
                     
                     div(style = "float : left; width: 100px; margin: 0; padding: 0",
                         hotable("inputData1")),
                     div(style = "float : left; width: 100px; margin: 0; padding: 0",
                         hotable("inputData2"))
                   ),
                   
                   
                   
                   
                   div(class = "well container-fluid",
                       style = "overflow:scroll; min-height: 300px; width: 54%;display: inline-block;"
                       ,
                       hotable("outputData")
                     )
                 )
               )),
      tabPanel(
        "Plots",
        plotOutput(outputId = "main_plot", height = "300px"),
        plotOutput(outputId = "main_plot2", height = "300px")
      ),
      tabPanel("Descriptive statistics",
               mainPanel(
                 flowLayout(
                   #fluidRow(
                   style='width: 1000px;',
                   #column(7,
                   div(class = "well container-fluid",
                       style = "max-height: 300px; width: 250px;",
                       hotable("hotable3"),
                       p("Median"),br(),
                       p("Mean"),br(),
                       p("Standard deviation"),br(),
                       p("Min"),br(),
                       p("Max"),br()
                   ),  
                   #column(7,
                   div(class = "well container-fluid",
                       style = "margin-left: 35px; max-height: 300px; width:400px",
                       hotable("hotable4"),
                       p("Median"),br(),
                       p("Mean"),br(),
                       p("Standard deviation"),br(),
                       p("Min"),br(),
                       p("Max"),br())
                   #)
                   #)
                 )
               )
      )
      
    ))
  )
  
))