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

##Plot the line chart for Global Active Power over time
plot(housesub$Date, housesub$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = NA)

##Save the plot to a png file
dev.copy(png, "plot2.png", height=480, width=480)
dev.off()
