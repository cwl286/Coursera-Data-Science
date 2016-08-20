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

# Rename the levels of factor daytype to something more meaningful
levels(train_data$daytype) <- c("Saturday", "Sunday/Holiday", "Weekday")
train_data$date <- as.Date(train_data$date, "%m/%d/%Y")
# Subset the data to entries after the Pink Line opened on June 25 2006
train_data <- subset(train_data, date >= "2015-01-01" & date < "2016-01-01")
train_data <- subset(train_data, select = -c(ï..station_id) )

format(train_data$date, "%Y-%b-%d")
months <- format(train_data$date,' %b')
# Define UI for application that displays number of passengers at a given station
shinyUI(
  navbarPage("CTA Rail Ridership in 2015",
             
    tabPanel("Statisitcs",
             selectInput("date",
                         "Date:",
                         c("All",
                           unique(as.character(train_data$date)))),
             
             plotOutput(outputId = "main_plot", height = "300px")
             ),
    
    tabPanel("Table",
             
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
            ),
    
    tabPanel("About",
             fluidRow(
               column(6,
                      includeMarkdown("about.md")
               ),
               column(3,
                      img(class="img-polaroid",
                          src=paste0("http://farm8.static.flickr.com/7525/16111190931_3c78bcde8c.jpg")),
                      tags$small(
                        a(href="http://farm8.static.flickr.com/7525/16111190931_3c78bcde8c.jpg")
                      )
               )
             )
    )
  )
)