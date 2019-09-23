library(lubridate)
library(dplyr)
library(tidyverse)
library(formattable)
library(stringr)
library(reshape2)



postes = data.frame(read_csv('c1.csv'))
postes$Fecha <- dmy(postes$Fecha)

postes$X23 <- NULL
postes$X24 <- NULL
postes$X25 <- NULL
postes$X26 <- NULL
postes$X27 <- NULL
postes$X28 <- NULL

postes$X5.30[postes$X5.30 == "x"] <- 1
postes$X30.45[postes$X30.45 == "x"] <- 1
postes$X45.75[postes$X45.75 == "x"] <-1
postes$X75.120[postes$X75.120 == "x"] <- 1
postes$X120.[postes$X120.=="x"] <- 1

molten_postes <- melt(postes, id.vars = c('Fecha', 'ID', 'Cod', 'origen', 'Lat', 'Long', 'height', 'X5.30','X30.45', 'X45.75', 'X75.120', 'X120.', 'factura', 'directoCamion_5', 'directoPickup', 'directoMoto', 'fijoCamion_5', 'fijoPickup', 'fijoMoto'), value.name = 'costo_total', variable.name = 'tipo_transporte', na.rm = TRUE)
molten_postes <- filter(molten_postes, costo_total != 'Q-')
molten_2 <- melt(molten_postes, id.vars = c('Fecha', 'Cod', 'ID', 'origen', 'Lat', 'Long', 'height',  'X5.30','X30.45', 'X45.75', 'X75.120', 'X120.', 'fijoCamion_5', 'fijoPickup', 'fijoMoto',  'factura', 'tipo_transporte', 'costo_total'), measure.vars = c('directoCamion_5', 'directoMoto', 'directoPickup'), value.name = 'Q_directo', variable.name = 'Costo_Directo', na.rm = TRUE)
molten_3 <- melt(molten_2, id.vars = c('Fecha', 'Cod', 'ID', 'origen', 'Lat', 'Long', 'height', 'X5.30','X30.45', 'X45.75', 'X75.120', 'X120.', 'factura', 'tipo_transporte', 'costo_total', 'Costo_Directo', 'Q_directo'), measure.vars = c('fijoCamion_5', 'fijoMoto', 'fijoPickup'), value.name = 'Q_fijo', variable.name = 'Costo_fijo')
molten_final <- melt(molten_3, id.vars = c('Fecha', 'Cod', 'ID', 'origen', 'Lat', 'Long', 'height', 'factura', 'tipo_transporte', 'costo_total', 'Costo_Directo', 'Q_directo', 'Costo_fijo', 'Q_fijo'), measure.vars = c('X5.30','X30.45', 'X45.75', 'X75.120', 'X120.'), value.name = 'distancias', variable.name = 'var_distancias', na.rm = TRUE)
molten_final$distancias <- NULL

molten_final$factura <- gsub("Q", "", molten_final$factura)
molten_final$factura <- as.numeric(molten_final$factura)

molten_final$costo_total <- gsub("Q", "", molten_final$costo_total)
molten_final$costo_total <- as.numeric(molten_final$costo_total)

molten_final$Q_directo <- gsub("Q", "", molten_final$Q_directo)
molten_final$Q_directo <- as.numeric(molten_final$Q_directo)

molten_final$Q_fijo <- gsub("Q", "", molten_final$Q_fijo)
molten_final$Q_fijo <- as.numeric(molten_final$Q_fijo)

molten_real <- na.omit(molten_final)
molten_real$Costo_Directo <- NULL
molten_real$Costo_fijo <- NULL

entrada <- sum(molten_real$factura)
costos <- sum(molten_real$costo_total)
ganancias <- entrada - costos
ganancias

total_unidad <- aggregate(x = molten_real$factura, by=list(molten_real$tipo_transporte), sum)
total_unidad
colnames(total_unidad)<-c('Unidad', 'Ingresos')
costo_unidad <- aggregate(x = molten_real$costo_total, by=list(molten_real$tipo_transporte), sum)
colnames(costo_unidad)<-c('Unidad', 'Ingresos')

tarifa_unidad <- aggregate(x = molten_real$costo_total, by=list(molten_real$tipo_transporte), mean) #tarifa por unidad
colnames(tarifa_unidad)<-c('Unidad', 'Tarifa')

str(molten_real)
molten_real$origen <- as.factor(molten_real$origen)
centros_distribucion <- count(molten_real$origen)
colnames(centros_distribucion)<-c('Centro', 'Operaciones')
centros_distribucion
unique <- distinct(molten_real, Cod)
colnames(unique) <- c('Motivos')

strat <- count(molten_real$tipo_transporte)
strat <- cbind(strat, tarifa_unidad$Tarifa)
colnames(strat) <- c('Tipo_Unidad', 'Viajes', 'Costo_Viaje')

Pareto <- count(molten_real$Cod)
Pareto2 <- aggregate(x = molten_real$factura, by=list(molten_real$Cod), sum)
Final_pareto <- cbind(Pareto, Pareto2$x)
colnames(Final_pareto) <- c('Motivo', 'Frecuencia', 'Factura_Motivo')
Final_pareto <- Final_pareto[order(-Final_pareto$Factura_Motivo), ]

cuenta_postes <- count(molten_real$ID)
cuenta_postes <- cuenta_postes[order(-cuenta_postes$freq),]
head_postes <- head(cuenta_postes)

write.csv(molten_real, 'tidy_light.csv')
