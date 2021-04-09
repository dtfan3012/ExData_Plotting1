## Using the link posted on the assignment, the file was
## moved to a new folder inside Exploratory_Data_Analysis_Course_4
## This was set as the workng directory
setwd(getwd())

## The large file was read in using read.table.  Observing the file
## it had the semicolon separating the values so sep = ";" or the
## read in file will only have one variable
eng_comp <- read.table("household_power_consumption.txt", 
                       sep=";",
                       header = TRUE)

## Subsetting the data to only look at Feb 1-2, 2007.  Used the filter()
## function from the dplyr package to find on entries that match either
## Feb 1, 2007 or Feb 2, 2007

febdata <- filter(eng_comp, 
                  (Date == "1/2/2007") | (Date == "2/2/2007"))

febdata$Date <- dmy(febdata$Date)

png("plot3.png")

febdata <- febdata %>% 
  mutate(Date_Time = as.POSIXct(paste(febdata$Date, febdata$Time),
                                format="%Y-%m-%d %H:%M:%S"), 
                                .before = Date)

with(febdata, plot(Date_Time, Sub_metering_1, type="n", xlab = "",
                   ylab = "Energy sub metering"))
lines(febdata$Date_Time, febdata$Sub_metering_1)
lines(febdata$Date_Time, febdata$Sub_metering_2,  col ="red")
lines(febdata$Date_Time, febdata$Sub_metering_3,  col = "blue")
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),
       lty = c(1,1,1),
       cex = 0.8)

dev.off()