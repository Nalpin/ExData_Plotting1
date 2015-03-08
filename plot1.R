require(sqldf)

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

hist(df$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", 
	 main = "Global Active Power")

# Save png image
dev.copy(png, file = "plot1.png")
dev.off()