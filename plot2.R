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

png(filename="plot2.png",width=480, height=480)
plot(pow$Global_active_power ~ pow$Date2,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off()