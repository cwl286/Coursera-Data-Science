## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Answer the following question:
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from 
## all sources for each of the years 1999, 2002, 2005, and 2008.

## Find the total emissions for each year and put it into a vector
sumData <- aggregate(Emissions~year, data = NEI, sum)

## Construct a barplot for sumData
barplot(
  (sumData$Emissions)/10^6,  # Divide by 10^6 so labels on y-axis are neater
  col = heat.colors(4, alpha = 1),
  names.arg=sumData$year,
  xlab="Year",
  ylab="PM2.5 Emissions (in millions of Tons)",
  main="Total PM2.5 Emissions in the United States"
)

## Save the plot in a png file
dev.copy(png, file="plot1.png")
dev.off()

## The answer to the question, based on the bar plot, is yes. Total emissions
## have decreased in the United States from 1999 0 2008.