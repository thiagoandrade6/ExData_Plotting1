plot4 <- function() {
  
  library(sqldf)
  library(dplyr)
  
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  file <- download.file(url, destfile = "Downloads/exdata.zip")
  unzip("Downloads/exdata.zip", exdir = "Downloads/")
  
  csv_1_2_2007 <- read.csv.sql(file = "Downloads/household_power_consumption.txt", sql = "select * from file where Date == '1/2/2007'", header = TRUE, sep = ";")
  csv_2_2_2007 <- read.csv.sql(file = "Downloads/household_power_consumption.txt", sql = "select * from file where Date == '2/2/2007'", header = TRUE, sep = ";")
  df <- bind_rows(csv_1_2_2007, csv_2_2_2007)
  
  dateTime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
  
  png("plot4.png", width=480, height=480)
  
  par(mfrow = c(2, 2))
  plot(dateTime, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power(kilowatts)")
  
  plot(dateTime, df$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  
  plot(dateTime, df$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(dateTime, df$Sub_metering_2, col = "red")
  lines(dateTime, df$Sub_metering_3, col = "blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, lwd = 2.5, bty = "o")
  
  plot(dateTime, df$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global Reactive Power")
  
  dev.off()
}