

## Read all household power data:
power <- read.table("household_power_consumption.txt", 
                    header=TRUE,
                    na.strings = c("?"),
                    sep=";",
                    # additional params improve speed + memory use:
                    colClasses=c(rep("character", 2), rep("numeric", 7)),
                    nrows=2075300,
                    comment.char="")

## Filter to Dates 01/02/2007 and 02/02/2007:
date_filter <- (power$Date=='1/2/2007') | (power$Date=='2/2/2007');
power <- power[date_filter,]

## Histogram of Global_active_power:
png(filename="plot1.png", width=480, height=480)
with(power, hist(Global_active_power, main="Global Active Power",
                 xlab="Global Active Power (kilowatts)",
                 col="red"))
dev.off()