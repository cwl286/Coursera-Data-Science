# Create data file from  Electric power consumption data
fileName = "household_power_consumption.txt"
proj1 <- read.table(fileName, header = TRUE, sep = ";", na.strings="?" , stringsAsFactors=FALSE)

# Please note that running the above command with na.strings="?" didn't convert the numerical data
# to FORMAT so I did not need to convert Global_active_power:Sub_metering_3 to num

# Subset the data by the two dates "2007-02-01" and "2007-02-02"
graph_data <- proj1[proj1$Date %in% c("1/2/2007","2/2/2007"), ]

# Clean up space by removing big data set
rm(proj1)

#Convert the date and time variables to Date/Time classes in R
date_time <- strptime(paste(graph_data$Date, graph_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

# Create vectors for sub_metering variables
sub_metering_1 <- graph_data$Sub_metering_1
sub_metering_2 <- graph_data$Sub_metering_2
sub_metering_3 <- graph_data$Sub_metering_3

# Create plot 3
plot(date_time, sub_metering_1, xlab = "", ylab = "Energy Submetering", type ="l")
lines(date_time, sub_metering_2, type ="l", col = "red")
lines(date_time, sub_metering_3, type ="l", col = "blue")
legend("topright",inset=.05, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2, col = c("black", "red","blue"), cex = 0.95)

# Copy plot to a png file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()


