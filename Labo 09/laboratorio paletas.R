
install.packages("curl")

"http://upom.chapingo.mx/Descargas/base_datos/acumuladas/BD_Alumnos_2005-2018.xlsx"

# Librerias
library(readxl)
bd <- read_xlsx("http://upom.chapingo.mx/Descargas/base_datos/acumuladas/BD_Alumnos_2005-2018.xlsx")

# Descarga
library(curl)
library(janitor)
library(tidyverse)
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

######################################################
# Funcion pull()                                     #
#   Sirve para jalar un vector de una base de datos  #
#   y poder hacer manipulaciones con ellos.          #
######################################################

# Para obtener el año mínimo
bd %>% 
  pull(ano) %>% 
  min()

# Para obtener el año máximo
bd %>% 
  pull(ano) %>% 
  min()

# Para obtener el año mediano
bd %>% 
  pull(ano) %>% 
  median()

# Para obtener la lista de años
bd %>% 
  pull(ano) %>% 
  factor() %>% 
  levels()

# Entonces...
# El primer anio de registro es 2005, el ultimo es 2018

# Creamos y guardamos la base de datos. 
bd_plot <- bd %>% 
  filter(ano == 2018) %>% 
  group_by(estado_de_nacimiento) %>% 
  summarise(num_alumnos2 = sum(num_alumnos)) %>% 
  ungroup() 

# Grafica de alumnos, por estado
bd_plot %>% 
  ggplot(aes(x = fct_reorder(estado_de_nacimiento, num_alumnos2),
           y = num_alumnos2, 
           fill = num_alumnos2
           )) +
  geom_col(show.legend = FALSE) + 
  coord_flip() + 
  scale_fill_distiller(palette = "Greens", direction = 1)
  
# Ver lista de colores. 
RColorBrewer::display.brewer.all()

###################################################################
# EXTRA!                                                          #
# Utilizando el position="dodge" para sacar los estados por sexo. #
###################################################################

# 1.4 Agrupamos por estado y por sexo
uach_edos_sex <- bd %>%
  group_by(estado_de_nacimiento, genero) %>%
  summarise(total_edo = sum(num_alumnos)) %>%
  arrange(-total_edo)

# Grafica
uach_edos_sex %>%
  ggplot() +
  geom_bar(stat = "identity" ,position="dodge",
           aes(x = reorder(estado_de_nacimiento, total_edo),
               y = total_edo,
               fill = genero
           ),
           color = "black",
  ) +
  coord_flip() +
  scale_fill_manual(values = c("pink", "blue"))


