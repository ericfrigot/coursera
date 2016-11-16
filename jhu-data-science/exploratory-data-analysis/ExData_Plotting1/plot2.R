data <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?")
dataFiltered <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

dataFiltered <- transform(dataFiltered, Full_Date=paste(Date, Time, sep=" "))
dataFiltered$Full_Date <- strptime(dataFiltered$Full_Date, "%d/%m/%Y %H:%M:%S")

png("plot2.png", width = 480, height = 480)
plot(dataFiltered$Full_Date, dataFiltered$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()