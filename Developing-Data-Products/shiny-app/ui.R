#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(markdown)
library(DT)

train_data <- read.csv("./data/CTA_-_Ridership_-__L__Station_Entries_-_Daily_Totals.csv")

train_data$date <- as.Date(train_data$date, "%m/%d/%Y")
# Subset the data to entries after the Pink Line opened on June 25 2006
train_data <- subset(train_data, date >= "2015-01-01" & date < "2016-01-01")


# Define UI for application that displays number of passengers at a given station
shinyUI(
  fluidPage(
    titlePanel("CTA Ridership at El Stations in 2015"),
    
    # Create a new Row in the UI for selectInputs
    fluidRow(
      column(4,
             selectInput("stat",
                         "Station:",
                         c("All",
                           unique(as.character(train_data$stationname))))
      ),
      column(4,
             selectInput("date",
                         "Date:",
                         c("All",
                           unique(as.character(train_data$date))))
      )
    ),
    # Create a new row for the table.
    fluidRow(
      DT::dataTableOutput("table")
    )
  )
)