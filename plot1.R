# Plot 1 - histogram

# Import data for range 1/2/2007 to 2/2/2007
  # Assumes file is in working directory
  fileName <- "household_power_consumption.txt"

  # Find first row to import and number of rows to skip
  importFirst <- grep("^1/2/2007", readLines(fileName))[1]
  skipRows <- importFirst - 1 
    
  # Find row just after the last row to import
  importLastNext <- grep("^3/2/2007", readLines(fileName))[1]

  # Calculate number of rows to import
  importRows <- importLastNext-importFirst
  
  # Import headings
  headings <- read.table(fileName, sep = ";", nrows = 1)
  headings <- as.character(unname(unlist(headings[1,])))

  # Import data 
  powerData <- read.table(fileName, sep = ";", col.names = headings, skip = skipRows, nrows = importRows, na.strings="?")
  
# Convert date column to date and time; remove time column
  dateTime <- paste(powerData$Date, powerData$Time)
  powerData$Date <- as.POSIXlt(dateTime, format = "%d/%m/%Y %H:%M:%S")
  powerData$Time <- NULL
  
# Open PNG device
  png("plot1.png", width = 480, height = 480)
  
# Plot histogram
  hist(powerData$Global_active_power, 
       col = "red", 
       main = "Global Active Power", 
       xlab = "Global Active Power (kilowatts)"
       )
  
# Close PNG device
  dev.off()
  
