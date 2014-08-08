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


##image 2
png(filename="image2.png",width = 480, height = 480, units = "px")
plot( elecdata$Global_active_power ~ elecdata$Time, type="l",
      xlab = "", ylab = "Global Active Power (kilowatts)",
      main="")
dev.off()

rm("elecdata")
