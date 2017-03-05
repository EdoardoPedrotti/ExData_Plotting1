if(!file.exists("data")) dir.create("data")

fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/power_consumption.zip", method="curl")
unzip("./data/power_consumption.zip", exdir="data")

data = read.csv.sql("data/household_power_consumption.txt", "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", sep = ";")
