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

## The histogram plot requires the input to be numeric type and the 
## data was read in as default character so this code replaces the 
## global active power variable to numeric values
febdata$Global_active_power <- 
  as.numeric(as.character(febdata$Global_active_power))

png("plot1.png")

with(febdata, hist(Global_active_power, 
                   col = "red", 
                   xlab = "Global Active Power (kilowatts)", 
                   main = "Global Active Power"), 
                   ylim = c(0,1200))

dev.off()