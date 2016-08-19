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

train_data <- read.csv("./data/CTA_-_Ridership_-__L__Station_Entries_-_Daily_Totals.csv")

train_data$date <- as.Date(train_data$date, "%m/%d/%Y")
#train_data$line <- c("Red","Blue","Green","Orange","Brown","Pink","Purple","Yellow")
# Subset the data to entries after the Pink Line opened on June 25 2006
train_data <- subset(train_data, date > "2006-06-24")


# Define UI for application that displays number of passengers at a given station
shinyUI(navbarPage("Find out how many passengers board the El at a particular station",
                   tabPanel("Table",
                            
                            # Sidebar
                            sidebarLayout(
                              sidebarPanel(
                                helpText("Enter the date and choose the station you are interested in."),
                                dateInput('date',
                                          label = 'Information is available between June 25th, 2006 and April 30th, 2016',
                                          value = "06-25-2006",
                                          min = "06-25-2006", 
                                          max = "04-30-2016",
                                          format = "mm-dd-yyyy"
                                ),
                              ),
                              
                              
                              mainPanel(
                                dataTableOutput('table')
                              )
                            )
                   ),
                   tabPanel("About",
                            mainPanel(
                              includeMarkdown("about.md")
                            )
                   )
)
)   