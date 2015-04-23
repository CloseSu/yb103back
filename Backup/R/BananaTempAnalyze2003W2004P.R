# RJava bug 解決
install.packages('rJava', repos='http://www.rforge.net/')   
Sys.getenv("JAVA_HOME")
if (Sys.getenv("JAVA_HOME")!="")
  Sys.setenv(JAVA_HOME="")
#資料庫連檔案
library(lubridate)
library(RODBC);
channel = odbcConnect("agriculture", uid="sa", pwd="passw0rd");
market_banana = sqlQuery(channel, "select * from market_banana");
banana_production_price = sqlQuery(channel, "select * from banana_production_price");
weather = sqlQuery(channel, "select * from weather");
productionBanaDaily =  sqlQuery(channel, "select * from BananaProductionDaily");
close(channel);

#屬性檢查
str(weather)
table(weather$date)
head(weather)

#取得2003年氣候資料,以向量去取所要分析的欄位
weather2003 = weather[weather$date>='2003-01-01' & weather$date<='2003-12-31',]
w = c(1,2,3,4)
weather2003V2 = weather2003[,w]
#取得2004年香蕉市場資料
market_banana2004 = market_banana[market_banana$date>='2004-01-01' & market_banana$date<='2004-12-31',]
m = c(1,3,4,5,6)
market_banana2004V2 = market_banana2004[,m]
#將2004年香蕉市場資料年分減1以利合併
year(market_banana2004V2$date) = year(market_banana2004V2$date)-1
#取得2004年香蕉產地價格
banana_production_price2004 = banana_production_price[banana_production_price$date>='2004-01-01' & banana_production_price<='2004-12-31',]
#將2004年香蕉產地價格料年分減1以利合併
year(banana_production_price2004$date) = year(banana_production_price2004$date)-1
#取得2004年香蕉產量資料
productionBanaDaily2004 = productionBanaDaily[productionBanaDaily$date>='2004-01-01' & productionBanaDaily$date<='2004-12-31',]
year(productionBanaDaily2004$date) = year(productionBanaDaily2004$date)-1
#檢查署性
str(weather2003V2)
head(weather2003)

#合併所有欄位,並去除NULL欄位(na,omit)
bananajoin1 = merge(weather2003V2,banana_production_price2004,by.x='date',all.x=TRUE)
bananajoin2 = merge(bananajoin1,market_banana2004V2,by.x='date',all.x=TRUE)
bananajoin3 = merge(bananajoin2,productionBanaDaily2004,by.x='date',all.x=TRUE)
bananajoin4 = na.omit(bananajoin3)


str(bananajoin4)
head(bananajoin4)
#新增欄位放溫差
bananajoin4[,11] =  bananajoin4[,3]-bananajoin4[,4]
names(bananajoin4)[11] = 'tempDiff'
#正規化數值,須先將日期欄位去掉
nor = function(e){
  x = (e-min(e))/(max(e)-min(e))
  x
}
dataRawNormalize = bananajoin4
dataRawNormalize = dataRawNormalize[,-1]

for(i in 1:ncol(dataRawNormalize)){
  dataRawNormalize[,i] = nor(dataRawNormalize[,i])
}
#重新將日期欄加回去成新的data.frame
dateT = bananajoin4[,1]
dataRawNormalizeBanana = data.frame(dateT,dataRawNormalize)

str(dataRawNormalizeBanana)
head(dataRawNormalizeBanana)
#畫圖確認
plot(dataRawNormalizeBanana$air_temp~dataRawNormalizeBanana$date,
     xlab = "datee",
     ylab = "air_temp",    
     type ="l"
)
#增加其他參數確認相關性
points(x=dataRawNormalizeBanana$date,y=dataRawNormalizeBanana$priceWufeng,col='blue',type='l')
points(x=dataRawNormalizeBanana$date,y=dataRawNormalizeBanana$avg_price,col='red',type='l')
points(x=dataRawNormalizeBanana$date,y=dataRawNormalizeBanana$BananaProductionDaily,col='green',type='l')
points(x=dataRawNormalizeBanana$date,y=dataRawNormalizeBanana$tempDiff,col='yellow',type='l')





