## Download data file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              "data.zip")

## Extract data file
unzip("data.zip")

## Extract column names
names <- unlist(read.table("household_power_consumption.txt",
                           sep = ";", nrows = 1))

## Read data file, only for dates 2007-02-01 and 2007-02-02, which correspond to
## rows 66637 to 69516 (excluding header row) - a total of 2880 rows.
## (Each day has 24 * 60 = 1440 mins and therefore 1440 observations).
data <- read.table("household_power_consumption.txt", sep = ";", skip = 66637,
                   nrows = 2880, col.names = names, na.strings = "?")

## Create a new column DateTime with full date and time, saved in POSIXt format.
data <- transform(data, DateTime = strptime(paste(Date, Time), 
                                            format = "%d/%m/%Y %H:%M:%S"))

## Plot line chart of Global_active_power against time with y-axis label.
## Save it as plot2.png. Height and width of 480 px are default settings.
png("plot2.png")
with(data, plot(DateTime, Global_active_power, type = "l",
                xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()