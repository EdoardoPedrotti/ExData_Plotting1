library(sqldf)
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("data")) {
  print("creating folder")
  dir.create("data")
  
  print("downloading file")
  download.file(fileUrl, destfile = "./data/power_consumption.zip", method="curl")
  unzip("./data/power_consumption.zip", exdir="data")
} else {
  if(!file.exists("data/household_power_consumption.txt")) {
    print("downloading file")
    download.file(fileUrl, destfile = "./data/power_consumption.zip", method="curl")
    unzip("./data/power_consumption.zip", exdir="data")
  }
}


data = read.csv.sql("data/household_power_consumption.txt", "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", sep = ";")

with(data, hist(Global_active_power, col="red", main="Global Active Power", 
                xlab="Global Active Power (kilowatts)"))

dev.copy(png, "plot1.png",width = 480, height = 480)
dev.off()

