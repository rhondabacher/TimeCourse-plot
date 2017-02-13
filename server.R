shinyServer(function(input, output, session) {
  
  
  
  pool.in <- read.csv("~/Desktop/VizShinyFiles/HUMAN_normEC.csv",row.names=1)
  data.norm.human <- data.matrix(pool.in)+1
  
  pool.in <- read.csv("~/Desktop/VizShinyFiles/MOUSE_normEC.csv",row.names=1)
  data.norm.mouse <- data.matrix(pool.in)+1
  ognames <- rownames(data.norm.mouse)
  rownames(data.norm.mouse) <- toupper(rownames(data.norm.mouse))
  
  names(ognames) <- rownames(data.norm.mouse)
  
  miRNAh.in <- read.csv("~/Desktop/VizShinyFiles/miRNAhuman_PeakSummary.csv",row.names=1, stringsAsFactors=F, header=T)
  human.in <- read.csv("~/Desktop/VizShinyFiles/Human_PeakSummary.csv",row.names=1, stringsAsFactors=F, header=T)
  
  
   pool.in <- read.csv("~/Desktop/VizShinyFiles/miRNAhuman_normEC.csv",row.names=1, stringsAsFactors=F, header=T)
   miRNAh.data.in <- data.matrix(pool.in)+1
   
  print("Loaded all data")
  
   output$plot <- renderPlot({
       par(mfrow=c(2,2), cex=1.5, cex.lab=1, cex.axis=1, cex.main=1.1, mar=c(4,4,1,1), mgp=c(2,1,0))
       plot(1:101, data.norm.human[input$gene,]-1, pch=20, col="red", main=paste0(input$gene,", human"),
            ylab="Normalized Expr.", xlab="Hour")

		# addline1()

     plot(1:97, data.norm.mouse[input$gene,]-1, pch=20, col="blue", main=paste0(ognames[input$gene],", mouse"),
          ylab="Normalized Expr.", xlab="Hour")
     # addline2()

     plot(1:101, log(data.norm.human[input$gene,]), pch=20, col="red", main=paste0(input$gene,", human"),
          ylab="Log Normalized Expr.", xlab="Hour")
     # addline3()

     plot(1:97, log(data.norm.mouse[input$gene,]), pch=20, col="blue", main=paste0(ognames[input$gene],", mouse"),
          ylab="Log Normalized Expr.", xlab="Hour")
     # addline4()
}, height=500, width=1000)



output$text1 <- renderUI({
   
   human_peak <- human.in[input$gene,"PeakHour"]
   
   lowbd <- human_peak - 3
   upbd <- human_peak + 3
   miRNA_top <- rownames(miRNAh.in[which(miRNAh.in$PeakHour >= lowbd & miRNAh.in$PeakHour <= upbd), ])
   
   HTML(c("miRNA human nearby:<br/>", paste0(miRNA_top, "<br/> ")))
   
 
})

   output$plot2 <- renderPlot({
       par(mfrow=c(1,2), cex=1.5, cex.lab=1, cex.axis=1, cex.main=1.1, mar=c(4,4,1,1), mgp=c(2,1,0))
       
	   plot(1:89, miRNAh.data.in[input$miRNA,]-1, pch=20, col="red", main=paste0(input$miRNA,", human"),
            ylab="Normalized Expression", xlab="Hour")


	   plot(1:89, log(miRNAh.data.in[input$miRNA,]), pch=20, col="red", main=paste0(input$miRNA,", human"),
	        ylab="Log Normalized Expression", xlab="Hour")

}, height=250, width=1000)

})