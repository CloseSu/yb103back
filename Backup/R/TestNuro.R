
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

market_banana2013 = market_banana[market_banana$date>='2013-01-01' & market_banana$date<='2013-12-31',]
banana_production_price2013 = banana_production_price[banana_production_price$date>='2013-01-01' & banana_production_price$date<='2013-12-31',]
price_index2013 = price_index[price_index$date>='2013-01-01' & price_index$date<='2013-12-31' ,8]
production2013 = production[production$year==2013,]
weather2013 = weather[weather$date>='2013-01-01' & weather$date<='2013-12-31',]

V = c(1,2,6,8,13,14,15)

weather2013V2 = weather2013[,V]
head(weather2013V2)

########################################

market_banana2014 = market_banana[market_banana$date>='2014-01-01' & market_banana$date<='2014-12-31',]
 
data2013combine1 = merge(market_banana2013,banana_production_price2013,by="date",all.x=TRUE)
data2013combine2 = merge(data2013combine1,weather2013V2,by="date",all.x=TRUE)
data2013combine2[,2:5]=list(NULL)
head(data2013combine2)
str(data2013combine2)



#分析資料

# training stage 

net.model = neuralnet(avg_price ~ trade + priceWufeng + air_temp + RH + precp_da + sun + solar_rad + evap,
                      data2013combine2, hidden=5, threshold=0.01) 
print(net.model) 
plot(net.model) 

# testing stage 
banana_production_price2014 = banana_production_price[banana_production_price$date>='2014-01-01' & banana_production_price$date<='2014-12-31',]
production2014 = production[production$year==2014,]
weather2014 = weather[weather$date>='2014-01-01' & weather$date<='2014-12-31',]
price_index2014 = price_index[price_index$date>='2014-01-01' & price_index$date<='2014-12-31' ,8]


weather2014V2 = weather2014[,V]
head(weather2014V2)

market_banana2014 = market_banana[market_banana$date>='2014-01-01' & market_banana$date<='2014-12-31',]

data2014combine1 = merge(market_banana2014,banana_production_price2014,by="date",all.x=TRUE)
data2014combine2 = merge(data2014combine1,weather2014V2,by="date",all.x=TRUE)
data2014combine2[,2:5]=list(NULL)
head(data2014combine2)
str(market_banana2014)



testingdata = subset(data2014combine2, select = -avg_price ) 
testingdata2 = testingdata[,-1]
testingtarget = data2014combine2$avg_price 
results = compute(net.model, testingdata2) 
print(round(results$net.result))

?compute

table(testingtarget, round(results$net.result)) 
accuracy <- sum(testingtarget == round(results$net.result))/length(testingtarget) 
sprintf("%.2f%%", accuracy * 100)


