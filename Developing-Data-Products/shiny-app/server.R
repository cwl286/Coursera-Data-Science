#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define server logic required to draw a graph
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # define a ggplot object
    x    <- train_data[1:200,]
    g <- ggplot(data = x, aes(stationname,rides))
    g + geom_point(size = 4, alpha= 1/2, aes(color=daytype))
    
  })
  
})
