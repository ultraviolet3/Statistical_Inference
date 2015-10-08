ec <- function() {
  if(!file.exists("exdata-data-household_power_consumption.zip")) {
    temp <- tempfile()
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
    file <- unzip(temp)
    unlink(temp)
  }
  else {
    wd=getwd()
    fil="household_power_consumption.txt"
    file=paste(wd,fil,sep="/")
    pcon= read.csv(file,header=T,sep=";",stringsAsFactors = T, na.strings="?", blank.lines.skip = T)
    pcon$Date <- as.Date(pcon$Date, format="%d/%m/%Y")
    pcon= pcon[(pcon$Date=="2007-02-01") | (pcon$Date=="2007-02-02"),]
    pcon$DT<-paste(pcon$Date,pcon$Time,sep=" ")
    pcon$DT<-as.POSIXct(strptime(pcon$DT, format="%Y-%m-%d %H: %M: %S"))
    uvplot1()
    uvplot2()
    uvplot3()
    uvplot4()
  }
}

uvplot1 <- function(){
  hist(pcon$Global_active_power, main="Global Active Power", col="red",xlab="Global Active Power (kilowatts)",ylab="Frequency")
  dev.copy(png,file="uvplot1.png",width=480,height=480)
  dev.off()
}
uvplot2 <- function(){
  plot(pcon$DT,pcon$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
  dev.copy(png,file="uvplot2.png",width=480,height=480)
  dev.off()
}
  
uvplot3 <- function(){
  plot(pcon$DT,pcon$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
  lines(pcon$DT,pcon$Sub_metering_2,col="red")
  lines(pcon$DT,pcon$Sub_metering_3,col="blue")
  legend("topright",col=c("black","red","blue"),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1),lwd=c(1,1))
  dev.copy(png,file="uvplot3.png",width=480,height=480)
  dev.off()
}

uvplot4<- function(){
  par(mfrow=c(2,2))
  plot(pcon$DT,pcon$Global_active_power,type="l",xlab="",ylab="Global Active Power")
  plot(pcon$DT,pcon$Voltage,type="l",xlab="datetime",ylab="Voltage")
  plot(pcon$DT,pcon$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
  lines(pcon$DT,pcon$Sub_metering_2,col="red")
  lines(pcon$DT,pcon$Sub_metering_3,col="blue")
  legend("topright",col=c("black","red","blue"),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1),lwd=c(1,1))
  plot(pcon$DT,pcon$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
  dev.copy(png,file="uvplot4.png",width=480,height=480)
  dev.off()
}