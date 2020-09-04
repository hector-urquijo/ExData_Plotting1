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



#PLOT 3
# Crear Plot 3
with(rep, plot(rep$Sub_metering_1~ rep$DateTime,type = "l",
               ylab =  "Energy Sub Metering",xlab="DateTime"))
lines(rep$Sub_metering_2~ rep$DateTime, col = "red")
lines(rep$Sub_metering_3~ rep$DateTime, col = "blue")
legend("topright",  col = c("black", "red" , "blue"),lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 

#Guardar  archivo, copiarlo y cerrar servicios
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

