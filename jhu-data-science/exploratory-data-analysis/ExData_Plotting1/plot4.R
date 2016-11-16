data <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?")
dataFiltered <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

dataFiltered <- transform(dataFiltered, Full_Date=paste(Date, Time, sep=" "))
dataFiltered$Full_Date <- strptime(dataFiltered$Full_Date, "%d/%m/%Y %H:%M:%S")

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))
with(dataFiltered, {
  plot(Full_Date, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
  plot(Full_Date, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  plot(Full_Date, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
  lines(Full_Date, Sub_metering_2, type = "l", col = "red")
  lines(Full_Date, Sub_metering_3, type = "l", col = "blue")
  legend("topright", pch = "-", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Full_Date, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})
dev.off()