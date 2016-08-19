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
    data <- train_data
    if (input$stat != "All") {
      data <- data[data$stationname == input$stat,]
    }
    if (input$date != "All") {
      data <- data[data$date == input$date,]
    }
    data
  }))
  
})