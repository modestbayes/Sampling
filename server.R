
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)

shinyServer(function(input, output) {

  output$index <- renderUI({
    n = as.numeric(input$number)
    sliderInput("n", "",
                min = 1, max = n, value = 1, step = 1)
  })
  
  v <- reactiveValues(data = NULL)
  
  observeEvent(input$sample, {
    m <- as.numeric(input$number)
    n <- as.numeric(input$size)
    A <- matrix( nrow=m, ncol=n) 
    for (i in 1:m) {
      A[i,] <- rnorm( n, mean = 0, sd = 4 )
    }
    v$data <- A
    output$plot1 <- renderPlot({
      if (is.null(v$data)) return()
      i <- as.numeric(input$n)
      a <- v$data[i,]
      b <- data.frame(a)
      ggplot(b, aes(x=a)) +
        geom_histogram(fill=I("#009E73"),colour=I("white"),binwidth=1) +
        geom_vline(xintercept=mean(a),   # Ignore NA values for mean
                   color="red", linetype="dashed", size=1) +
        labs(title="Histogram of Current Sample") +
        labs(x="X", y="Count")
      
    })
    output$plot2 <- renderPlot({
      if (is.null(v$data)) return()
      i <- as.numeric(input$n)
      M <- apply(v$data, 1, mean)
      b <- data.frame(M)
      ggplot(b, aes(x=M)) +
        geom_histogram(fill=I("#009E73"),colour=I("white"), binwidth=0.2) +
        geom_vline(xintercept=M[i],   # Ignore NA values for mean
                   color="red", linetype="dashed", size=1) +
        labs(title="Histogram of Sample Mean") +
        labs(x="X", y="Count")
    })
    output$guide1 <- renderText("Below is the distribution of a random sample. As 
                               the sample size increases, you should notice that
                               the shape becomes more like a bell curve. The red 
                               vertical line indicates the mean of this sample.")
    
    output$guide2 <- renderText("Above is the distribution of the sample mean. First, 
                                you should compare the range of the two distributions. Then 
                                see what happens as you increase the number
                                of samples. (Hint: Cod Lettuce Tomato)")
  })

})
