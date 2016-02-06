
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinythemes)


shinyUI(fluidPage(
  theme = shinytheme("readable"),
  
  fluidRow(
    column(width = 8,
           h4('Sampling Distribution Visualization'),
           h4(""),
           "This app is intended to help you understand the sampling distribution of the sample mean.
           You shall experiment with different sample sizes and numbers of samples. Here the samples
           follow a Normal distribution with mean of 0 and standard deviation of 4.",
           h4(""),
           column(width = 6,
                  numericInput("size", label = "Sample Size", value = 10),
                  offset = 0),
           column(width = 6,
                  numericInput("number", label = "Number of Samples", value = 2),
                  offset = 0),
           column(width = 6,
                  actionButton("sample", "Generate random samples"),
                  h4(""),
                  "Slide to switch samples",
                  uiOutput("index"),
                  offset = 3),
           offset = 2)

  ),
  fluidRow(
    column(width = 8,
           textOutput("guide1"),
           plotOutput("plot1"),
           plotOutput("plot2"),
           textOutput("guide2"),
           offset = 2)
  )
)
)
