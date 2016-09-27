# Create data file from  Electric power consumption data
fileName = "household_power_consumption.txt"
proj1 <- read.table(fileName, header = TRUE, sep = ";", na.strings="?" , stringsAsFactors=FALSE)

# Please note that running the above command with na.strings="?" didn't convert the numerical data
# to FORMAT so I did not need to convert Global_active_power:Sub_metering_3 to num

# Subset the data by the two dates "2007-02-01" and "2007-02-02"
graph_data <- proj1[proj1$Date %in% c("1/2/2007","2/2/2007"), ]

#Convert the date and time variables to Date/Time classes in R
date_time <- strptime(paste(graph_data$Date, graph_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

# Create vector for Global_active_power
global_active_power <- graph_data$Global_active_power

# Create plot 2
plot(date_time, graph_data$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type ="l")

# Copy histogram to a png file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
