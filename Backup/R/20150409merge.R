
?merge

banana_place2 = read.xlsx(header=TRUE,file='banana2.xlsx',sheetIndex=1,encoding="UTF-8")
str(banana_place2)

banana_place2 = read.xlsx(header=TRUE,file='Taichung_bananaREVISED2.xlsx',sheetIndex=1,encoding="UTF-8")
str(banana_place2)


mergee = merge(banana_place,banana_market,by="日期",all.x=TRUE)
write.xlsx(mergee,file='mergee.xlsx')

mergee = read.xlsx(header=TRUE,file='mergee.xlsx',sheetIndex=1,encoding="UTF-8")

longan = read.xlsx(header=TRUE,file='longan.xlsx',sheetIndex=1,encoding="UTF-8")
loquat = read.xlsx(header=TRUE,file='loquat.xlsx',sheetIndex=1,encoding="UTF-8")
passionFruit = read.xlsx(header=TRUE,file='passionFruit.xlsx',sheetIndex=1,encoding="UTF-8")
persimmon = read.xlsx(header=TRUE,file='persimmon.xlsx',sheetIndex=1,encoding="UTF-8")
ponkan = read.xlsx(header=TRUE,file='ponkan.xlsx',sheetIndex=1,encoding="UTF-8")

mergee2 = merge(mergee,banana_market,by="日期",all.x=TRUE)


write.xlsx(mergee,file='mergee.xlsx')
