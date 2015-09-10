plot1 <- function() {
  
  library(sqldf)
  library(dplyr)
  
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  file <- download.file(url, destfile = "Downloads/exdata.zip")
  unzip("Downloads/exdata.zip", exdir = "Downloads/")
  
  csv_1_2_2007 <- read.csv.sql(file = "Downloads/household_power_consumption.txt", sql = "select * from file where Date == '1/2/2007'", header = TRUE, sep = ";")
  csv_2_2_2007 <- read.csv.sql(file = "Downloads/household_power_consumption.txt", sql = "select * from file where Date == '2/2/2007'", header = TRUE, sep = ";")
  df <- bind_rows(csv_1_2_2007, csv_2_2_2007)
  
  hist(df$Global_active_power, main = "Global Active Power", xlab = "Global Active Power(kilowatts)", col = "red")
  
  dev.copy(png, 'plot1.png')
  dev.off()
}