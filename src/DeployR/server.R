require(shiny)
require(shinysky)
require(Hmisc)
source("./helper.R")

#VARIABLES
appInp <- TRUE

shinyServer(function(input, output,session) {
  
  
  observe({
    print("NumberOfDataObserve")
    session$sendCustomMessage(type = "resetFileInputHandler", "file1")  
    print(input$numberOfData)
    
    Data1 = numeric(input$numberOfData);
    Data2 = numeric(input$numberOfData);
    
    output$hotable1 <- renderHotable({
      df <- data.frame(
        np = seq(1, input$numberOfData, 1),
        Data1,
        Data2
      )
      rownames(df) <- NULL
      return(df)
    }, readOnly = c(TRUE,FALSE,FALSE))
    
    df <- reactive({
      hot.to.df(input$hotable1) # this will convert your input into a data.frame
    })
  })
  
  
  
  filedata <- reactive({
    infile <- input$file1
    if (is.null(infile)) {
      # User has not uploaded a file yet
      return(NULL)
    }
    read.csv(infile$datapath, sep = ";", header = TRUE)
  })
  
  observe({
    print("DATA UPLOAD");
    data = filedata()
    if(!is.null(data)){
      Data1 <- data[,1]
      Data2 <- data[,2]
      print(Data1)
      print(Data2)
      
      output$hotable1 <- renderHotable({
        df <- data.frame(
          np = seq(1, length(Data1), 1),
          Data1,
          Data2
        )
        rownames(df) <- NULL
        return(df)
      }, readOnly = c(TRUE,FALSE,FALSE))
      
      df <- reactive({
        hot.to.df(input$hotable1) # this will convert your input into a data.frame
      })
    }
  })
  
  

  
  #Przy zmianie wartoœci listy zmienia Wyliczane wartoœci
  
  
  observe({
    print("Table observe")
    df <- hot.to.df(input$hotable1)
    data1List = df[, 2]
    data2List = df[,3]
    #print(data1List)
    #print(data2List)
    isData1Numeric <- all.is.numeric(data1List)
    isData2Numeric <- all.is.numeric(data2List)
    if(isData1Numeric && isData2Numeric) {
      # Tutaj w zale¿noœci od wybranych checkboxów powinny
      # Siê zmieniaæ wyliczane wartoœci
      x <- T_test_Yes_Yes_No_compute(data1List,data2List)
                   output$hotable2 <- renderHotable({
                     df2 <- x
                     return(df2)
                   }, readOnly = TRUE)
    }
    else {
    
    }
    })
  
  # Obs³uga histogramu 1
  output$main_plot <- renderPlot({
    df <- hot.to.df(input$hotable1)
    data1 = df[, 2]
    isData1Numeric <- all.is.numeric(data1)
    if(isData1Numeric) {
    xMax <- max(data1)
    if(xMax == 0)
      xMax <- 1
    bins <- seq(min(data1), xMax, length.out =  10)
    hist(data1, breaks = bins, col = 'darkgray', border = 'white')
    }
  })
  
  # Obs³uga histogramu 1
  output$main_plot2 <- renderPlot({
    df <- hot.to.df(input$hotable1)
    data2 = df[, 3]
    isData1Numeric <- all.is.numeric(data2)
    if(isData1Numeric) {
      xMax <- max(data2)
      if(xMax == 0)
        xMax <- 1
      bins <- seq(min(data2), xMax, length.out =  10)
      hist(data2, breaks = bins, col = 'darkgray', border = 'white')
    }
  })
  
  
})