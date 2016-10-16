##Assuming file has already been downloaded into the current
##working directory and unzipped

##Read in the data from the file
setwd("./exdata%2Fdata%2Fhousehold_power_consumption")
house <- read.table("household_power_consumption.txt", 
                    header = TRUE, na.strings = "?", sep = ";")

##Convert the date column to dates
house$Date <- as.Date(house$Date, "%d/%m/%Y")

##Subset the data to cover only the dates we are looking for
housesub <- house[house$Date == as.Date("2007-02-01") | 
                          house$Date == as.Date("2007-02-02"),]

##Combine the Date and Time columns
housesub$Date <- as.POSIXct(paste(housesub$Date, housesub$Time), 
                            format = "%Y-%m-%d %H:%M:%S")

##remove the redutant time column
housesub <- housesub[,-2]

##Set parameters to make 4 plots on the screen and set the margins
par(mfrow = c(2, 2), mar = c(4,4,2,2))

##Plot the 4 graphs
plot(housesub$Date, housesub$Global_active_power, type = "l", 
     ylab = "Global Active Power", xlab = NA)
plot(housesub$Date, housesub$Voltage, type = "l", xlab = "datetime", 
     ylab = "Voltage")
plot(housesub$Date, housesub$Sub_metering_1, type = "n", 
     ylab = "Energy sub metering", xlab = NA)
lines(housesub$Date, housesub$Sub_metering_1)
lines(housesub$Date, housesub$Sub_metering_2, col = "red")
lines(housesub$Date, housesub$Sub_metering_3, col = "blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lwd=2)
with(housesub, plot(Date, Global_reactive_power, type = "l", xlab = "datetime"))

##Save the plot to a png file
dev.copy(png, "plot4.png")
dev.off()