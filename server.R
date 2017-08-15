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
   
   load("~/Desktop/VizShinyFiles/scH9_normalized.RData")
   load("~/Desktop/VizShinyFiles/bulkH9_normalized.RData")
   
   
  print("Loaded all data")
  
output$plot <- renderPlot({
 par(mfrow=c(2,2), cex=1.5, cex.lab=1, cex.axis=1, cex.main=1.1, mar=c(4,4,1,1), mgp=c(2,1,0))
   plot(1:ncol(data.norm.human), data.norm.human[input$gene,]-1, pch=20, col="red", main=paste0(input$gene,", human"),
            ylab="Normalized Expr.", xlab="Hour")

   plot(1:ncol(data.norm.mouse), data.norm.mouse[input$gene,]-1, pch=20, col="blue", main=paste0(ognames[input$gene],", mouse"),
          ylab="Normalized Expr.", xlab="Hour")
    
   plot(1:ncol(data.norm.human), log(data.norm.human[input$gene,]), pch=20, col="red", main=paste0(input$gene,", human"),
          ylab="Log Normalized Expr.", xlab="Hour")
     
   plot(1:ncol(data.norm.mouse), log(data.norm.mouse[input$gene,]), pch=20, col="blue", main=paste0(ognames[input$gene],", mouse"),
          ylab="Log Normalized Expr.", xlab="Hour")

}, height=1000, width=1300)
	 
output$plot3 <- renderPlot({
par(mfrow=c(2,2), cex=1.5, cex.lab=1, cex.axis=1, cex.main=1.1, mar=c(4,4,1,1), mgp=c(2,1,0))

	 top0 <- data.frame(Count= DataNorm$NormalizedData[input$gene,], Sample = colnames(DataNorm$NormalizedData), 
	                    Group = mygroups)


	 redobox<-function(DATA, smallc)
	 {
	   DATA[DATA<=smallc]<-NA #truncate some values first, could just be zero
	   y <- log(DATA+1)
  
	   return(y)
	 }
	 NumNonZeros <- sum(top0$Count != 0)

	 detectionGroup <- c()
	 for(i in 1:length(Gnames)){
	   detectionGroup[i] = round(sum(subset(top0, Group == Gnames[i])$Count != 0)  / Glengths[i] , 2 )
	 }
  
	 boxplot(log(Count+1)~Group, data=top0, pch=20, main=paste0(input$gene,", single-cell H9, # non-zeros = ", NumNonZeros), 
	 		ylim=c(0, max(log(top0$Count+1) + 1.5)),
	         ylab="Log Normalized Expr.", xlab="Hour", cex.axis=.8)
	 text(x= 1.5, y= max(log(top0$Count+1) + 1.2), labels= "Detection Rate:")
	 text(x= 1:10, y= max(log(top0$Count+1) + .7), labels= detectionGroup)

	 boxplot(redobox(Count,0)~Group, data=top0, pch=20, main=paste0(input$gene,", single-cell H9, zeros not shown"), 
	         ylim=c(0, max(log(top0$Count+1) + 1.5)), ylab="Log Normalized Expr.", xlab="Hour", cex.axis=.8)
		  

	 top1 <- data.frame(Count= NormalizedBulk[input$gene,], Sample = colnames(NormalizedBulk), 
	                    Group = mygroupsBULK)
	 boxplot(log(Count+1)~Group, data=top1, pch=20, main=paste0(input$gene,", bulk H9"), 
	         ylab="Log Normalized Expr.", xlab="Hour", cex.axis=.8)

	  
}, height=1000, width=2000)



output$text1 <- renderUI({
   if(input$showmiRNA == FALSE){return(NULL)}
   else {
   human_peak <- human.in[input$gene,"PeakHour"]
   
   lowbd <- human_peak - 3
   upbd <- human_peak + 3
   miRNA_top <- rownames(miRNAh.in[which(miRNAh.in$PeakHour >= lowbd & miRNAh.in$PeakHour <= upbd), ])
   
   HTML(c("miRNA human nearby:<br/>", paste0(miRNA_top, "<br/> ")))
   }
 
})

output$plot2 <- renderPlot({
	if(input$showmiRNA == FALSE){return(NULL)}
	else{
       par(mfrow=c(2,1), cex=1.5, cex.lab=1, cex.axis=1, cex.main=1.1, mar=c(4,4,1,1), mgp=c(2,1,0))
       
	   plot(1:ncol(miRNAh.data.in), miRNAh.data.in[input$miRNA,]-1, pch=20, col="red", main=paste0(input$miRNA,", human"),
            ylab="Normalized Expression", xlab="Hour")


	   plot(1:ncol(miRNAh.data.in), log(miRNAh.data.in[input$miRNA,]), pch=20, col="red", main=paste0(input$miRNA,", human"),
	        ylab="Log Normalized Expression", xlab="Hour")
		}

}, height=500, width=700)


})