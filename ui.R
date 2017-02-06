library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Plot genes from mouse and human TC data:"),
  # Application title
  
      column(4,
              textInput("gene", "Gene Name:", "T")),
              
      column(7,
             # Show a plot of the generated distribution
             mainPanel(plotOutput('plot')))	   


))
