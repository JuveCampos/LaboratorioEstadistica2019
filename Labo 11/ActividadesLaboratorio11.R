# Analisis exploratorio! 

# Librerias
# Descarga los datos. 
library(curl)
library(tidyverse)
library(readxl)
curl_download(url = "http://upom.chapingo.mx/Descargas/base_datos/acumuladas/BD_Alumnos_2005-2018.xlsx", 
              destfile = "anuarioChapingo.xlsx")

bd <- read_xlsx("anuarioChapingo.xlsx") %>% 
  clean_names()

# Explique 3 Funciones para explorar la base de datos. 

# En Chapingo hay dos modalidades de nuevo ingreso: Ingreso a Preparatoria (grado 1)
# e ingreso a Propedeutico (grado 8). Trabajaremos con los que ingresan a preparatoria. 

# Vamos a quedarnos con la informacion de los alumnos del 2018, de nuevo ingreso (grado 1). 

# Obtenga el numero de observaciones (alumnos). 

# Obtenga el numero de alumnos de nuevo ingreso, por sexo 

# Obtenga el numero de ninos de nuevo ingreso, por estado de nacimiento

# Obtenga la media de la edad de los ninos de nuevo ingreso

# Explique para que sirve el operador "$" y como se utiliza en R Base. 

# Obtenga la mediana de la edad 

# Obtenga la moda de la edad

# Obtenga la desviacion estandar de la edad

# Obtenda el boxplot de la edad

# Obtenga la grafica de densidad de la edad
