require(sqldf)
require(lubridate)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fzip <- "household_power_consumption.zip"
file <- "household_power_consumption.txt"

#download data source if needed
if (!file.exists(fzip)) {
	download.file(url, fzip)
	unzip(fzip)
}

# Read data
ds <- read.csv.sql(file, 
				   "select * from file where Date in ('1/2/2007','2/2/2007')", 
				   sep = ";")

Sys.setlocale("LC_TIME", "English")
# Add a date time column
ds$datetime <- dmy_hms(paste(ds$Date,ds$Time))

# 2 columns by 2 rows plot
par(mfrow = c(2, 2))
par(cex.axis = 0.75, cex.lab = 0.75)

## 1- Plot
plot(ds$datetime, ds$Global_active_power, 
	 xlab="", ylab="Global Active Power (kilowatts)", type="n")
lines(ds$datetime, ds$Global_active_power, type="l")

## 2- Plot
plot(ds$datetime, ds$Voltage, 
	 xlab="datetime", ylab="Voltage", type="n")
lines(ds$datetime, ds$Voltage, lwd=0.2, type="l")

## 3- Plot
plot(ds$datetime, ds$Sub_metering_1, xlab="", ylab="Energy sub metering", type="n")
lines(ds$datetime, ds$Sub_metering_1, type="l")
lines(ds$datetime, ds$Sub_metering_2, type="l", col="red")
lines(ds$datetime, ds$Sub_metering_3, type="l", col="blue")
legend("topright", lwd=1, cex=0.65, bty="n",
	   col=c("black","red","blue"), legend=c("Sub_metering_1  ", "Sub_metering_2", "Sub_metering_3"))

## 4- Plot
plot(ds$datetime, ds$Global_reactive_power, 
	 xlab="datetime", ylab="Global_reactive_power", type="n")
lines(ds$datetime, ds$Global_reactive_power, lwd = 0.1, type="l")

# Save png image
dev.copy(png, file = "plot4.png")
dev.off()