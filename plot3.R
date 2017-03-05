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


data$Date = as.Date(data$Date, format = "%d/%m/%Y")

tmp = paste(data$Date, data$Time)

data$Time = strptime(tmp,format="%Y-%m-%d %H:%M:%S")

with(data, plot(Time, Sub_metering_1 ,main="", xlab="", ylab="Global Active Power (kilowatts)", type="n"))
lines(data$Time, data$Sub_metering_1, col="black")
lines(data$Time, data$Sub_metering_2, col="red")
lines(data$Time, data$Sub_metering_3, col="blue")
legend("topright", lty=c(1,1,1), col = c("black", "red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.copy(png, "plot3.png",width = 480, height = 480)
dev.off()