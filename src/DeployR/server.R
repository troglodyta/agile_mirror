require(shiny)
require(shinysky)

shinyServer(function(input, output) {
  
  # hotable
  output$hotable1 <- renderHotable({
    df <- data.frame(
      n = seq(1, 10, 1),
      Numeric1 = numeric(10), 
      Numeric2 = numeric(10))
    rownames(df) <- NULL
    return(df)
  }, readOnly = c(TRUE,FALSE,FALSE))
  
  df <- reactive({
    hot.to.df(input$hotable1) # this will convert your input into a data.frame
  })
  
  observe({
    df <- hot.to.df(input$hotable1)
    print(df)
  })
  
  
  # hotable2
  output$hotable2 <- renderHotable({
    df2 <- data.frame( 
                     npairs = numeric(1), 
                     tValue = numeric(1),
                     cohenDz = numeric(1),
                     clEffectSize = numeric(1))
    return(df2)
  }, readOnly = TRUE)
  
  df2 <- reactive({
    hot.to.df(input$hotable1) # this will convert your input into a data.frame
  })
  
})