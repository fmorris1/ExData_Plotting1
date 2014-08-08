## This R script loads the Electric power consumption Dataset which measurements electric power consumption
## in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities
## and some sub-metering values are available. 
## 
## Plot 1 creates a histogram of observed Global Active Power readings (kW) over the date range from 2/1/2007 to 2/2/2007
## and saves the output as a PNG file.


##  Read the electric power consumption dataset

classes <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
PowerCon<- read.table("household_power_consumption.txt", sep =";",header = TRUE, na.strings="?", colClasses=classes)

## Convert the Time & Data varaible to a single Date Formatted variable

PowerCon$RealTime <- paste(PowerCon$Date, PowerCon$Time)
PowerCon$RealTime <- strptime(PowerCon$RealTime, "%d/%m/%Y %H:%M:%S")

## Select the range for the plot

PlotRange <- PowerCon[PowerCon$RealTime >= "2007-02-01 00:00:00" & PowerCon$RealTime <= "2007-02-02 23:59:59",]

## Create the plot #1

png(file = "plot1.png", width = 480, height = 480) ## Create Plot 1 and save to a PNG file
hist(PlotRange$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")
dev.off() ## close the PNG device!


