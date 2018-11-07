Sys.getlocale("LC_TIME") ##get the time locale
Sys.setlocale("LC_TIME", "English_United States.1252") ##set the time locale

#Here I use functionality of dplyr package
library(dplyr)

setwd("./")
#assign a variable to the destination folder
destFolder <- "./HouseholdPowerConsumption2"

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

## Draw the plot as aline on the screen device without labels
plot(as.numeric(FilteredDF$Global_active_power),type = "l", axes=FALSE, ann=FALSE)

##apply a box around
box()

##assign x-axis lables (seperation 1400 times give bettr position)
axis(1, at=1400*(0:2), lab=c("Thu","Fri","Sat"))

## set y-axis ticks and unites
axis(2,at=2*(0:4))

## lable the y-axis
title(ylab= "Global Active Power (Kilowatts)")

## copy the plot into a png file
dev.copy(png, file = "Plot2.png",width = 480 , height = 480,units = "px", bg = "white", res = NA) ## Copy plot to a png file

## switch off the graph device
dev.off()  ## set off the device