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

#now we create the graphic using the function plot(). We plot Global_active_power vs DateTime.
#we want a line instead of points, so we set type='l'
png("plot2.png", width=480, height=480, units='px')
plot(subdata$DateTime,subdata$Global_active_power, ylab='Global Active Power (kilowatts)', xlab='', type='l')
dev.off()