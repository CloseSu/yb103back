
banana = read.xlsx(header=TRUE,file='Taichung_banana.xlsx',sheetIndex=1,encoding='UTF-8')

head(banana[4:624,2])

revise = banana[4:624,2]


Revised2 = data.frame(revise,revise,revise,revise,revise,revise,revise,revise,revise,revise)

write.csv(Revised2,file='text.csv')

head(Revised2)

lastweek = seq(3,624,3)

lastmonth = Revised2[lastweek,]

average = lastweek/3

Revised2[1,11]


##===================
if (average%12 ==1 |average%12 ==3 |average%12 ==5 |average%12 ==7|average%12 ==8 |average%12 ==10 |average%12 ==12 ){
  Revised2[lastweek,11] = Revised2[lastweek,10]
}else if(average%12 ==2){
  Revised2[lastweek,9:10]=NULL
}

###=====================



#合併
av = as.vector(t(Revised2))

write.csv(av,file='text.csv')


str(av)





