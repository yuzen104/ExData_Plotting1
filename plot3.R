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


# Plot 3

png(file="plot3.png")
with(dat, plot(tm, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
lines(dat$tm, dat$Sub_metering_2, col="red")
lines(dat$tm, dat$Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
