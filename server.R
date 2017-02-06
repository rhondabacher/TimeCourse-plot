shinyServer(function(input, output, session) {
  
  
  
  pool.in <- read.csv("~/Desktop/HUMAN_normEC.csv",row.names=1)
  data.norm.human <- data.matrix(pool.in)+1
  
  pool.in <- read.csv("~/Desktop/MOUSE_normEC.csv",row.names=1)
  data.norm.mouse <- data.matrix(pool.in)+1
  ognames <- rownames(data.norm.mouse)
  rownames(data.norm.mouse) <- toupper(rownames(data.norm.mouse))
  
  names(ognames) <- rownames(data.norm.mouse)
  # allchoices <- intersect(rownames(data.norm.mouse), rownames(data.norm.human))
  
  # updateSelectizeInput(session, 'gene', choices = allchoices, server = TRUE)
  
  #
  # cnames <- colnames(data.norm.human)
  # h.ind <- as.numeric(substr(cnames,2,4))
  # h.ind; length(h.ind)
  # h.ind[2:101] <- h.ind[2:101] + 3
  # t.v <- h.ind
  # names(t.v) <- cnames; print(t.v)
  # day.ind <- ceiling(unique(t.v)/24)
  #
  # day.col <- rainbow(6)
  # day.col[2]<-"yellow2"
  # names(day.col) <- sort(unique(day.ind))
  # day.col.pool.h <- day.col[as.character(day.ind)]
  #
  # cnames <- colnames(data.norm.mouse)
  # h.ind <- as.numeric(substr(cnames,5,6))
  # h.ind; length(h.ind)
  # h.ind[2:97] <- h.ind[2:97] + 3
  # t.v <- h.ind
  # names(t.v) <- cnames; print(t.v)
  #
  # day.ind <- ceiling(unique(t.v)/24)
  #
  # day.col <- rainbow(6)
  # day.col[2]<-"yellow2"
  # names(day.col) <- sort(unique(day.ind))
  # day.col.pool.m <- day.col[as.character(day.ind)]
  #
#
#   getFit <- reactive({
#   fit1 <- lm(data.norm.human[input$gene,]-1 ~ poly(seq(1:101),3))$fitted
#   fit2 <- lm(data.norm.mouse[input$gene,]-1 ~ poly(seq(1:97),3))$fitted
#   fit3 <- lm(log(data.norm.human[input$gene,]) ~ poly(seq(1:101),3))$fitted
#   fit4 <- lm(log(data.norm.mouse[input$gene,]) ~ poly(seq(1:97),3))$fitted
#    List = list(fit1=fit1, fit2=fit2, fit3=fit3, fit4=fit4)
# })
#
#   addline1 <- reactive({
#   	 if (input$poly == TRUE) {
# 		 List = getFit()
# 		 lines(1:101, List$fit1, lwd=2)
# 	 }
#   })
#  addline2 <- reactive({
#  	 if (input$poly == TRUE) {
# 		 List = getFit()
#  		lines(1:97, List$fit2, lwd=2)
# 	}
#   })
#  addline3 <- reactive({
#  	 if (input$poly == TRUE) {
# 		 List = getFit()
#  		lines(1:101, List$fit3, lwd=2)
# 	}
#   })
#  addline4 <- reactive({
#  	 if (input$poly == TRUE) {
# 		 List = getFit()
#  		lines(1:97, List$fit4, lwd=2)
# 	}
# })

   output$plot <- renderPlot({
       par(mfrow=c(2,2), cex=1.5, cex.lab=1, cex.axis=1, cex.main=1.1, mar=c(6,6,2,2))
       plot(1:101, data.norm.human[input$gene,]-1, pch=20, col="red", main=paste0(input$gene,", human"),
            ylab="Normalized Expression", xlab="Hour")

		# addline1()

     plot(1:97, data.norm.mouse[input$gene,]-1, pch=20, col="blue", main=paste0(ognames[input$gene],", mouse"),
          ylab="Normalized Expression", xlab="Hour")
     # addline2()

     plot(1:101, log(data.norm.human[input$gene,]), pch=20, col="red", main=paste0(input$gene,", human"),
          ylab="Log Normalized Expression", xlab="Hour")
     # addline3()

     plot(1:97, log(data.norm.mouse[input$gene,]), pch=20, col="blue", main=paste0(ognames[input$gene],", mouse"),
          ylab="Log Normalized Expression", xlab="Hour")
     # addline4()
}, height=700, width=1000)
})