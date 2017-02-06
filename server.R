server <- function(input, output) {
  pool.in <- read.csv("~/Desktop/HUMAN_normEC.csv",row.names=1)
  data.norm.human <- data.matrix(pool.in)+1
  
  pool.in <- read.csv("~/Desktop/MOUSE_normEC.csv",row.names=1)
  data.norm.mouse <- data.matrix(pool.in)+1
  rownames(data.norm.mouse) <- toupper(rownames(data.norm.mouse))
  
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
    par(mfrow=c(2,2),cex.lab=1.6, cex.axis=1.4, cex.main=1.7, mar=c(5,5,2,1.5))	
    plot(1:101, data.norm.human[input$gene,]-1, pch=20, col=day.col.pool.h, main=paste0(input$gene,", human"), 
         ylab="Normalized Expression", xlab="Hour")
    
    plot(1:97, data.norm.mouse[input$gene,]-1, pch=20, col=day.col.pool.m, main=paste0(input$gene,", mouse"), 
         ylab="Normalized Expression", xlab="Hour")
    
    
    plot(1:101, log(data.norm.human[input$gene,]), pch=20, col=day.col.pool.h, main=paste0(input$gene,", human"), 
         ylab="Log Normalized Expression", xlab="Hour")
    
    plot(1:97, log(data.norm.mouse[input$gene,]), pch=20, col=day.col.pool.m, main=paste0(input$gene,", mouse"), 
         ylab="Log Normalized Expression", xlab="Hour")

  })
}