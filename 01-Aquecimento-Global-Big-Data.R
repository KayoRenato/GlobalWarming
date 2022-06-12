#Problema de Negocio - Analisar a temperatura media (aquecimento global) nas cidades brasileiras

install.packages("readr") #para realizar leitura de dados
install.packages("data.table")#para realizar leitura de dados
install.packages("dplyr") #para manipular os dados
install.packages("ggplot2") #para realizar graficos

library(readr) 
library(dplyr) 
library(ggplot2)  
library(scales) #para manipular os dados
library(data.table)

#Carregando os dados de 3 forma diferentes (desempenhos distintos)
#system.time() - retorna o tempo de execucao de uma funcao

#usando read.csv2() 12.5s
system.time(df_read_csv <- read.csv2("TemperaturasGlobais.csv", sep=','))
View(head(df_read_csv))

#usando read.table() 8.3s
system.time(df_read_table <- read.table('TemperaturasGlobais.csv', sep = ','))
View(head(df_read_table))

#usando fread() 1.5s
system.time(df_fread <- fread('TemperaturasGlobais.csv'))
View(head(df_fread))

dim(df_fread) #8.6Mi registros


#criando subset dos dados do Brasil
temp_brasil <- subset(df_fread, df_fread$Country == 'Brazil')
temp_brasil <- na.omit(temp_brasil)
temp_brasil$dt <- as.POSIXct(temp_brasil$dt, format='%Y-%m-%d')
temp_brasil$month <- month(temp_brasil$dt)
temp_brasil$year <- year(temp_brasil$dt)
View(head(temp_brasil))
dim(temp_brasil)

#criando subset dos dados da Irlanda - Cork
temp_irland_cork <-subset(df_fread, df_fread$City == 'Cork')
temp_irland_cork <- na.omit(temp_irland_cork)
temp_irland_cork$dt <- as.POSIXct(temp_irland_cork$dt, format='%Y-%m-%d')
temp_irland_cork$month <- month(temp_irland_cork$dt)
temp_irland_cork$year <- year(temp_irland_cork$dt)
View(temp_irland_cork)
dim(temp_irland_cork)

#criando subset dos dados da Alemanha - Berlim
temp_alemanha_berl <-subset(df_fread, df_fread$City == 'Berlin')
temp_alemanha_berl <- na.omit(temp_alemanha_berl)
temp_alemanha_berl$dt <- as.POSIXct(temp_alemanha_berl$dt, format='%Y-%m-%d')
temp_alemanha_berl$month <- month(temp_alemanha_berl$dt)
temp_alemanha_berl$year <- year(temp_alemanha_berl$dt)
View(temp_alemanha_berl)
dim(temp_alemanha_berl)


#Carrendo subset cidades
#Cidadde - Palmas (BR)
plm <- subset(temp_brasil, temp_brasil$City == 'Palmas')
plm <- subset(plm, plm$year %in% c(1796, 1846, 1896, 1946, 2012))

#Cidadde - Recife (BR)
rec <- subset(temp_brasil, temp_brasil$City == 'Recife')
rec <- subset(rec, rec$year %in% c(1796, 1846, 1896, 1946, 2012))

#Cidadde - Curitiba (BR)
crt <- subset(temp_brasil, temp_brasil$City == 'Curitiba')
crt <- subset(crt, crt$year %in% c(1796, 1846, 1896, 1946, 2012))

#Cidadde - Cork (IE)
cork <- subset(temp_irland_cork, temp_irland_cork$year %in% c(1796, 1846, 1896, 1946, 2012))

#Cidadde - Berlin (DE)
berl <- subset(temp_alemanha_berl, temp_alemanha_berl$year %in% c(1796, 1846, 1896, 1946, 2012))


#Contruindo Plots
p_plm <- ggplot(plm, aes(x = (month), y = AverageTemperature, color = as.factor(year))) +
  geom_smooth(se = FALSE, fill = NA, size = 1.5) +
  theme_light(base_size = 20) + 
  xlab('Mês') +
  ylab('Temperatura Média') +
  scale_color_discrete('') + 
  ggtitle('Temperatura Média ao longo dos anos em Palmas(BR)') +
  theme(plot.title = element_text(size = 18))

p_rec <- ggplot(rec, aes(x = (month), y = AverageTemperature, color = as.factor(year))) +
  geom_smooth(se = FALSE, fill = NA, size = 1.5) +
  theme_light(base_size = 20) + 
  xlab('Mês') +
  ylab('Temperatura Média') +
  scale_color_discrete('') + 
  ggtitle('Temperatura Média ao longo dos anos em Recife(BR)') +
  theme(plot.title = element_text(size = 18))

p_crt <- ggplot(crt, aes(x = (month), y = AverageTemperature, color = as.factor(year))) +
  geom_smooth(se = FALSE, fill = NA, size = 1.5) +
  theme_light(base_size = 20) + 
  xlab('Mês') +
  ylab('Temperatura Média') +
  scale_color_discrete('') + 
  ggtitle('Temperatura Média ao longo dos anos em Curitiba(BR)') +
  theme(plot.title = element_text(size = 18))

p_cork <- ggplot(cork, aes(x = (month), y = AverageTemperature, color = as.factor(year))) +
  geom_smooth(se = FALSE, fill = NA, size = 1.5) +
  theme_light(base_size = 20) + 
  xlab('Mês') +
  ylab('Temperatura Média') +
  scale_color_discrete('') + 
  ggtitle('Temperatura Média ao longo dos anos em Cork(IE)') +
  theme(plot.title = element_text(size = 18))

p_berl <- ggplot(berl, aes(x = (month), y = AverageTemperature, color = as.factor(year))) +
  geom_smooth(se = FALSE, fill = NA, size = 1.5) +
  theme_light(base_size = 20) + 
  xlab('Mês') +
  ylab('Temperatura Média') +
  scale_color_discrete('') + 
  ggtitle('Temperatura Média ao longo dos anos em Berlin(DE)') +
  theme(plot.title = element_text(size = 18))


#plotando os graficos
p_plm
p_rec
p_crt
p_cork
p_berl

#analisando os dados, nao e possivel afirmar que ocorreu um aquecimento global. 
# hiposes: 1. A um aumento de temperatura em cidades proximas da linha do equador, o que nao ocorre em cidades proximas dos polos?

