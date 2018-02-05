### Autor: Michel Nascimento
### Email: michel_henrique_911@hotmail.com
### Data: 08/10/17

## Análise de séries temporais para sistema local
## de monitoramento ambiental com IoT

# Importando os dados
df.estacao1<-read.csv(file.choose(), header = FALSE);
names(df.estacao1)<-c("id", "timestamp", "temperatura", "umidade", "luminosidade");

# Análise de série temporal da temperatura em um dia
temperatura.ts<-ts(df.estacao1$temperatura, frequency = 143)

# Decompondo
temperatura.dec<-decompose(temperatura.ts)
plot(temperatura.dec)

# Ajuste
temperatura.ajust<-temperatura.ts - temperatura.dec$seasonal
plot(temperatura.ajust)

# Forecast curto prazo
temp.forecast<-HoltWinters(temperatura.ts)

# Extraploaçãro
plot.ts(temperatura.ts)
temp.predict<-predict(temp.forecast, 144)
lines(temp.predict, col = "blue")

# Temperatura máxima e mínima prevista
min<-min(temp.predict)
max<-max(temp.predict)
print(max)
print(min)



