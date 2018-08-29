plot1 <- function() {
    library(sqldf)
    
    # read file as CSV using SQL to select only needed dates
    test_filename <- "household_power_consumption.txt"
    sql_stmt <- "select * from file where Date = '1/2/2007' or Date = '2/2/2007'"
    
    data <- read.csv.sql(test_filename, sql = sql_stmt, header = TRUE, sep = ";")
        
    # replace "?" with NA
    data[data == "?"] = NA
    
    # convert strings in Global_active_power column to numeric values
    data$Global_active_power = as.numeric(data$Global_active_power)
        
    # create PNG file
    png("plot1.png", width = 480, height = 480, bg = "transparent")
    
    # construct global active power histogram
    hist(data$Global_active_power, 
         col = "red",
         border = "black", 
         main = "Global Active Power", 
         xlab = "Global Active Power (kilowatts)")
    
    dev.off()

    message("Please find plot1.png in your working directory")
}