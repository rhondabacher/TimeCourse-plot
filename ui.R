library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Plot genes from mouse and human TC data:"),
  # Application title
  
  fluidRow(
      column(4,
		  fluidRow(
			  column(6,
			  textInput("gene", "Gene Name:", "T"),
			   br(),
			   htmlOutput("text1"),
			   br(),
			   checkboxInput("showmiRNA", "Show the miRNA output & plots ? ", FALSE),
			   textInput("miRNA", "miRNA Name:", "hsa-miR-25-3p"),
			   br())),
		   fluidRow(column(6,
			   sidebarPanel(right=10, plotOutput('plot2'),  width="700px",height="700px")))
			   ),
      column(8, 
		  fluidRow( absolutePanel(plotOutput('plot'),  width="1000px",height="1300px")))),

  fluidRow( absolutePanel(top=1050, plotOutput('plot3'), width="1000px",height="1800px"))
))

	#
#
#
#
#
#
#
# 		  # Show a plot of the generated distribution
#              sidebarPanel(plotOutput('plot'),  width="1000px",height="1000px"),
# 			 br(),
# 			 br(),
# 			 br(),
# 			 br(),
# 			 sidebarPanel(plotOutput('plot3'), height="1500px"),
# 			 hr()))))
# 			 #mainPanel(plotOutput('plot2'),  width = "100%")))
# # ))
