library(lubridate)
library(dplyr)
# set the locale for time to english so we can get x axis day names in english
Sys.setlocale("LC_TIME", 'English')

if(!file.exists("household_power_consumption.txt"))
{
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",dest="household_power_consumption.zip")
  unzip("household_power_consumption.zip")
}

# we read only the column headings first and then only the lines corresponding to the wanted dates 
pow_head<-read.table('household_power_consumption.txt', stringsAsFactors=F, sep=";", na.strings=c("?"),header=TRUE,nrows=1)
pow<-read.table('household_power_consumption.txt', stringsAsFactors=F, sep=";", na.strings=c("?"),skip=66637,nrows=2880,col.names=colnames(pow_head))
pow<-mutate(pow,Date2=dmy_hms(paste(Date,Time)))

png(filename="plot4.png",width=480, height=480)
par(mfrow = c(2,2))
plot(pow$Global_active_power ~ pow$Date2,type="l",ylab="Global Active Power",xlab="")
plot(pow$Voltage ~ pow$Date2,type="l",ylab="Voltage",xlab="datetime")
plot(pow$Sub_metering_1 ~ pow$Date2,type="l", ylab="Energy sub metering",xlab="")
points(pow$Sub_metering_2 ~ pow$Date2,type="l",col="red")
points(pow$Sub_metering_3 ~ pow$Date2,type="l",col="blue")
legend("topright", lty=c(1,1),col = c("black","blue", "red"), bty="n",legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
plot(pow$Global_reactive_power ~ pow$Date2,type="l",ylab="Global_reactive_power",xlab="datetime")
dev.off()
