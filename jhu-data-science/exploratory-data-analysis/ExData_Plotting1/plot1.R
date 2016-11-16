data <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?")
dataFiltered <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]
png("plot1.png", width = 480, height = 480)
hist(dataFiltered$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "#DC401A")
dev.off()