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
  }
  pcon= read.csv(file,header=T,sep=";",stringsAsFactors = T, na.strings="?", blank.lines.skip = T)
  pcon$Date <- as.Date(pcon$Date, format="%d/%m/%Y")
  pcon= pcon[(pcon$Date=="2007-02-01") | (pcon$Date=="2007-02-02"),]
  pcon$DT<-paste(pcon$Date,pcon$Time,sep=" ")
  pcon$DT<-as.POSIXct(strptime(pcon$DT, format="%Y-%m-%d %H: %M: %S"))
  
  plot(pcon$DT,pcon$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
  dev.copy(png,file="Plot2.png",width=480,height=480)
  dev.off()
  
}


