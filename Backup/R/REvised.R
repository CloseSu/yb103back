
banana = read.xlsx(header=TRUE,file='Taichung_banana.xlsx',sheetIndex=1,encoding='UTF-8')

head(banana[4:624,2])

str(banana)

revise = banana[4:623,2]

write.csv(revise,file='ttt.csv')

Revised2 = data.frame(revise,revise,revise,revise,revise,revise,revise,revise,revise,revise)

write.csv(Revised2,file='text.csv')

head(Revised2)

lastweek = seq(3,623,3)

Revised2[624,]

lastmonth = Revised2[lastweek,]


write.csv(lastmonth,file='text2.csv')

average = lastweek/3

Revised2[1,11]




#合併
av = as.vector(t(Revised2))

write.csv(av,file='text.csv')


str(av)


RDateData = read.xlsx(header=TRUE,file='text23.xlsx',sheetIndex=1,encoding='UTF-8' )

revised = RDateData[,-1]

year = seq(1998,2015,1)

month = seq(1,12,1)









