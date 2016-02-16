
# Load and transform data
raw_data <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?")
data <- subset(raw_data, Date == "1/2/2007" | Date == "2/2/2007")
rm(raw_data)
data$DateTime <- paste(data$Date, data$Time, sep=" ") # Concatanation of date and time columns
data <- data[, c(10,3,4,5,6,7,8,9)] # remove old date and time columns, move DateTime to the 1st place
data$DateTime <- as.POSIXct(data$DateTime, format="%d/%m/%Y %H:%M:%S") # convert to POSIX calendar time


# Plot4
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
with(data, {
  plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
  plot(DateTime, Voltage, type = "l", xlab="datetime", ylab = "Voltage")
  plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(data$DateTime, data$Sub_metering_2, col="Red")
  lines(data$DateTime, data$Sub_metering_3, col="Blue")
  legend("topright", lty = c(1,1,1), bty = "n", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})
dev.off()

