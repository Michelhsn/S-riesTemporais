### Autor: Michel Nascimento
### Email: michel_henrique_911@hotmail.com
### Data: 10/10/17

## Análise de Séries temporais em estação d emonitoramento IoT

install.packages("RMySQL")

library("RMySQL")

# Permissão Mysql remoto para o IP - mysqld.cnf
# Dar os privilégios REVOKE ALL PRIVILEGES ON *.* FROM 'usuario'@'ip'; GRANT ALL PRIVILEGES ON *.* TO 'usuario'@'ip' REQUIRE NONE WITH GRANT OPTION MAX_QUERIES_PER_HOUR 
# 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;
mydb = dbConnect(MySQL(), user='michel', password='password', dbname='database', host='192.168..')

# Lista as tabelas na base de dados e a desc
dbListTables(mydb)
dbListFields(mydb, 'ESTACAO_001')

# Executar Querry
estacao1 = dbSendQuery(mydb, "select * from ESTACAO_001")

# Do Mysql ao R
dados = fetch(estacao1, n=-1)

# Dados da tabela
dados<-dbReadTable(mydb, "ESTACAO_001")

# Criando dataframe de estudo
df.estacao1<-dbGetQuery(mydb, "SELECT * FROM ESTACAO_001 WHERE ID>(SELECT COUNT(*) FROM ESTACAO_001)-(144*5)")

temp.ts<-ts(df.estacao1$TEMPERATURA, frequency = 144)

# Plotando
plot(temp.ts, main = "Gráfico de Temperatura", xlab = "Dias", ylab = "Temperatura")

decompose(temp.ts)
plot(decompose(temp.ts))

temp.hw<-HoltWinters(temp.ts)
temp.pred<-predict(temp.hw, 144)
plot(temp.ts, col = "blue", xlim = c(1,7))
lines(temp.pred, col = "red")
