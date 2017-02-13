library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Plot genes from mouse and human TC data:"),
  # Application title
  
  fluidRow(
      column(4,
		  textInput("gene", "Gene Name:", "T"),
		   br(),
		   htmlOutput("text1"),
		   br(),
		   textInput("miRNA", "miRNA Name:", "hsa-miR-25-3p")),

              
      column(8, 
             # Show a plot of the generated distribution
             mainPanel(plotOutput('plot'),  width = "100%"),
			 hr(size="100"),
			 br(),
			 hr(size="100"),
			 br(),
			 mainPanel(plotOutput('plot2'),  width = "100%")))
))
