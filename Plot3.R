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

##Plot the energy sub metering over time
plot(housesub$Date, housesub$Sub_metering_1, type = "n", 
     ylab = "Energy sub metering", xlab = NA)
lines(housesub$Date, housesub$Sub_metering_1)
lines(housesub$Date, housesub$Sub_metering_2, col = "red")
lines(housesub$Date, housesub$Sub_metering_3, col = "blue")

##Add legend
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lwd=2)

##Save the plot to a png file
dev.copy(png, "plot3.png", height=480, width=480)
dev.off()
