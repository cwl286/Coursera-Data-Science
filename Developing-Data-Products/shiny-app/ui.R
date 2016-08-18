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

train_data <- read.csv("./data/CTA_-_Ridership_-__L__Station_Entries_-_Daily_Totals.csv")

train_data$date <- as.Date(train_data$date, "%m/%d/%Y")
#train_data$line <- c("Red","Blue","Green","Orange","Brown","Pink","Purple","Yellow")
# Subset the data to entries after the Pink Line opened on June 25 2006
train_data <- subset(train_data, date > "2006-06-24")

# Add column for the train line (e.g. the Red Line)
#train_data$line <- c("Red","Blue","Green","Orange","Brown","Pink","Purple","Yellow")

#red_line <- c(41490, 41430, 41380, 41300, 41270, 41230, 41190, 41200, 41170, 41090, 
#              41000, 40990, 40880, 40760, 40650, 40630, 40540, 40520, 40450, 40240, 40190, 
#              40100, 40080)

#green_line <- c(40020, 40030, 40130)

#brown_line <- c(40090, )

#blue_line <- c(40060, 40070, )

#orange_line <- c(40120, )

#yellow_line <- c(40140, )

#pink_line <- c()

#purple_line <- c()

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("CTA L Ridership By Station Since 2001"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("bins",
                   "Number of bins:",
                   min = 1,
                   max = 50,
                   value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot")
    )
  )
))
