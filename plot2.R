

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

## Combine Date(dd/mm/yyyy) + Time(hh:mm:ss):
power$DateTime <- strptime(paste(power$Date, power$Time), 
                           format="%d/%m/%Y %H:%M:%S")


## Plot of Global_active_power over time:
png(filename="plot2.png", width=480, height=480)
with(power, plot(DateTime, Global_active_power, 
                 type="l", 
                 xlab="",
                 ylab="Global Active Power (kilowatts)"))
dev.off()

