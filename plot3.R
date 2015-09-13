##Note, make sure "household_power_consumption.txt" is located in current working directory

##Install library "dplyr" if it's not installed
list.of.packages <- c("dplyr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

##Load dplyr for later data manipulation
library(dplyr)

##Read data from "household_power_consumption.txt", save it into myDf
##The data in the text file have header, and all the headers are separated by ';'
myDf <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

##Check the class for each variable
sapply(myDf, class)

##filter out all data from '2007-2-1' and '2007-2-2' and save it into myDf
myDf <- filter(myDf, Date %in% c("1/2/2007", "2/2/2007"))

##Convert all factor class variables
##'Date', 'Time' factors are converted into character class and then "POSIXlt" "POSIXt"  class
##All other 'numeric' Factors are converted into character class and then numeric class 
myDf <- transform(myDf, 
                  DateTime = strptime(paste(as.character(Date), as.character(Time)), format = "%d/%m/%Y %H:%M:%S"),
                  Global_active_power = as.numeric(as.character(Global_active_power)), 
                  Global_reactive_power = as.numeric(as.character(Global_reactive_power)), 
                  Voltage = as.numeric(as.character(Voltage)), 
                  Sub_metering_1 = as.numeric(as.character(Sub_metering_1)), 
                  Sub_metering_2 = as.numeric(as.character(Sub_metering_2)))

png(filename = "plot3.png")

##plot for task three
with(myDf, plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black"))
with(myDf, points(DateTime, Sub_metering_2, type = "l", col = "red"))
with(myDf, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##close the device
dev.off()