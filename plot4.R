# Please make sure this text file, "household_power_consumption.txt" 
# is in your working space

filename <- "household_power_consumption.txt"
temp <- read.table(filename, header=TRUE, sep=";", stringsAsFactors=FALSE)
dat <- subset(temp, (temp$Date=="1/2/2007") | (temp$Date=="2/2/2007") )

dat$Date <- as.Date(dat$Date, "%d/%m/%Y")
t <- paste(dat$Date, dat$Time)
tm <- strptime(t, "%Y-%m-%d %H:%M:%S")
dat$tm <- tm
dat$weekday <- weekdays(dat$tm, abbreviate = TRUE)

dat$Global_active_power <- as.numeric(dat$Global_active_power)
dat$Global_reactive_power <- as.numeric(dat$Global_reactive_power)
dat$Voltage <- as.numeric(dat$Voltage)
dat$Global_intensity <- as.numeric(dat$Global_intensity)
dat$Sub_metering_1 <- as.numeric(dat$Sub_metering_1)
dat$Sub_metering_2 <- as.numeric(dat$Sub_metering_2)
dat$Sub_metering_3 <- as.numeric(dat$Sub_metering_3)

# Plot 4

png(file="plot4.png")
par(mfcol=c(2,2), mar=c(4,4,2,2), oma=c(0,0,2,0))
with(dat,{
  plot(tm, Global_active_power, type="l", xlab="")
  
  plot(tm, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(dat$tm, dat$Sub_metering_2, col="red")
  lines(dat$tm, dat$Sub_metering_3, col="blue")
  legend("topright", bty="n", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(tm, Voltage, type="l", xlab="datetime")
  plot(tm, Global_reactive_power, type="l", xlab="datetime")
})
dev.off()
