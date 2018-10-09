# Cargamos las librerías que vayamos a usar
library(dplyr)
library(ggplot2)
library(lares)

# Definimos la dirección en la que se encuentran nuestros archivos
setwd("/Users/bernardo/Dropbox (Personal)/Documentos/R/R Presentations")

# ~~~~~~~~~~~~~~~~~~~ dplyr ~~~~~~~~~~~~~~~~~~~ #

# Cargamos el CSV con el que trabajaremos
df <- read.csv("df_ejemplo.csv", sep=";")

# Select
df %>% select(viento, presion, fecha)

# Filter
df %>% filter(viento >= 50)

# Arrange
df %>% arrange(viento)

# Mutate
df %>% mutate(ratio = presion / viento)

# Group by
df %>% 
  group_by(tipo) %>% 
  mutate(mean = mean(viento), 
         sum = sum(viento), 
         n = n() )

# Summarise
df %>% 
  summarise(median = median(presion), 
            variance = var(presion))
df %>% 
  group_by(tipo) %>% 
  summarise(median = median(presion), 
            variance = var(presion))


# ~~~~~~~~~~~~~~~~~~~ ggplot2 ~~~~~~~~~~~~~~~~~~~ #

# Bar plot
ggplot(df, aes(x=tormenta, y=viento)) + geom_col() + facet_grid(tipo~.)

# Box plot
ggplot(df, aes(x=tipo, y=presion)) + geom_boxplot() + geom_point()

# Scatter plot
ggplot(df) + 
  geom_point(aes(x = viento, y = presion, colour = tipo), size = 3) +
  labs(title = "Presión vs Viento", 
       subtitle = "Ejercicio de prueba", 
       caption = paste("Fecha:",Sys.Date() ),
       x = "Viento",  y = "Presión")


# ~~~~~~~~~~~~~~~~~~~ lares ~~~~~~~~~~~~~~~~~~~ #

# Consultas al CRM
dump <- queryDummy("SELECT * FROM super_opps 
                   ORDER BY opp_id 
                   DESC LIMIT 50")
dim(dump)
colnames(dump)

# Frecuencias
freqs(dump, insurance_type)
freqs(dump, insurance_type, sex)

# Valores nulos
nas(dump)

# Deals de hubspot
deals <- super_deals(15)
head(deals)

# Leer de Google Sheets
p <- readGS(title = "Propuesta de valor",
            ws = "ChannelFit-LI")
