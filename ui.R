library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Plot genes from mouse and human TC data:"),
  # Application title
  
      column(2,
		  textInput("gene", "Gene Name:", "T")),

              
      column(10,
             # Show a plot of the generated distribution
             mainPanel(plotOutput('plot'),  width = "100%"))	   


))
