## Load ggplot2
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Answer the following question:
## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle
## sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

## Find the emissions from motor vehicles for Baltimore City and Los Angeles County
## for each year and put it into a vector
baltLAMotorNEI <- NEI[(NEI$fips=="24510" | NEI$fips=="06037") & NEI$type=="ON-ROAD",]
baltLAMotorYearData <- aggregate(Emissions~year + fips, data = baltLAMotorNEI, sum)

## Construct a labeller function for use in the facet_grid portion of the bar plot.
fips_labeller <- function(var, value){
  value <- as.character(value)
  if (var=="fips") { 
    value[value=="24510"] <- "Baltimore City"
    value[value=="06037"]   <- "Los Angeles County"
  }
  return(value)
}

## Construct a barplot for baltSumData
q6BarPlot <- ggplot(baltLAMotorYearData, aes(factor(year), Emissions, fill = fips)) + 
  geom_bar(stat = "identity") + 
  theme_bw() +
  guides(fill = FALSE) +
  facet_grid(.~fips, scales = "free", space = "free", labeller = fips_labeller) +
  labs(x = "year", y = "Emissions (Tons)", title = "PM2.5 Emissions by Motor Vehicles - Los Angeles County vs Baltimore City")

## Save the plot in a png file
ggsave("plot6.png")

## The answer to the question is that there has been a greater change in emiisions in LA county