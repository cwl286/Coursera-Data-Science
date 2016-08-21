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

train_data <- read.csv("./data/CTA_-_Ridership_-__L__Station_Entries_-_Daily_Totals.csv")

# Rename the levels of factor daytype to something more meaningful
levels(train_data$daytype) <- c("Saturday", "Sunday/Holiday", "Weekday")
train_data$date <- as.Date(train_data$date, "%m/%d/%Y")

# Subset the data to entries after the Pink Line opened on June 25 2006
train_data <- subset(train_data, date >= "2015-01-01" & date < "2016-01-01")
#train_data <- subset(train_data, select = -c(ï..station_id) )

# Subset the data to entries for Red Line stations
red_line <- c('Sheridan',  'Morse', 'Sox-35th-Dan Ryan', '79th', 'Grand/State', 'Berwyn', '95th/Dan Ryan', 'Washington/State', 'Wilson', 
              'Jackson/State', 'Clark/Division', 'North/Clybourn', 'Granville', 'Lawrence', 'Thorndale', 'Howard', '63rd-Dan Ryan', '69th', 'Cermak-Chinatown', 
              'Monroe/State', 'Garfield-Dan Ryan', 'Jarvis', 'Argyle', 'Fullerton', '47th-Dan Ryan', 'Loyola', 'Belmont-North Main', 'Bryn Mawr', 'Roosevelt', 
              'Addison-North Main', '87th', 'Chicago/State', 'Harrison', 'Lake/State')

train_data <- train_data[train_data$stationname %in% red_line, ]

format(train_data$date, "%Y-%b-%d")
months <- format(train_data$date,' %b')

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
    
    # Note how multiline ggplot commands are broken up - no leading '+' on new line
    g + geom_point(size=4, alpha= 1/2, aes(color=train_data$daytype)) + 
      geom_smooth(colour="#AC0000") + 
      labs(title= 'CTA Red Line Ridership in 2015', x= 'Date', y= 'Number of Riders')  + 
      labs(colour = "Type of Day") + theme_bw()
  })
  
})