temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

#we define a vector containing the names of the columns
columns_names<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

data <- read.table(unz(temp, "household_power_consumption.txt"),sep=';', header=TRUE,na.strings='?',col.names=columns_names)
unlink(temp)

#we write the dates in the standard way in order to make subsetting easier
data$Date<-as.Date(data$Date,format='%d/%m/%Y')

#now we subset selecting the days 2007-02-01 and 2007-02-02
subdata<-subset(data, Date=="2007-02-01" | Date=='2007-02-02')

#we add a column that writes together date and time and we write them as numbers
subdata$DateTime<-strptime(paste(subdata$Date,subdata$Time), format='%Y-%m-%d %H:%M:%S')

#to avoid weekdays in Spanish
Sys.setlocale("LC_TIME","en_US.UTF-8")

#now we create the four graphics using the function plot() inside the function with()
png("plot4.png", width=480, height=480, units='px')
par(mfrow=c(2,2)) #we want to arrange the graphics in 2 rows an 2 columns
with(subdata, {plot(DateTime, Global_active_power, ylab='Global Active Power', xlab='', type='l') 
     plot(DateTime,Voltage, ylab='Voltage', xlab='datetime', type='l')
     plot(DateTime,Sub_metering_1, type='l', xlab='', ylab='Energy sub metering') 
     points(DateTime,Sub_metering_2, type='l', xlab='', ylab='', col='red') 
     points(DateTime,Sub_metering_3, type='l', xlab='', ylab='', col='blue')
     legend("topright",col=c('black','red','blue'), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1)) 
     plot(DateTime,Global_reactive_power, ylab='Global_reactive_power', xlab='datetime', type='l')})
dev.off()