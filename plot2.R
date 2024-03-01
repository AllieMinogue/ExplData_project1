## Download the household_power_consumption file & filter the date to 1/2/2007 & 2/2/2007

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile = "eConsumption.zip",mode = "wb")
unzip("eConsumption.zip",files = "household_power_consumption.txt")
consumption <- read.table("household_power_consumption.txt",sep = ";",header = TRUE)
consumption <- consumption[consumption$Date %in% c("1/2/2007","2/2/2007"),]

## convert Date & Time column from character to date & time format

consumption$DateTime <- paste(consumption$Date,consumption$Time,sep = " ")
consumption$DateTime <- as.POSIXlt(consumption$DateTime,format = "%d/%m/%Y %H:%M:%S")
consumption$Global_active_power <- as.numeric(consumption$Global_active_power)

##plot

par(mar = c(4,4,2,2))
plot(consumption$DateTime,consumption$Global_active_power,
     xlab= "",ylab = "Global Active Power(kilowatts)",
     type = "l",xaxt = "n")
axis.POSIXct(1,consumption$DateTime, format = "%a")
dev.copy(png,file = "plot2.png")
dev.off()