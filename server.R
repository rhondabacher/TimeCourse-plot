shinyServer(function(input, output, session) {
	

	
  pool.in <- read.csv("~/Desktop/HUMAN_normEC.csv",row.names=1)
  data.norm.human <- data.matrix(pool.in)+1
  
  pool.in <- read.csv("~/Desktop/MOUSE_normEC.csv",row.names=1)
  data.norm.mouse <- data.matrix(pool.in)+1
  rownames(data.norm.mouse) <- toupper(rownames(data.norm.mouse))
  
  # allchoices <- intersect(rownames(data.norm.mouse), rownames(data.norm.human))
  
 # updateSelectizeInput(session, 'gene', choices = allchoices, server = TRUE)

   
  cnames <- colnames(data.norm.human)
  h.ind <- as.numeric(substr(cnames,2,4))
  h.ind; length(h.ind)
  h.ind[2:101] <- h.ind[2:101] + 3
  t.v <- h.ind
  names(t.v) <- cnames; print(t.v)
  day.ind <- ceiling(unique(t.v)/24)
  
  day.col <- rainbow(6)
  day.col[2]<-"yellow2"
  names(day.col) <- sort(unique(day.ind))
  day.col.pool.h <- day.col[as.character(day.ind)]
  
  cnames <- colnames(data.norm.mouse)
  h.ind <- as.numeric(substr(cnames,5,6))
  h.ind; length(h.ind)
  h.ind[2:97] <- h.ind[2:97] + 3
  t.v <- h.ind
  names(t.v) <- cnames; print(t.v)
  
  day.ind <- ceiling(unique(t.v)/24)
  
  day.col <- rainbow(6)
  day.col[2]<-"yellow2"
  names(day.col) <- sort(unique(day.ind))
  day.col.pool.m <- day.col[as.character(day.ind)]
  
  
  output$plot <- renderPlot({
    par(mfrow=c(2,2), cex=1.5, cex.lab=1, cex.axis=1, cex.main=1.1, mar=c(6,6,2,2))	
    plot(1:101, data.norm.human[input$gene,]-1, pch=20, col=day.col.pool.h, main=paste0(input$gene,", human"), 
         ylab="Normalized Expression", xlab="Hour")
    
    plot(1:97, data.norm.mouse[input$gene,]-1, pch=20, col=day.col.pool.m, main=paste0(input$gene,", mouse"), 
         ylab="Normalized Expression", xlab="Hour")
    
    
    plot(1:101, log(data.norm.human[input$gene,]), pch=20, col=day.col.pool.h, main=paste0(input$gene,", human"), 
         ylab="Log Normalized Expression", xlab="Hour")
    
    plot(1:97, log(data.norm.mouse[input$gene,]), pch=20, col=day.col.pool.m, main=paste0(input$gene,", mouse"), 
         ylab="Log Normalized Expression", xlab="Hour")

  }, height=700, width=1000)
})