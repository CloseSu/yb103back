library(RMongo)

#localhost
mongo <- mongoDbConnect("mydb", "127.0.0.1")
#connect,collection,query,skpi,limit
output <- dbGetQuery(mongo, 'zips', "{}",0,30000)
#check
head(output)

str(output)

