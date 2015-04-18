library("neuralnet") 

library(RODBC);
channel = odbcConnect("agriculture", uid="sa", pwd="passw0rd");
market_banana = sqlQuery(channel, "select * from market_banana");
banana_production_price = sqlQuery(channel, "select * from banana_production_price");
price_index = sqlQuery(channel, "select * from price_index");
production = sqlQuery(channel, "select * from production");
typhoon = sqlQuery(channel, "select * from typhoon");
weather = sqlQuery(channel, "select * from weather");
close(channel);

str(market_banana)
str(banana_production_price)
str(price_index)
str(production)
str(weather)


V = c(1,2,6,8,13,14,15) 
weatherBig = weather[,V]

head(weatherBig)

datacombine1 = merge(market_banana,banana_production_price,by="date",all.x=TRUE)
datacombine2 = merge(datacombine1,weatherBig,by="date",all.x=TRUE)
datacombine2[,1:5]=list(NULL)
head(datacombine2)
write.xlsx(datacombine2,file="datacombine2.xlsx")

datacombine3 = read.xlsx(header=TRUE,file='datacombine2.xlsx',sheetIndex=1)

datacombine2[,1] = (datacombine2[,1]-min(datacombine2[,1])) /(max(datacombine2[,1])-min(datacombine2[,1]))
datacombine2[,2] = (datacombine2[,2]-min(datacombine2[,2])) /(max(datacombine2[,2])-min(datacombine2[,2]))
datacombine2[,3] = (datacombine2[,3]-min(datacombine2[,3])) /(max(datacombine2[,3])-min(datacombine2[,3]))
datacombine2[,4] = (datacombine2[,4]-min(datacombine2[,4])) /(max(datacombine2[,4])-min(datacombine2[,4]))
datacombine2[,5] = (datacombine2[,5]-min(datacombine2[,5])) /(max(datacombine2[,5])-min(datacombine2[,5]))
datacombine2[,6] = (datacombine2[,6]-min(datacombine2[,6])) /(max(datacombine2[,6])-min(datacombine2[,6]))
datacombine2[,7] = (datacombine2[,7]-min(datacombine2[,7])) /(max(datacombine2[,7])-min(datacombine2[,7]))
datacombine2[,8] = (datacombine2[,8]-min(datacombine2[,8])) /(max(datacombine2[,8])-min(datacombine2[,8]))
datacombine2[,9] = (datacombine2[,9]-min(datacombine2[,9])) /(max(datacombine2[,9])-min(datacombine2[,9]))
head(datacombine2)



net.model = neuralnet(avg_price ~ trade + priceWufeng + air_temp +  RH + precp_da + sun + solar_rad + evap,
                      datacombine2, hidden=5, threshold=0.01) 
print(net.model) 
plot(net.model)



market_banana2014 = market_banana[market_banana$date>='2014-01-01' & market_banana$date<='2014-12-31',]
banana_production_price2014 = banana_production_price[banana_production_price$date>='2014-01-01' & banana_production_price$date<='2014-12-31',]
price_index2014 = price_index[price_index$date>='2014-01-01' & price_index$date<='2014-12-31' ,8]
production2014 = production[production$year==2014,]
weather2014 = weather[weather$date>='2014-01-01' & weather$date<='2014-12-31',]
V = c(1,2,6,8,13,14,15) 
weather2014V2 = weather2014[,V]

head(weather2014V2)

data2014combine1 = merge(market_banana2014,banana_production_price2014,by="date",all.x=TRUE)
data2014combine2 = merge(data2014combine1,weather2014V2,by="date",all.x=TRUE)
data2014combine2[,2:5]=list(NULL)
head(data2014combine2)

data2014combine2[,2] = (data2014combine2[,2]-min(data2014combine2[,2])) /(max(data2014combine2[,2])-min(data2014combine2[,2]))
data2014combine2[,3] = (data2014combine2[,3]-min(data2014combine2[,3])) /(max(data2014combine2[,3])-min(data2014combine2[,3]))
data2014combine2[,4] = (data2014combine2[,4]-min(data2014combine2[,4])) /(max(data2014combine2[,4])-min(data2014combine2[,4]))
data2014combine2[,5] = (data2014combine2[,5]-min(data2014combine2[,5])) /(max(data2014combine2[,5])-min(data2014combine2[,5]))
data2014combine2[,6] = (data2014combine2[,6]-min(data2014combine2[,6])) /(max(data2014combine2[,6])-min(data2014combine2[,6]))
data2014combine2[,7] = (data2014combine2[,7]-min(data2014combine2[,7])) /(max(data2014combine2[,7])-min(data2014combine2[,7]))
data2014combine2[,8] = (data2014combine2[,8]-min(data2014combine2[,8])) /(max(data2014combine2[,8])-min(data2014combine2[,8]))
data2014combine2[,9] = (data2014combine2[,9]-min(data2014combine2[,9])) /(max(data2014combine2[,9])-min(data2014combine2[,9]))

head(testingdata2)

testingdata = subset(data2014combine2, select = -avg_price ) 
testingdata2 = testingdata[,-1]
testingtarget = data2014combine2$avg_price 
results = compute(net.model, testingdata2) 
print(round(results$net.result))

?compute

table(testingtarget, round(results$net.result)) 
accuracy <- sum(testingtarget == round(results$net.result))/length(testingtarget) 
sprintf("%.2f%%", accuracy * 100)



