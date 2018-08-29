plot2 <- function() {
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
    
    # convert strings in Global_active_power column to numeric values
    data$Global_active_power = as.numeric(data$Global_active_power)
    
    # create PNG file
    png("plot2.png", width = 480, height = 480, bg = "transparent")
    
    # plot the global active power
    plot(data$Date_Time, data$Global_active_power, type = "l", ylab = "Global Acitve Power (kilowatts)", xlab = "")
    
    dev.off()

    message("Please find plot2.png in your working directory")
}