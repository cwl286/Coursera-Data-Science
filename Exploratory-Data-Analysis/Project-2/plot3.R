## Load ggplot2
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

## Answer the following question:
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
## Which have seen increases in emissions from 1999-2008? 
## Use the ggplot2 plotting system to make a plot answer this question.


## First create a subfile for Baltimore City's emissions. 
## Then, find the total emissions for each year and put it into a vector
baltNEI <- NEI[NEI$fips == "24510",]
baltSumData <- aggregate(Emissions~year + type, data = baltNEI, sum)

## Construct a barplot for baltSumData
q3BarPlot <- ggplot(baltNEI, aes(factor(year), Emissions, fill = type)) + 
             geom_bar(stat = "identity") + 
             theme_bw() +
             guides(fill = FALSE) +
             facet_grid(.~type, scales = "free", space = "free") +
             labs(x = "year", y = "Emissions (Tons)", title = "PM2.5 Emissions - Baltimore City - by source type")

## Save the plot in a png file
ggsave("plot3.png")

## The answer to the question is Non-Road, Nonpoint, and On-Road