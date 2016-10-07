## Load ggplot2
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Answer the following question:
## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 


## Find the emissions from motor vehicles for each year and put it into a vector
baltMotorNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",]
baltMotorYearData <- aggregate(Emissions~year, data = baltMotorNEI, sum)

## Construct a barplot for sumData
q5BarPlot <- ggplot(baltMotorYearData, aes(factor(year), Emissions, fill = Emissions)) + 
  geom_bar(stat = "identity") + 
  theme_bw() +
  guides(fill = FALSE) +
  labs(x = "year", y = "Emissions (Tons)", title = "PM2.5 Emissions from Motor Vehicles in Baltimore City")

## Save the plot in a png file
ggsave("plot5.png")

## The answer to the question, based on the bar plot, is yes. Total emissions from motor vehicles
## have decreased in Baltimore City from 1999 t0 2008