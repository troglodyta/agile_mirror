require(shiny)
require(shinysky)
require(Hmisc)
library(shinyjs)
source("./helper.R")

shinyServer(function(input, output, session) {
  # funkcja uploadujaca plik
  filedata <- reactive({
    infile <- input$file1
    if (is.null(infile)) {
      # User has not uploaded a file yet
      return(NULL)
    }
    read.csv(infile$datapath, sep = ";", header = TRUE)
  })
  
  # funkcja zwracajaca typ wyliczen
  getComputeMode <- function() {
    return(input$radioComputingMode)
  }
  
  # renderowanie tabeli dla Data1
  output$inputData1 <- renderHotable({
    # disable wczytywanie danych na stronie
    shinyjs::toggleState("numberOfData1", input$radioInputData == "app")
    shinyjs::toggleState("numberOfData2", input$radioInputData == "app")
    if (input$radioInputData == "file") {
      print("DATA UPLOAD");
      data = filedata()
      if (!is.null(data)) {
        Data1 <- data[,1]
        Data1 <- Data1[!is.na(Data1)]
        print(Data1)
        df <- data.frame(np = seq(1, length(Data1), 1),Data1)
        rownames(df) <- NULL
        return(df)
      }
    }
    else {
      Data1 = numeric(input$numberOfData1)
      df <- data.frame(np = seq(1, input$numberOfData1, 1),Data1)
      rownames(df) <- NULL
      return(df)
    }
  }, readOnly = c(TRUE,FALSE,FALSE))
  
  
  # renderowanie danych dla tabeli Data2
  output$inputData2 <- renderHotable({
    if (input$radioInputData == "file") {
      print("DATA UPLOAD");
      data = filedata()
      if (!is.null(data)) {
        Data2 <- data[,2]
        Data2 <- Data2[!is.na(Data2)]
        print(Data2)
        df <- data.frame(np = seq(1, length(Data2), 1), Data2)
        rownames(df) <- NULL
        return(df)
      }
    }
    else {
      Data2 = numeric(input$numberOfData2);
      
      df <- data.frame(np = seq(1, input$numberOfData2, 1), Data2)
      rownames(df) <- NULL
      return(df)
    }
  }, readOnly = c(TRUE,FALSE,FALSE))
  
  #Przy zmianie wartosci listy zmienia Wyliczane wartosci
  observe({
    print("Table observe")
    df <- hot.to.df(input$inputData1)
    df2 <- hot.to.df(input$inputData2)
    data1List = df[, 2]
    data2List = df2[,2]
    #print(data1List)
    #print(data2List)
    isData1Numeric <- all.is.numeric(data1List)
    isData2Numeric <- all.is.numeric(data2List)
    if (isData1Numeric && isData2Numeric) {
      computeMode <- getComputeMode()
      x <- NULL
      if (computeMode == "1") {
        output$text1 <- renderText({
          "dz from t for correlated samples"
        })
        x <- T_test_Yes_Yes_No_compute(data1List,data2List)
      }
      else if (computeMode == "2") {
        output$text1 <- renderText({
          "Correlated (or Dependent) Samples"
          x <- T_testYes_Yes_Yes_compute(data1List,data2List)
        })
      }
      else if (computeMode == "3") {
        output$text1 <- renderText({
          "Independent Samples"
        })
      }
      else if (computeMode == "4") {
        output$text1 <- renderText({
          "ds from t for independent samples "
        })
      }
      else if (computeMode == "5") {
        output$text1 <- renderText({
          "dz from t for correlated samples "
        })
      }
      else if (computeMode == "6") {
        output$text1 <- renderText({
          "Partial n2"
        })
      }
      
      
      
      # Tutaj w zaleznosci od wybranych checkboxow powinny
      # Się zmieniac wyliczane wartosci
      output$summary <- renderPrint({
          x
      })
  
    }
    else {
      
    }
  })
  
  
  # plots
  
  # Obsluga histogramu 1
  output$main_plot <- renderPlot({
    df <- hot.to.df(input$inputData1)
    data1 = df[, 2]
    isData1Numeric <- all.is.numeric(data1)
    if (isData1Numeric) {
      xMax <- max(data1)
      if (xMax == 0)
        xMax <- 1
      bins <- seq(min(data1), xMax, length.out =  10)
      hist(data1, breaks = bins, col = 'darkgray', border = 'white')
    }
  })
  
  # Obsluga histogramu 2
  output$main_plot2 <- renderPlot({
    df <- hot.to.df(input$inputData2)
    data2 = df[, 2]
    isData1Numeric <- all.is.numeric(data2)
    if (isData1Numeric) {
      xMax <- max(data2)
      if (xMax == 0)
        xMax <- 1
      bins <- seq(min(data2), xMax, length.out =  10)
      hist(data2, breaks = bins, col = 'darkgray', border = 'white')
    }
  })
  
  
})