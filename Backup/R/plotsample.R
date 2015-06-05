# RJava bug �ѨM
install.packages('rJava', repos='http://www.rforge.net/')   
Sys.getenv("JAVA_HOME")
if (Sys.getenv("JAVA_HOME")!="")
  Sys.setenv(JAVA_HOME="")
#��Ʈw�s�ɮ�
library(lubridate)
library(RODBC);
channel = odbcConnect("agriculture", uid="sa", pwd="passw0rd");
market_ponkan = sqlQuery(channel, "select * from market_ponkan");
ponkan_production_price = sqlQuery(channel, "select * from ponkan_production_price");
weather = sqlQuery(channel, "select * from weather");
ponkanProductionDaily =  sqlQuery(channel, "select * from ponkanProductionDaily");
close(channel);

#�ݩ��ˬd
str(market_ponkan)
table(ponkanProductionDaily$date)
head(ponkan_production_price)

#���o2013�~��Ը��,�H�V�q�h���ҭn���R�����
weather2013 = weather[weather$date>='2013-01-01' & weather$date<='2013-12-31',]
w = c(1,2,3,4)
weather2013V2 = weather2013[,w]
#���o2014�~�����������
market_ponkan2014 = market_ponkan[market_ponkan$date>='2014-01-01' & market_ponkan$date<='2014-12-31',]
m = c(1,3,4,5,6)
market_ponkan2014V2 = market_ponkan2014[,m]
#�N2014�~����������Ʀ~����1�H�Q�X��
year(market_ponkan2014V2$date) = year(market_ponkan2014V2$date)-1
#���o2014�~�������a����
ponkan_production_price2014 = ponkan_production_price[ponkan_production_price$date>='2014-01-01' & ponkan_production_price<='2014-12-31',]
#�N2014�~�������a����Ʀ~����1�H�Q�X��
year(ponkan_production_price2014$date) = year(ponkan_production_price2014$date)-1
#���o2014�~�������q���
ponkanProductionDaily2014 = ponkanProductionDaily[ponkanProductionDaily$date>='2014-01-01' & ponkanProductionDaily$date<='2014-12-31',]
year(ponkanProductionDaily2014$date) = year(ponkanProductionDaily2014$date)-1
#�ˬd�p��
str(weather2013V2)
head(weather2013V2)
#�B�z-1���
ponkan_production_price2014$pricePeace[ponkan_production_price2014$pricePeace==-1]= 0

#�X�֩Ҧ����,�åh��NULL���(na,omit)
ponkanjoin1 = merge(weather2013V2,ponkan_production_price2014,by.x='date',all.x=TRUE)
ponkanjoin2 = merge(ponkanjoin1,market_ponkan2014V2,by.x='date',all.x=TRUE)
#ponkanjoin3 = merge(ponkanjoin2,ponkanProductionDaily2014,by.x='date',all.x=TRUE)
ponkanjoin4 = na.omit(ponkanjoin2)


str(ponkanjoin4)
head(ponkanjoin4)

head(ponkanjoin4$priceWaipu)
#write.xlsx(ponkanjoin4,file='ponkanjoin4.xlsx')

#���W�Ƽƭ�,�����N������h��
nor = function(e){
  x = (e-min(e))/(max(e)-min(e))
  x
}

dataRawNormalize = ponkanjoin4
dataRawNormalize = dataRawNormalize[,-1]

for(i in 1:ncol(dataRawNormalize)){
  dataRawNormalize[,i] = nor(dataRawNormalize[,i])
}
#���s�N�����[�^�h���s��data.frame
dateT = ponkanjoin4[,1]
dataRawNormalizeponkan = data.frame(dateT,dataRawNormalize)

str(dataRawNormalizeponkan)
head(dataRawNormalizeponkan)

#�e�ϽT�{

boxplot(ponkanjoin4$avg_price~ponkanjoin4$air_temp ,ylab='avg_price',xlab='air_temp')


abline(v=105,lwd=3,col='red')


#plot(dataRawNormalizeponkan$air_temp~dataRawNormalizeponkan$date,
#   xlab = "date",
#     ylab = "air_temp",    
#     type ="l"
#)
#�W�[��L�ѼƽT�{������
#points(x=dataRawNormalizeponkan$date,y=dataRawNormalizeponkan$pricePeace,col='blue',type='l')
#points(x=dataRawNormalizeponkan$date,y=dataRawNormalizeponkan$avg_price,col='red',type='l')
#points(x=dataRawNormalizeponkan$date,y=dataRawNormalizeponkan$LonganProductionDaily,col='green',type='l')

