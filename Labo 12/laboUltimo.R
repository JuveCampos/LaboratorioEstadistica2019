# Librerias
library(tidyverse)

# Base de datos de información de presión del corazón. 
datos <- read_csv("https://raw.githubusercontent.com/JuveCampos/laboMetodosCuantitativosIntermedios/master/Sesi%C3%B3n%202.%20Regresion%20Lineal/datos/blodPressure.csv")

# Variable de interés: sistolicBloodPressure

#########
# Media #
#########

# A patita
datos %>% 
  summarise(media = sum(sistolicBloodPressure)/n())

# Con la función de R
datos %>% 
  summarise(media = mean(sistolicBloodPressure))

###########
# Mediana #
###########

# A patita

    # 1. Generamos un vector con los datos ordenados
    ordenados <- datos %>% 
      pull(sistolicBloodPressure) %>% 
      sort()
    
    # Tamaño del vector: 
    length(ordenados) # 11, es non... por lo que tomamos el numero de en medio. 
    posicion <- length(ordenados)/2 + 0.5
    mediana <- ordenados[posicion]
    
    # Imprimimos
    mediana
    
    # Con la función 
    datos %>% 
        summarise(mediana = median(sistolicBloodPressure))


########
# Moda #
########

# A patita (numero mas frecuente): 
datos %>% 
  group_by(sistolicBloodPressure) %>% 
  count() %>% 
  filter(n == max(n))

# Los datos tienen 10 modas! 

    
#######################
# Desviacion estandar #
#######################
        
# A patita
sd <- datos %>%
    summarise(sd = sqrt((sum((sistolicBloodPressure - mean(sistolicBloodPressure))^2))/(length(sistolicBloodPressure)-1))) %>% 
    pull()

sd

# A patita, paso a paso: 

    # 1. Obtenemos el no. de observaciones
    nObservaciones <- datos %>% 
      summarise(n()) %>% 
      pull()
    
    # Hacemos los calculos
    datos %>% 
      mutate(desv = sistolicBloodPressure - mean(sistolicBloodPressure)) %>% 
      mutate(desv2 = desv^2) %>% 
      summarise(sumDesv2 = sum(desv2)) %>% 
      summarise(sd = sqrt(sumDesv2/(nObservaciones - 1)))

# Con la funcion    
sd(datos$sistolicBloodPressure)    


################################
# COVARIANZA ENTRE 2 VARIABLES #
################################

# Covarianza entre la presion sanguinea y el peso en libras
cov(datos$sistolicBloodPressure, datos$weightInPounds) # Relacion positiva

# Covarianza entre la presion sanguinea y la edad
cov(datos$sistolicBloodPressure, datos$ageInYears) # Relacion positiva

# Correlacion entre la presion sanguinea y el peso en libras
cor(datos$sistolicBloodPressure, datos$weightInPounds) # Relacion positiva e intensa

# Correlacion entre la presion sanguinea y la edad
cor(datos$sistolicBloodPressure, datos$ageInYears) # Relacion positiva e intensa

# Ploteamos los datos
datos %>% 
  ggplot(aes(x = sistolicBloodPressure,
             y = weightInPounds)) + 
  geom_point() + 
  geom_smooth(method = "lm")
# Podemos ver la relacion positiva y directa entre ambas variables.

############
# GRAFICAS #
############

# Grafica
box <- datos %>% 
  ggplot(aes(x = 1, 
             y = sistolicBloodPressure)) + 
  geom_boxplot() + 
  coord_flip()

plotly::ggplotly(box)

# Obtenemos los puntos a mano: 

# Cuartiles: Q1, Q2, Q3 
# NOTA: Uso type = 5 porque es el método que utiliza ggplot para 
#   calcular automáticamente los cuantiles. 
q1 <- quantile(datos$sistolicBloodPressure, 0.25, type = 5) 
q2 <- quantile(datos$sistolicBloodPressure, 0.5, type = 5)  # Mediana
q3 <- quantile(datos$sistolicBloodPressure, 0.75, type = 5)

# Rango intercuantil 
ri <- q3 - q1
names(ri) <- NULL # quitamos el nombre confuso de "75%"

# Bigote izquierdo
#####################
    
    # Valor minimo
    datos %>% 
      summarise(minimo = min(sistolicBloodPressure))
    
    # Q1 - 1.5 el rango intercuantil 
    q1 - 1.5 * ri # (vALOR MÁXIMO HASTA EL CUAL SE PUEDE EXTENDER EL BIGOTE)
    
    bigoteIzquierdo <- datos %>% 
      summarise(minimo = min(sistolicBloodPressure)) %>% 
      pull()
    
    bigoteIzquierdo
    
    # COMO VEMOS, EL VALOR MINIMO ESTA MAS CERCA QUE EL 1.5 R.I. 
    #   Por lo tanto, el bracito/bigote llega hasta acá. 

    
# Bigote derecho
#################
    
    # Q1 - 1.5 el rango intercuantil 
    q3 + 1.5 * ri # (vALOR MÁXIMO HASTA EL CUAL SE PUEDE EXTENDER EL BIGOTE)
    
    
    # Calculo del bigote derecho
    bigoteDerecho <- datos %>% 
      summarise(maximo = max(sistolicBloodPressure)) %>% 
      pull()
    
    bigoteDerecho
   
    # COMO VEMOS, EL VALOR MÁXIMO ESTA MAS CERCA QUE EL 1.5 R.I. 
    #   Por lo tanto, el bracito/bigote llega hasta acá (VALOR MÁXIMO). 

    