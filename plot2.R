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
ds$datetime <- dmy_hms(paste(df$Date,df$Time))

plot(ds$datetime, ds$Global_active_power, 
	 xlab="", ylab="Global Active Power (kilowatts)", type="n")
lines(ds$datetime, ds$Global_active_power, type="l")

# Save png image
dev.copy(png, file = "plot2.png")
dev.off()