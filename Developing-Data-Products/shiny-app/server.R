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
library(DT)

# Define a server for the Shiny app
shinyServer(function(input, output) {
  
  # Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({

    if (input$stat != "All") {
      train_data <- train_data[train_data$stationname == input$stat,]
    }
    if (input$date != "All") {
      train_data <- train_data[train_data$date == input$date,]
    }
    train_data
  }))
  
  output$main_plot <- renderPlot({
    if (input$stat1 != "All") {
      train_data <- train_data[train_data$stationname == input$stat1,]
    }
    if (input$date1 != "All") {
      train_data <- train_data[train_data$date == input$date1,]
    }
    g <- ggplot(data = train_data, aes(train_data$date, train_data$rides))
    g + geom_point(size=4, alpha= 1/2, aes(color=train_data$daytype)) + geom_smooth() + theme_bw()
  })
  
})