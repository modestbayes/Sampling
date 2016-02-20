
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
           You shall experiment with different sample sizes and numbers of samples.",
           offset = 2)
  ),
  fluidRow(
    column(width = 8,
           column(width = 4,
                  selectInput("dist", label = "Distribution", 
                              choices = c("Normal", "Binomial", "Chi-squared", "Exponential"), 
                              selected = "Normal"),
                  offset = 0),
           column(width = 4,
                  uiOutput("p1"),
                  offset = 0),
           column(width = 4,
                  uiOutput("p2"),
                  offset = 0),
           offset = 2)
  ),
  fluidRow(
    column(width = 8,
           column(width = 4,
                  numericInput("size", label = "Sample Size", value = 30),
                  offset = 0),
           column(width = 4,
                  numericInput("number", label = "Number of Samples", value = 10),
                  offset = 0),
           column(width = 4,
                  uiOutput("index"),
                  offset = 0),
           offset = 2)
  ),
  
  fluidRow(
    column(width = 8,
           column(width = 4,
                  actionButton("sample", "Generate Samples"),
                  offset = 4),
           column(width = 4,
                  checkboxInput("align", label = "Align Axes", value = TRUE),
                  offset = 0),
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
