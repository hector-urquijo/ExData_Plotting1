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

# Dar Formato  a columna DateTime 
rep$DateTime <- as.POSIXct(rep$DateTime)


#PLOT 2
#Crear plot 2
plot(rep$Global_active_power~rep$DateTime, type = "l", ylab="Global Active Power (kilowatts)",
     xlab="DateTime")

# Guardar  archivo, copiarlo y cerrar servicios
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()

