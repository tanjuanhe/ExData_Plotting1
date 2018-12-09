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

## Plot black line chart of Sub_metering_1 against time with y-axis label. 
## Save it as plot3.png. Height and width of 480 px are default settings.
png("plot3.png")
with(data, plot(DateTime, Sub_metering_1, type = "l", col = "black",
                xlab = "", ylab = "Energy sub metering"))

## Add red line chart of Sub_metering 2.
with(data, lines(DateTime, Sub_metering_2, col = "red"))

## Add blue line chart of Sub_metering 3.
with(data, lines(DateTime, Sub_metering_3, col = "blue"))

## Add legend in top right corner.
legend("topright", legend = names(data)[7:9], col = c("black", "red", "blue"),
       lty = rep(1,3))

dev.off()