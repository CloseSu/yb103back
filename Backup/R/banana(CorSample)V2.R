#��Ʈw�s�ɮ�
library(lubridate)
library(RODBC);
channel = odbcConnect("agriculture", uid="sa", pwd="passw0rd");

market_persimmon = sqlQuery(channel, "select * from market_persimmon");
persimmon_production_price = sqlQuery(channel, "select * from persimmon_production_price");
weather = sqlQuery(channel, "select * from weather");

close(channel);
#�ˬd�ݩ�
str(persimmon_production_price)
head(weather)
##############�S�O�ݭn�ݩʷŮt�s�W
tempdiff = weather[,3]-weather[,4]
colnames(weather)[22] = 'tempdiff'


#���N��������β��a����ɶ���ܩһݥͪ��϶�
year(market_persimmon$date) = year(market_persimmon$date)-1
year(persimmon_production_price$date) = year(persimmon_production_price$date)-1

#�X�֮�ԻP�����}����NULL��
MarketPriceCorpersimmon = na.omit(merge(weather,market_persimmon,by.x='date',all.x=TRUE))

#��ԻP������������Y��
TempPrice = cor(MarketPriceCorpersimmon$avg_price,MarketPriceCorpersimmon$air_temp)
dew_pointPrice = cor(MarketPriceCorpersimmon$avg_price,MarketPriceCorpersimmon$dew_point)
RHPrice = cor(MarketPriceCorpersimmon$avg_price,MarketPriceCorpersimmon$RH)
precp_daPrice = cor(MarketPriceCorpersimmon$avg_price,MarketPriceCorpersimmon$precp_da)
wind_speed_meanPrice = cor(MarketPriceCorpersimmon$avg_price,MarketPriceCorpersimmon$wind_speed_mean)
sunPrice = cor(MarketPriceCorpersimmon$avg_price,MarketPriceCorpersimmon$sun)
solar_radPrice = cor(MarketPriceCorpersimmon$avg_price,MarketPriceCorpersimmon$solar_rad)
evapPrice = cor(MarketPriceCorpersimmon$avg_price,MarketPriceCorpersimmon$evap)

tempdiffPrice = cor(MarketPriceCorpersimmon$avg_price,MarketPriceCorpersimmon$tempdiff)

#��ԻP����q�����Y��
air_temptrade= cor(MarketPriceCorpersimmon$trade,MarketPriceCorpersimmon$air_temp)
dew_pointtrade = cor(MarketPriceCorpersimmon$trade,MarketPriceCorpersimmon$dew_point)
RHPrice = cor(MarketPriceCorpersimmon$trade,MarketPriceCorpersimmon$RH)
precp_datrade = cor(MarketPriceCorpersimmon$trade,MarketPriceCorpersimmon$precp_da)
wind_speed_meantrade = cor(MarketPriceCorpersimmon$trade,MarketPriceCorpersimmon$wind_speed_mean)
suntrade = cor(MarketPriceCorpersimmon$trade,MarketPriceCorpersimmon$sun)
solar_radtrade = cor(MarketPriceCorpersimmon$trade,MarketPriceCorpersimmon$solar_rad)
evaptrade = cor(MarketPriceCorpersimmon$trade,MarketPriceCorpersimmon$evap)

tempdifftrade = cor(MarketPriceCorpersimmon$trade,MarketPriceCorpersimmon$tempdiff)

#�X�֮�ԻP������ƨé���NULL��
ProductionPriceCorpersimmon = na.omit(merge(weather,persimmon_production_price,by.x='date',all.x=TRUE))
str(ProductionPriceCorpersimmon)

#��ԻP���������Y��1
air_tempPRprice1= cor(ProductionPriceCorpersimmon$pricePeace,ProductionPriceCorpersimmon$air_temp)
dew_pointPRprice1 = cor(ProductionPriceCorpersimmon$pricePeace,ProductionPriceCorpersimmon$dew_point)
RHPRprice1 = cor(ProductionPriceCorpersimmon$pricePeace,ProductionPriceCorpersimmon$RH)
precp_daPRprice1 = cor(ProductionPriceCorpersimmon$pricePeace,ProductionPriceCorpersimmon$precp_da)
wind_speed_meanPRprice1 = cor(ProductionPriceCorpersimmon$pricePeace,ProductionPriceCorpersimmon$wind_speed_mean)
sunPRprice1 = cor(ProductionPriceCorpersimmon$pricePeace,ProductionPriceCorpersimmon$sun)
solar_radPRprice1 = cor(ProductionPriceCorpersimmon$pricePeace,ProductionPriceCorpersimmon$solar_rad)
evapPRprice1 = cor(ProductionPriceCorpersimmon$pricePeace,ProductionPriceCorpersimmon$evap)

tempdiffPRprice1 = cor(ProductionPriceCorpersimmon$pricePeace,ProductionPriceCorpersimmon$tempdiff)


#��ԻP���������Y��2,�p�G���ĤG�Ӳ��a�A�N�n��
#air_tempPRprice2= cor(ProductionPriceCorpersimmon$pricePeace,ProductionPriceCorpersimmon$air_temp)
#dew_pointPRprice2 = cor(ProductionPriceCorpersimmon$pricePeace,ProductionPriceCorpersimmon$dew_point)
#RHPRprice2 = cor(ProductionPriceCorpersimmon$pricePeace,ProductionPriceCorpersimmon$RH)
#precp_daPRprice2 = cor(ProductionPriceCorpersimmon$pricePeace,ProductionPriceCorpersimmon$precp_da)
#wind_speed_meanPRprice2 = cor(ProductionPriceCorpersimmon$pricePeace,ProductionPriceCorpersimmon$wind_speed_mean)
#sunPRprice2 = cor(ProductionPriceCorpersimmon$pricePeace,ProductionPriceCorpersimmon$sun)
#solar_radPRprice2 = cor(pricePeace$pricePeace,ProductionPriceCorpersimmon$solar_rad)
#evapPRprice2 = cor(ProductionPriceCorpersimmon$pricePeace,ProductionPriceCorpersimmon$evap)

#�p�G�S���ĤG�Ӳ��a�N�γo��
air_tempPRprice2= 0
dew_pointPRprice2 = 0
RHPRprice2 = 0
precp_daPRprice2 = 0
wind_speed_meanPRprice2 = 0
sunPRprice2 = 0
solar_radPRprice2 =0
evapPRprice2 = 0




#�Ҧ������Y�ƦX��
persimmonCorlation = cbind(TempPrice,dew_pointPrice,RHPrice,precp_daPrice,wind_speed_meanPrice,sunPrice,solar_radPrice,evapPrice,
                        air_temptrade,dew_pointtrade,RHPrice,precp_datrade,wind_speed_meantrade,suntrade,solar_radtrade,evaptrade,
                        air_tempPRprice1,dew_pointPRprice1,RHPRprice1,precp_daPRprice1,wind_speed_meanPRprice1,sunPRprice1,solar_radPRprice1,
                        evapPRprice1,air_tempPRprice2,dew_pointPRprice2,RHPRprice2,precp_daPRprice2,wind_speed_meanPRprice2,sunPRprice2,solar_radPRprice2,
                        evapPRprice2,tempdiffPrice,tempdifftrade,tempdiffPRprice1
                        )
  





