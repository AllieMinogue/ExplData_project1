## Download the household_power_consumption file & filter the date to 1/2/2007 & 2/2/2007

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile = "eConsumption.zip",mode = "wb")
unzip("eConsumption.zip",files = "household_power_consumption.txt")
consumption <- read.table("household_power_consumption.txt",sep = ";",header = TRUE)
consumption <- consumption[consumption$Date %in% c("1/2/2007","2/2/2007"),]

## convert column classes

consumption$DateTime <- paste(consumption$Date,consumption$Time,sep = " ")
consumption$DateTime <- as.POSIXlt(consumption$DateTime,format = "%d/%m/%Y %H:%M:%S")
names(consumption)
consumption$Global_active_power <- as.numeric(consumption$Global_active_power)
consumption$Global_reactive_power <- as.numeric(consumption$Global_reactive_power)
consumption$Voltage <- as.numeric(consumption$Voltage)
consumption$Global_intensity <- as.numeric(consumption$Global_intensity)
consumption$Sub_metering_1 <- as.numeric(consumption$Sub_metering_1)
consumption$Sub_metering_2 <- as.numeric(consumption$Sub_metering_2)
consumption$Sub_metering_3 <- as.numeric(consumption$Sub_metering_3)

## plot

par(mfrow = c(2,2),mar = c(4,4,2,2))

plot(consumption$DateTime,consumption$Global_active_power,
     xlab= "",ylab = "Global Active Power",
     type = "l",xaxt = "n")
axis.POSIXct(1,consumption$DateTime, format = "%a")

plot(consumption$DateTime,consumption$Voltage,
     xlab= "datetime",ylab = "Voltage",
     type = "l",xaxt = "n")
axis.POSIXct(1,consumption$DateTime, format = "%a")

plot(consumption$DateTime,consumption$Sub_metering_1,type = "n",xlab = "",ylab = "Energy sub metering",xaxt = "n")
axis.POSIXct(1,consumption$DateTime, format = "%a")
points(consumption$DateTime,consumption$Sub_metering_1,type = "l",col = "black")
points(consumption$DateTime,consumption$Sub_metering_2,type = "l",col = "red")
points(consumption$DateTime,consumption$Sub_metering_3,type = "l",col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lty = 1,cex = 0.5)

plot(consumption$DateTime,consumption$Global_reactive_power,
     xlab= "datetime",ylab = "Global_reactive_power",
     type = "l",xaxt = "n")
axis.POSIXct(1,consumption$DateTime, format = "%a")

dev.copy(png,file = "plot4.png")
dev.off()