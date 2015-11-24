library(shiny)
library(shinysky)

shinyUI(bootstrapPage(
  titlePanel("Shiny prototype"),
  
  sidebarLayout(
    sidebarPanel(navbarPage(
      "App Title",
      tabPanel("T-test"),
      tabPanel("F-test"),
      fileInput('file1', 'Choose file to upload',
                accept = c(
                  'text/csv',
                  'text/comma-separated-values',
                  'text/tab-separated-values',
                  'text/plain',
                  '.csv',
                  '.tsv')
                ),
      actionButton(inputId = "readFile", "Read File"),
      numericInput(inputId = "numberOfData", label= "Data count", 10, min = 2, max = 1000, step = 1)
    )),
    mainPanel(
      navbarPage(
        "",
        tabPanel("Data",
                 mainPanel(
          h2("dz from t for correlated samples"),
          shinyalert("shinyalert1", FALSE,auto.close.after = 5),
          flowLayout(
            
            #fluidRow(
              #style='width: 1000px;',
             # column(6,
                     div(class = "well container-fluid",
                         style = "overflow-y:scroll; min-height:300px; width: 250px"
                         ,hotable("hotable1"))  ,    
             # ),
              
             # column(6,
                     div(class = "well container-fluid",
                         style = "overflow-y:scroll; margin-left: 35px; min-height: 300px; width: 500px"
                         ,hotable("hotable2")) 
             # )
            #)
          )
          
          
          
        )),
        tabPanel("Plots",
                 plotOutput(outputId = "main_plot", height = "300px"),
                 plotOutput(outputId = "main_plot2", height = "300px")
                 ),
        tabPanel("Descriptive statistics")
        
      )
      
      
      
    )
  ),
  
  tags$script('
    Shiny.addCustomMessageHandler("resetFileInputHandler", function(x) {      
              var id = "#" + x + "_progress";
              var idBar = id + " .bar";
              $(id).css("visibility", "hidden");
              $(idBar).css("width", "0%");
              });
              ')
  
))