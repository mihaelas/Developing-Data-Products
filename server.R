library(shiny)
#library(UsingR)
library(gplots)
library(stats)

shinyServer(function(input, output) {
#output$contents <- renderTable({
  
  # input$file1 will be NULL initially. After the user selects and uploads a 
  # file, it will be a data frame with 'name', 'size', 'type', and 'datapath' 
  # columns. The 'datapath' column will contain the local filenames where the 
  # data can be found.
  
  #inFile <- input$file1
  
  #if (is.null(inFile))
    #return(NULL)
   #y<-read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)
   
  #})

output$view <- renderTable({
  inFile <- input$file1
  if (is.null(inFile))
    return(NULL)
  y<-read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)
  x<-data.frame((y[, 2:ncol(y)]))
  head(x)
  
})

output$newHist1 <- renderPlot({
  
  inFile <- input$file1
  
  if (is.null(inFile))
    return(NULL)
  y<-read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)
  x<-data.frame((y[, 2:ncol(y)]))
  z<-x[[2]]+0.00001
  col_1<-log2(z)
  hist(col_1, col = 'red', border = 'black')
})

  output$newHist <- renderPlot({

    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    y<-read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)
    x<-data.frame((y[, 2:ncol(y)]))
    p<-x[[ncol(x)]]+0.00001
    col_n<-log2(p)
    hist(col_n, col = 'red', border = 'black')
    mu<-colMeans(x,na.rm = FALSE, dims = 1)
    s<-apply(x, 2, sd)
    output$oid1 <- renderPrint({mu})
    output$oid2 <- renderPrint({s})
  }) 

output$myPlot <- reactivePlot(function(){
  my_palette <- colorRampPalette(c("black", "grey"))(n = 299)
  
  inFile <- input$file1
  
  if (is.null(inFile))
    return(NULL)
  y<-read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)
  d<-cor(y[,2:ncol(y)])
  #output$oid3 <- renderPrint({y})
  heatmap.2(d,dendrogram='none', Rowv=FALSE, Colv=FALSE,trace='none',col=my_palette) 
})

output$plot2 <- renderPlot({
  inFile <- input$file1
  
  if (is.null(inFile))
    return(NULL)
  y<-read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)
  x<-data.frame((y[, 2:ncol(y)]))
  trmtx <- t(x)
  d1<-dist(trmtx)
  #output$oid3 <- renderPrint({d1})
  hc<-hclust(d1,method="average",members=NULL)
  plot(hc)
})

output$view <- renderTable({
  inFile <- input$file1
  if (is.null(inFile))
    return(NULL)
  y<-read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)
  head(y)
})

})

