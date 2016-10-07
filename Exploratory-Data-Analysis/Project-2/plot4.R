## Load ggplot2
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Answer the following question:
## Across the United States, how have emissions from 
## coal combustion-related sources   1999-2008?


## Find the emissions from coal combustion for each year and put it into a vector
isCoal <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
coalSources <- SCC[isCoal,]
coalEmissions <- NEI[NEI$(SCC %in% coalSources$SCC,]
coalEmissions[4] <- coalEmissions[4]/10^3
coalYearData <- aggregate(Emissions~year, data = coalEmissions, sum)

## Construct a barplot for sumData
q4BarPlot <- ggplot(coalYearData, aes(factor(year), Emissions, fill = Emissions)) + 
  geom_bar(stat = "identity") + 
  theme_bw() +
  guides(fill = FALSE) +
  labs(x = "year", y = "Emissions (Thousands of Tons)", title = "PM2.5 Emissions from Coal Combustion-Related Sources")

## Save the plot in a png file
ggsave("plot4.png")

## The answer to the question, based on the bar plot, is yes. Total emissions from coal sources
## have decreased in the United States from 1999 0 2008