## Download the household_power_consumption file & filter the date to 1/2/2007 & 2/2/2007

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile = "eConsumption.zip",mode = "wb")
unzip("eConsumption.zip",files = "household_power_consumption.txt")
consumption <- read.table("household_power_consumption.txt",sep = ";",header = TRUE)
consumption <- consumption[consumption$Date %in% c("1/2/2007","2/2/2007"),]

## convert Date & Time column from character to date & time format

consumption$DateTime <- paste(consumption$Date,consumption$Time,sep = " ")
consumption$DateTime <- as.POSIXlt(consumption$DateTime,format = "%d/%m/%Y %H:%M:%S")
consumption$Sub_metering_1 <- as.numeric(consumption$Sub_metering_1)
consumption$Sub_metering_2 <- as.numeric(consumption$Sub_metering_2)
consumption$Sub_metering_3 <- as.numeric(consumption$Sub_metering_3)

## plot

par(mar = c(4,4,2,2))
plot(consumption$DateTime,consumption$Sub_metering_1,type = "n",xlab = "",ylab = "Energy sub metering",xaxt = "n")
axis.POSIXct(1,consumption$DateTime, format = "%a")
points(consumption$DateTime,consumption$Sub_metering_1,type = "l",col = "black")
points(consumption$DateTime,consumption$Sub_metering_2,type = "l",col = "red")
points(consumption$DateTime,consumption$Sub_metering_3,type = "l",col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lty = 1)
dev.copy(png,file = "plot3.png")
dev.off()