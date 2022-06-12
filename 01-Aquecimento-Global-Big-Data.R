#Problema de Negocio - Analisar a temperatura media (aquecimento global) nas cidades brasileiras

install.packages("readr") #para realizar leitura de dados
install.packages("data.table")#para realizar leitura de dados
install.packages("dplyr") #para manipular os dados
install.packages("ggplot2") #para realizar graficos

library(ready) 
library(dplyr) 
library(ggplot2)  
library(scales) #para manipular os dados
library(data.table)

#Carregando os dados de 3 forma diferentes (desempenhos distintos)
#system.time() - retorna o tempo de execucao de uma funcao

#usando read.csv2()
system.time(df_read_csv <- read.csv2("TemperaturasGlobais.csv", sep=','))
View(head(df_read_csv))

#usando read.table()
system.time(df_read_table <- read.table('TemperaturasGlobais.csv', sep = ','))
View(head(df_read_table))

#usando fread()
system.time(df_fread <- fread('TemperaturasGlobais.csv'))
View(head(df_fread))