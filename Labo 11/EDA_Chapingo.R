# Analisis exploratorio! 

# Librerias
# Descarga
library(curl)
library(tidyverse)
library(readxl)
library(janitor)

curl_download(url = "http://upom.chapingo.mx/Descargas/base_datos/acumuladas/BD_Alumnos_2005-2018.xlsx", 
              destfile = "anuarioChapingo.xlsx")

bd <- read_xlsx("anuarioChapingo.xlsx") %>% 
  clean_names()

# Funciones para explorar bd
# View(bd)
nrow(bd)
head(bd)
glimpse(bd)
print(bd)
str(bd)

# Vamos a quedarnos con la informacion de los alumnos del 2018, de nuevo ingreso 
nuevos <- bd %>% 
  filter(ano == 2018 & grado == 1) 

# Obtenga el numero de observaciones
nrow(nuevos) # 1273 ninhos entraron a primero de preparatoria. 

# Obtenga el numero de nuevo ingreso, por sexo 
table(nuevos$genero)
prop.table(table(nuevos$genero))

# Obtenga el numero de ninos de nuevo ingreso, por estado de nacimiento
table(nuevos$estado_de_nacimiento)
prop.table(table(nuevos$estado_de_nacimiento))

# Obtenga la media de la edad
nuevos %>% 
  summarise(media = mean(edad))

# o tambien 
mean(nuevos$edad)

# Obtenga la mediana de la edad 
nuevos %>% 
  summarise(mediana = median(edad))

# Obtenga la moda de la edad
nuevos %>% 
  group_by(edad) %>% 
  summarise(frecuencia = n()) %>% 
  ungroup() %>% 
  filter(frecuencia == max(frecuencia))
# La moda es 15 años

# Obtenga la desviacion estandar de la edad
sd <- nuevos %>% 
  summarise(desv.est = sd(edad)) 

# Obtenda el boxplot de la edad
(m <- nuevos %>% 
  ggplot(aes(x = 1, y = edad)) +
  #geom_jitter(height = 1) +   
  geom_boxplot(width = 0.22,
               fill = "transparent",
               color = "tomato",
               size = 1) +
  coord_flip() + 
  scale_y_continuous(breaks = seq(10, 100, 1))  )
plotly::ggplotly(m)

# Obtenga la grafica de densidad de la edad
d <- nuevos %>% 
  ggplot(aes(x = edad)) +
  geom_density()
