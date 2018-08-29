plot3 <- function() {
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
    
    # convert strings in Sub_meterings columns to numeric values
    data$Sub_metering_1 = as.numeric(data$Sub_metering_1)
    data$Sub_metering_2 = as.numeric(data$Sub_metering_2)
    data$Sub_metering_3 = as.numeric(data$Sub_metering_3)
    
    # create PNG file
    png("plot3.png", width = 480, height = 480, bg = "transparent")
    
    # plot sub meterings
    plot(data$Date_Time, data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
    lines(data$Date_Time, data$Sub_metering_2, type = "l", col = "blue")
    lines(data$Date_Time, data$Sub_metering_3, type = "l", col = "red")
    legend("topright",
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           col = c("black", "blue", "red"), 
           lwd = 2)
    
    dev.off()

    message("Please find plot3.png in your working directory")
}