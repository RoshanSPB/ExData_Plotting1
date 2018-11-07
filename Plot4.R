Sys.getlocale("LC_TIME") ##get the time locale
Sys.setlocale("LC_TIME", "English_United States.1252") ##set the time locale

#Here I use functionality of dplyr package
library(dplyr)

setwd("./")
#assign a variable to the destination folder
destFolder <- "./HouseholdPowerConsumption4"

#check weather directory exists, then create in not
if(!file.exists(destFolder)){dir.create(destFolder)}

#set the working directory
setwd(destFolder)

#assign a variable to the url file
fileUrl<-"https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"

#assign a varaiable to zip file
zipfile<-"./HouseholdPowerConsumption.zip"

#downlaod the url file
download.file(fileUrl,destfile=zipfile)

#unzip the downloaded zip file
unzip(zipfile)

#read the tsv file into a DataSet varaiable
DataSet<-read.csv("./household_power_consumption.txt",header = TRUE,sep = ";",stringsAsFactors = FALSE)  

## set DataSet as a Data Frame
DF<-as.data.frame(DataSet)

## set Data field as factor variaable
DF$Date<-as.factor(DF$Date)

## set the Date field as %d/%m/%Y format
strTime<-strptime(DF$Date,format="%d/%m/%Y")

## set the Date field as "%Y-%m-%d format
DF$Date <- as.Date(strTime,format="%Y-%m-%d") 

## filter out data only in the range '2007-02-01' & '2007-02-02'
FilteredDF<-filter(DF,DF$Date >= '2007-02-01' & DF$Date <='2007-02-02')

## set 2x2 space
par(mfrow = c(2, 2), mar = c(5, 4, 2, 1))

##Plot1
plot(as.numeric(FilteredDF$Global_active_power),type = "l", axes=FALSE, ann=FALSE)
##apply a box around
box()
##assign x-axis lables (seperation 1400 times give bettr position)
axis(1, at=1400*(0:2), lab=c("Thu","Fri","Sat"))
## set y-axis ticks and unites
axis(2,at=2*(0:4))
## lable the y-axis
title(ylab= "Global Active Power")

##Plot2
## Draw the plot as aline on the screen device without labels
plot(as.numeric(FilteredDF$Voltage),type = "l", axes=FALSE, ann=FALSE)
##apply a box around
box()
##assign x-axis lables (seperation 1400 times give bettr position)
axis(1, at=1400*(0:2), lab=c("Thu","Fri","Sat"))
## set y-axis ticks and unites
axis(2,tick= TRUE, at=2*(0:max(FilteredDF$Voltage)))
## label x-axis
title(xlab= "datetime")
## lable the y-axis
title(ylab= "Voltage")

##Plot3
## Draw the plot as aline on the screen device without labels
plot(as.numeric(FilteredDF$Sub_metering_1),type = "l", axes=FALSE, ann=FALSE)
lines(as.numeric(FilteredDF$Sub_metering_2),type = "l", col = "red")
lines(as.numeric(FilteredDF$Sub_metering_3),type = "l", col = "blue")
##apply a box around
box()
##assign x-axis lables (seperation 1400 times give bettr position)
axis(1, at=1400*(0:2), lab=c("Thu","Fri","Sat"))
## set y-axis ticks and unites
axis(2,at=10*(0:100))
## lable the y-axis
title(ylab= "Energy Sub Metering")
##apply legends
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex=0.8, col=c("black","red","blue"), lwd=2, bty="n");

##Plot4
plot(FilteredDF$Global_reactive_power,type = "l", axes=FALSE, ann=FALSE)
##apply a box around
box()
##assign x-axis lables (seperation 1400 times give bettr position)
axis(1, at=1400*(0:2), lab=c("Thu","Fri","Sat"))
## set y-axis ticks and unites
axis(2)
## label x-axis
title(xlab= "datetime")
## lable the y-axis
title(ylab= "Global_reactive_power")
## copy the plot into a png file
dev.copy(png, file = "Plot4.png",width = 480 , height = 480,units = "px", bg = "white", res = NA) ## Copy plot to a png file

## switch off the graph device
dev.off()  ## set off the device