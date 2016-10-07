## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Answer the following question:
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
## Use the base plotting system to make a plot answering this question.


## First create a subfile for Baltimore City's emissions. 
## Then, find the total emissions for each year and put it into a vector
baltNEI <- NEI[NEI$fips == "24510",]
baltSumData <- aggregate(Emissions~year, data = baltNEI, sum)

## Construct a barplot for sumData
barplot(
  (baltSumData$Emissions),
  col = heat.colors(4, alpha = 1),
  names.arg=baltSumData$year,
  xlab="Year",
  ylab="PM2.5 Emissions",
  main="Total PM2.5 Emissions in Baltimore City"
)

## Save the plot in a png file
dev.copy(png, file="plot2.png")
dev.off()

## The answer to the question, based on the bar plot, 
## is that is can't be determined. We would need to see more data (i.e more years).