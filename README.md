## Introduction

This assignment uses data from
the <a href="http://archive.ics.uci.edu/ml/">UC Irvine Machine
Learning Repository</a>, a popular repository for machine learning
datasets. In particular, we will be using the "Individual household
electric power consumption Data Set" which I have made available on
the course web site:


* <b>Dataset</b>: <a href="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip">Electric power consumption</a> [20Mb]

* <b>Description</b>: Measurements of electric power consumption in
one household with a one-minute sampling rate over a period of almost
4 years. Different electrical quantities and some sub-metering values
are available.


The following descriptions of the 9 variables in the dataset are taken
from
the <a href="https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption">UCI
web site</a>:

<ol>
<li><b>Date</b>: Date in format dd/mm/yyyy </li>
<li><b>Time</b>: time in format hh:mm:ss </li>
<li><b>Global_active_power</b>: household global minute-averaged active power (in kilowatt) </li>
<li><b>Global_reactive_power</b>: household global minute-averaged reactive power (in kilowatt) </li>
<li><b>Voltage</b>: minute-averaged voltage (in volt) </li>
<li><b>Global_intensity</b>: household global minute-averaged current intensity (in ampere) </li>
<li><b>Sub_metering_1</b>: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered). </li>
<li><b>Sub_metering_2</b>: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light. </li>
<li><b>Sub_metering_3</b>: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.</li>
</ol>

## Loading the data





When loading the dataset into R, please consider the following:

* The dataset has 2,075,259 rows and 9 columns. First
calculate a rough estimate of how much memory the dataset will require
in memory before reading into R. Make sure your computer has enough
memory (most modern computers should be fine).

* We will only be using data from the dates 2007-02-01 and
2007-02-02. One alternative is to read the data from just those dates
rather than reading in the entire dataset and subsetting to those
dates.

* You may find it useful to convert the Date and Time variables to
Date/Time classes in R using the `strptime()` and `as.Date()`
functions.

* Note that in this dataset missing values are coded as `?`.


## Making Plots

Our overall goal here is simply to examine how household energy usage
varies over a 2-day period in February, 2007. Your task is to
reconstruct the following plots below, all of which were constructed
using the base plotting system.

First you will need to fork and clone the following GitHub repository:
[https://github.com/rdpeng/ExData_Plotting1](https://github.com/rdpeng/ExData_Plotting1)


For each plot you should

* Construct the plot and save it to a PNG file with a width of 480
pixels and a height of 480 pixels.

* Name each of the plot files as `plot1.png`, `plot2.png`, etc.

* Create a separate R code file (`plot1.R`, `plot2.R`, etc.) that
constructs the corresponding plot, i.e. code in `plot1.R` constructs
the `plot1.png` plot. Your code file **should include code for reading
the data** so that the plot can be fully reproduced. You should also
include the code that creates the PNG file.

* Add the PNG file and R code file to your git repository

When you are finished with the assignment, push your git repository to
GitHub so that the GitHub version of your repository is up to
date. There should be four PNG files and four R code files.


The four plots that you will need to construct are shown below. 


repositorio <- read.csv("./data/household_power_consumption.txt", header=TRUE, sep = ";")

#cambiar formato de fecha y Tiempo
repositorio$Date <- as.Date(repositorio$Date, "%d/%m/%Y")
repositorio$Time <- strptime(repositorio$Time, "%h/%m/%s")   

#seleccionar fechas para graficas (febrero 1 y 2 de 2007)
rep <- subset(repositorio, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

#Crear Variable DateTime almacena fecha y tiempo fusionados
rep  <- mutate(rep, DateTime = paste(rep$Date, rep$Time))

#convertir variabless de tipo char a numeric
rep$Global_active_power <-  as.numeric(rep$Global_active_power) 
rep$Sub_metering_1 <- as.numeric(rep$Sub_metering_1)
rep$Sub_metering_2 <- as.numeric(rep$Sub_metering_2)
#Dar Formato  a columna DateTime 
rep$DateTime <- as.POSIXct(rep$DateTime)


###Plot 1
#Crear Plot 1
hist(rep$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", col="red")

##Guardar  archivo, copiarlo y cerrar servicios
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()
![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 


###Plot 2
#Crear plot 2
plot(rep$Global_active_power~rep$DateTime, type = "l", ylab="Global Active Power (kilowatts)",
     xlab="DateTime")
     
#Guardar  archivo, copiarlo y cerrar servicios
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()
![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 


###Plot 3
#Crear Plot 3
with(rep, plot(rep$Sub_metering_1~ rep$DateTime,type = "l",
               ylab =  "Energy Sub Metering",xlab="DateTime"))
     lines(rep$Sub_metering_2~ rep$DateTime, col = "red")
     lines(rep$Sub_metering_3~ rep$DateTime, col = "blue")
legend("topright",  col = c("black", "red" , "blue"),lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 
       
#Guardar  archivo, copiarlo y cerrar servicios
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 


###Plot 4
#Crear plot 4
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(rep, {
  plot(Global_active_power~DateTime , type = "l", 
       ylab="Global Active Power", xlab="DateTime")
  plot(Voltage ~ DateTime, type = "l",
       ylab="Voltaje", xlab="DateTime")
  plot(rep$Sub_metering_1~ rep$DateTime,type = "l",
           ylab =  "Energy Sub Metering",xlab="DateTime")
  lines(rep$Sub_metering_2~ rep$DateTime, col = "red")
  lines(rep$Sub_metering_3~ rep$DateTime, col = "blue")
  legend("topright",  col = c("black", "red" , "blue"),lwd=c(1,1,1), 
  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 
  plot(Global_reactive_power ~DateTime, type = "l", 
       ylab = "Global Reactive Power", xlab = "DateTime")
})

#Guardar  archivo, copiarlo y cerrar servicios
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 

