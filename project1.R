## set working directory where you can find the file household_power_consumption.txt
setwd("C:/R/")
Sys.setlocale("LC_TIME", "English") 

## read and select eletricity data
electricity <- read.table("household_power_consumption.txt",
                          header=F,sep=";",nrows=10000,skip=61000,
                          colClass=c(NA,NA,rep("character",7)))
names <- names( read.table("household_power_consumption.txt",
                          header=T , sep=";" , nrow=1) )
elecdata <- cbind(strptime(paste( electricity[,1] , electricity[,2]),
                           format = "%d/%m/%Y %H:%M:%S" , tz = "GMT"),
                  electricity[,3:9])
names(elecdata) <- c("Time" , names[3:9])
elecdata <- elecdata[as.Date(elecdata$Time) %in% as.Date(c("2007-02-01","2007-02-02")),]
rm("electricity")

##image 1
png(filename="image1.png",width = 480, height = 480, units = "px")
hist(as.numeric(elecdata$Global_active_power) , breaks = 15 , col = "red",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency",
     main="Global Active Power")
dev.off()

##image 2
png(filename="image2.png",width = 480, height = 480, units = "px")
plot( elecdata$Global_active_power ~ elecdata$Time, type="l",
      xlab = "", ylab = "Global Active Power (kilowatts)",
      main="")
dev.off()

##image 3
png(filename="image3.png",width = 480, height = 480, units = "px")
par(mfrow = c(1, 1))
plotimage3 <- function(bxty="o"){
  plot( elecdata$Sub_metering_1 ~ elecdata$Time, type="l",
        xlab = "", ylab = "Energy sub metering",
        main="")
  lines(elecdata$Sub_metering_2 ~ elecdata$Time, col="red")
  lines(elecdata$Sub_metering_3 ~ elecdata$Time, col="blue")
  
  legend("topright",lty =1 , col = c("black","blue", "red" ), 
         legend = c("Sub_metering_1" ,"Sub_metering_2","Sub_metering_3"),
         bty=bxty)
}
plotimage3()
dev.off()
##image 4
png(filename="image4.png",width = 480, height = 480, units = "px")
par(mfrow = c(2 , 2))
with(elecdata, {
    plot(Time, Global_active_power,  
         xlab = "", ylab = "Global Active Power",main = "", type="l")
    plot(Time, Voltage,  
         xlab = "datetime", ylab = "Voltage",main = "", type="l")
    })
with(elecdata, {
    plotimage3("n")
    plot( Time,Global_reactive_power, 
         xlab = "datetime", ylab = "Global_reactive_power",main = "", type="l")
    })
dev.off()
