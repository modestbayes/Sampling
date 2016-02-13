
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
    selectInput("n", label = "View sample",
                choices = c(1:n), 
                selected = 1)
  })
  
  output$p1 <- renderUI({
    if (input$dist == "Normal") {
      numericInput("p1", label = "mu", value = 0) 
    } else
    if (input$dist == "Binomial") {
      numericInput("p1", label = "n", value = 10) 
    } else
    if (input$dist == "Chi-squared") {
      numericInput("p1", label = "df", value = 1) 
    } else
    if (input$dist == "Exponential") {
      numericInput("p1", label = "rate", value = 1) 
    }
  })
  
  output$p2 <- renderUI({
    if (input$dist == "Normal") {
      numericInput("p2", label = "sd", value = 1) 
    } else
    if (input$dist == "Binomial") {
      numericInput("p2", label = "p", value = 0.5) 
    }
  })
  
  v <- reactiveValues(data = NULL)
  
  observeEvent(input$sample, {
    m <- as.numeric(input$number)
    n <- as.numeric(input$size)
    A <- matrix( nrow=m, ncol=n) 
    for (i in 1:m) {
      if (input$dist == "Normal") {
        A[i,] <- rnorm( n, mean = input$p1, sd = input$p2 )
      } else
        if (input$dist == "Binomial") {
          A[i,] <- rbinom( n, size = input$p1, prob = input$p2 )
        } else
          if (input$dist == "Chi-squared") {
            A[i,] <- rchisq( n, df = input$p1)
          } else
            if (input$dist == "Exponential") {
              A[i,] <- rexp( n, rate = input$p1) 
            }
      }
    v$data <- A
    output$plot1 <- renderPlot({
      if (is.null(v$data)) return()
      i <- as.numeric(input$n)
      a <- v$data[i,]
      b <- data.frame(a)
      ggplot(b, aes(x=a)) +
        geom_histogram(fill=I("#009E73"),colour=I("white")) +
        geom_vline(xintercept=mean(a),   # Ignore NA values for mean
                   color="red", linetype="dashed", size=1) +
        scale_x_continuous(limits=range(A)) + 
        labs(title="Histogram of Current Sample") +
        labs(x="X", y="Count")
      
    })
    output$plot2 <- renderPlot({
      if (is.null(v$data)) return()
      i <- as.numeric(input$n)
      M <- apply(v$data, 1, mean)
      b <- data.frame(M)
      if (input$align) {
        xlim <- range(A)
      } else {
        xlim <- range(M)
      }
      ggplot(b, aes(x=M)) +
        geom_histogram(fill=I("#009E73"),colour=I("white")) +
        geom_vline(xintercept=M[i],   # Ignore NA values for mean
                   color="red", linetype="dashed", size=1) +
        scale_x_continuous(limits=xlim) + 
        labs(title="Histogram of Sample Mean") +
        labs(x="X", y="Count")
    })
    output$guide1 <- renderText("Below is the distribution of a random sample. The red 
                               vertical line indicates the mean of this sample.")
    
    output$guide2 <- renderText("Above is the distribution of the sample mean. First, 
                                you should compare the range of the two distributions. Then 
                                see what happens as you increase the number
                                of samples.")
  })

})
