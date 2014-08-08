
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

## PNG graphic with 4 plots:
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2))

## 1. Global Active Power over time:
with(power, plot(DateTime, Global_active_power, 
                 type="l", 
                 xlab="",
                 ylab="Global Active Power (kilowatts)"))

## 2. Voltage over time:
with(power, plot(DateTime, Voltage, 
                 type="l", 
                 xlab="datetime",
                 ylab="Voltage"))

## 3. Energy sub metering over time:
with(power, plot(DateTime, Sub_metering_1, type="n",
                 xlab="",
                 ylab="Energy sub metering"))
with(power, lines(DateTime, Sub_metering_1, col="black"))
with(power, lines(DateTime, Sub_metering_2, col="red"))
with(power, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"),
       lwd=1, 
       bty="n")


## 4. Global reactive power by time:
with(power, plot(DateTime, Global_reactive_power, 
                 type="l", 
                 xlab="datetime"))



dev.off()

