url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
archivo <- "./exdata-data-household_power_consumption.zip"
tabla <- "household_power_consumption.txt"

if(!file.exists(archivo)){
  download.file(url, destfile = archivo)}

if(!file.exists(archivo)){
  stop(paste(archivo), " must be in the environment")}

if(!file.exists(tabla)){
  unzip("./exdata-data-household_power_consumption.zip")
}

datos <- read.table(tabla, head = TRUE, sep =";", 
                    colClasses = c("character", "character", rep("numeric",7)), na = "?")

datos$Time <- strptime(paste(datos$Date, datos$Time), "%d/%m/%Y %H:%M:%S")
datos$Date <- as.Date(datos$Date, "%d/%m/%Y")

fechas <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
datos <- subset(datos, Date %in% fechas)

png("plot4.png", width=400, height=400)

par(mfrow=c(2,2))
# 1
plot(datos$Time, datos$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power")
# 2
plot(datos$Time, datos$Voltage, type="l",
     xlab="datetime", ylab="Voltage")
# 3
plot(datos$Time, datos$Sub_metering_1, type="l", col="black",
     xlab="", ylab="Energy sub metering")
lines(datos$Time, datos$Sub_metering_2, col="red")
lines(datos$Time, datos$Sub_metering_3, col="blue")
legend("topright", bty = "n", lty = c(1, 1), lwd = c(1, 1, 1), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), box.lwd = 0)
# 4
plot(datos$Time, datos$Global_reactive_power, type="n",
     xlab="datetime", ylab="Global_reactive_power")
lines(datos$Time, datos$Global_reactive_power)

dev.off()