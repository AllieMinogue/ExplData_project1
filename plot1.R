url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile = "eConsumption.zip",mode = "wb")
unzip("eConsumption.zip",files = "household_power_consumption.txt")
consumption <- read.table("household_power_consumption.txt",sep = ";",header = TRUE)
consumption <- consumption[consumption$Date %in% c("1/2/2007","2/2/2007"),]
consumption$Global_active_power <- as.numeric(consumption$Global_active_power)
hist(consumption$Global_active_power,main = "Global Active Power",xlab = "Global Active Power (kilowatts)",ylab = "Frequency",col = "red")
dev.copy(png,file = "plot1.png")
dev.off()