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

png("plot2.png", width=400, height=400)

plot(datos$Time, datos$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

dev.off()