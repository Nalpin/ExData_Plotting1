require(sqldf)
require(lubridate)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fzip <- "household_power_consumption.zip"
file <- "household_power_consumption.txt"

if (!file.exists(fzip)) {
	download.file(url, fzip)
	unzip(fzip)
}

ds <- read.csv.sql(file, 
				   "select * from file where Date in ('1/2/2007','2/2/2007')", 
				   sep = ";")

Sys.setlocale("LC_TIME", "English")
ds$datetime <- dmy_hms(paste(ds$Date,ds$Time))

plot(ds$datetime, ds$Sub_metering_1, xlab="", ylab="Energy sub metering", type="n")
lines(ds$datetime, ds$Sub_metering_1, type="l")
lines(ds$datetime, ds$Sub_metering_2, type="l", col="red")
lines(ds$datetime, ds$Sub_metering_3, type="l", col="blue")
legend("topright", lwd=3, col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Save png image
dev.copy(png, file = "plot3.png")
dev.off()