# Librerias    
library(stringr)
library(rebus)
library(tidyverse)

# Texto
texto <- c("cat", 
       "coat", 
       "scotland", 
       "tic toc", 
       "19YOM-SHOULDER STRAIN-WAS TACKLED WHILE PLAYING FOOTBALL W/ FRIENDS ", 
       "  Nayarit ",
       " Sinaloa",
       "Call me at 555-555-0191",                 
       "123 Main St"            ,                 
       "(555) 555 0191"         ,                 
       "Phone: 555.555.0191 Mobile: 555.555.0192", 
       "Mi saldo: $2,300 MXN",
       "Jeffrey",
       "Geoffrey",
       "Cathy", 
       "Kathy",
       "Algernon. Very natural, I am sure. That will do, Lane, thank you.",
       "Lane. Thank you, sir. [Lane goes out.]", 
       'The Trend  @thetrend___ 19m 19 minutes ago More ""Solía pensar que mi vida era una tragedia, pero ahora me doy cuenta que es una comedia"',
       "Gabriela Warkentin Verified account  @warkentin 1h 1 hour ago More A mi me gustó @jokermovie.  Mucho.  Mucho mucho.  Reply 43 Retweet 35 Like 499"
       )

# Ejercicio 1. 
# Obtenga mi saldo

pat_pesos <- "\\$" %R% DGT %R% "," %R% DGT %R% DGT %R% DGT %R% "." %R% "MXN"
str_view_all(string = texto, pattern = pat_pesos)
saldo_juve <- str_extract_all(string = texto, pattern = pat_pesos) %>% 
  unlist()

# Ejercicio 2. 
# Obtenga los users de los tweets

# 1. Patron user
pat_user <- "@" %R% capture(one_or_more(WRD))

# 2. Checamos el patron del usuario
str_view_all(string = texto, pattern = pat_user)

# 3. Extraemos todos los usuarios mencionados.
users <- str_extract_all(string = texto, pattern = pat_user) %>% 
  unlist()

# Limpiar strings con espacios en blanco. 
# Ejercicio 3. Genere el patron que detecte los espacios en blanco, y limpie los nombres de los estados. 

# 1. Generamos el patron 
pat_spc <- or1(c(START %R% capture(one_or_more(SPC)), capture(one_or_more(SPC) %R% END)))

# 2. Probamos el patr'on 
str_view_all(string = texto, pattern = pat_spc)

# 3. Limpiamos el patron 
texto <- str_remove_all(string = texto, pattern = pat_spc)

# 4. Imprimimos el texto
texto

# 5. DIFICIL! 
# Obtenga todos los numeros de telefono!!!

pat_phone <- optional("\\(") %R% capture(one_or_more(DGT)) %R% optional("\\)") %R% optional(SPC) %R% optional("-.") %R% capture(one_or_more(DGT)) %R% optional(SPC) %R% optional("-.") %R% capture(one_or_more(DGT))  #%R% optional(char_class = ".-")
pat_phone
str_view_all(string = texto, pattern = pat_phone)
