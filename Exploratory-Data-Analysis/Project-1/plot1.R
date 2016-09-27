# Create data file from  Electric power consumption data
fileName = "household_power_consumption.txt"
proj1 <- read.table(fileName, header = TRUE, sep = ";", na.strings="?" , stringsAsFactors=FALSE)

# Subset the data by the two dates "2007-02-01" and "2007-02-02"
graph_data <- proj1[proj1$Date %in% c("1/2/2007","2/2/2007"), ]

#Convert the date and time variables to Date/Time classes in R
datetime <- strptime(paste(graph_data$Date, graph_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

# Create plot 1
hist(graph_data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")

# Copy histogram to a png file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

