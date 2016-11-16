data <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?")
dataFiltered <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

dataFiltered <- transform(dataFiltered, Full_Date=paste(Date, Time, sep=" "))
dataFiltered$Full_Date <- strptime(dataFiltered$Full_Date, "%d/%m/%Y %H:%M:%S")

png("plot3.png", width = 480, height = 480)
plot(dataFiltered$Full_Date, dataFiltered$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(dataFiltered$Full_Date, dataFiltered$Sub_metering_2, type = "l", col = "red")
lines(dataFiltered$Full_Date, dataFiltered$Sub_metering_3, type = "l", col = "blue")
legend("topright", pch = "-", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()