setwd("C:/R/ExData_Plotting1/")

electricity <- read.table("household_power_consumption.txt",
                          header=F,sep=";",nrows=10000,skip=61000,
                          colClass=c(NA,NA,rep("character",7)))
names  <- names(read.table("household_power_consumption.txt",
                                               header=T,sep=";",nrow=1) )

elecdata <- cbind(strptime(paste(electricity[,1],electricity[,2]),
                           format="%d/%m/%Y %H:%M:%S",tz="GMT"),
                  electricity[,3:9])
names(elecdata) <- c("Time",names[3:9])
elecdata2 <- elecdata[as.Date(elecdata$Time) %in% as.Date(c("2007-02-01","2007-02-02")),]

##histogram
hist(as.numeric(elecdata2$Global_active_power) , breaks = 15 , col = "red",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency",
     main="Global Active Power")

##image 2
plot( elecdata2$Global_active_power ~ elecdata2$Time, type="l",
      xlab = "", ylab = "Global Active Power (kilowatts)",
      main="")
##image 3
