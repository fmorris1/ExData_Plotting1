## This R script loads the Electric power consumption Dataset which measurements electric power consumption
## in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities
## and some sub-metering values are available. 
## 
## Plot 4 creates plots of observed Global Active Power readings, voltage, energy by submeter and global reactive
## power over the date range from 2/1/2007 to 2/2/2007and saves the output as a PNG file.


##  Read the electric power consumption dataset

classes <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
PowerCon<- read.table("household_power_consumption.txt", sep =";",header = TRUE, na.strings="?", colClasses=classes)

## Convert the Time & Data varaible to a single Date Formatted variable

PowerCon$RealTime <- paste(PowerCon$Date, PowerCon$Time)
PowerCon$RealTime <- strptime(PowerCon$RealTime, "%d/%m/%Y %H:%M:%S")

## Select the range for the plot

PlotRange <- PowerCon[PowerCon$RealTime >= "2007-02-01 00:00:00" & PowerCon$RealTime <= "2007-02-02 23:59:59",]

## Create the plot #4

png(file = "plot4.png", width = 480, height = 480) ## Create Plot 4 and save to a PNG file
par(mfrow =c(2,2), mar = c(4,4,4,4), oma = c(0,0,0,0))
with(PlotRange, {
  plot(RealTime, Global_active_power, ylab = "Global Active Power", xlab = "", type = "l")
  plot(RealTime, Voltage, ylab = "Voltage", xlab = "datetime", type = "l")
  with(PlotRange, {
    plot(RealTime,Sub_metering_1, type="n", ann = FALSE) 
    lines(RealTime,Sub_metering_1, type = "l", col = "black")
    lines(RealTime,Sub_metering_2, type = "l", col="red")
    lines(RealTime,Sub_metering_3, type = "l", col="blue")
    legend("topright",col = c("black", "red", "blue"), pch = "____", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    title("",xlab="", ylab="Energy sub metering")
  })
  plot(RealTime, Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "l")
})
dev.off() ## close the PNG device
    