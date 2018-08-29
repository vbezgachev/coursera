plot4 <- function() {
    library(sqldf)
    
    # read file as CSV using SQL to select only needed dates
    test_filename <- "household_power_consumption.txt"
    sql_stmt <- "select * from file where Date = '1/2/2007' or Date = '2/2/2007'"
    
    data <- read.csv.sql(test_filename, sql = sql_stmt, header = TRUE, sep = ";")
    
    # make one date-time column for the date
    data$Date_Time <- do.call(paste, c(data[c(1, 2)], sep = " "))
    data$Date_Time = strptime(data$Date_Time, "%d/%m/%Y %H:%M:%S")
    
    # replace "?" with NA
    data[data == "?"] = NA
    
    # convert strings to numeric values
    data$Global_active_power = as.numeric(data$Global_active_power)
    data$Sub_metering_1 = as.numeric(data$Sub_metering_1)
    data$Sub_metering_2 = as.numeric(data$Sub_metering_2)
    data$Sub_metering_3 = as.numeric(data$Sub_metering_3)
    data$Voltage = as.numeric(data$Voltage)
    data$Global_reactive_power = as.numeric(data$Global_reactive_power)
    
    # create PNG file
    png("plot4.png", width = 480, height = 480, bg = "transparent")
    
    # we have 4 plot (2x2 matrix)
    par(mfrow = c(2, 2))
    
    # plot the global active power
    plot(data$Date_Time, data$Global_active_power, type = "l", ylab = "Global Acitve Power (kilowatts)", xlab = "")
    
    # plot voltage
    plot(data$Date_Time, data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
    
    # plot sub meterings
    plot(data$Date_Time, data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
    lines(data$Date_Time, data$Sub_metering_2, type = "l", col = "blue")
    lines(data$Date_Time, data$Sub_metering_3, type = "l", col = "red")
    legend("topright",
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           col = c("black", "blue", "red"), 
           lwd = 2,
           bty = "n")
    
    # plot global reactive power
    plot(data$Date_Time, data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
    
    dev.off()

    message("Please find plot4.png in your working directory")
}