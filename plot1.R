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

#now we make the histogram
#col is for the color, which must be 'red'
#width and height are for the size of the plot
#main is for the title 'Global Active Power'
#xlab is for the label of the x-axis 'Global Active Power (kilowatts)'
png("plot1.png", width=480, height=480, units='px')
hist(subdata$Global_active_power, col='red',main='Global Active Power', xlab='Global Active Power (kilowatts)')
dev.off()

