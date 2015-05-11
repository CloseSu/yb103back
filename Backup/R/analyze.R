
MoviDdata = read.table(file='u.data')

str(MoviDdata)
head(MoviDdata)


colnames(MoviDdata)[1] = 'userId'
colnames(MoviDdata)[2] = 'itemId'
colnames(MoviDdata)[3] = 'rating'
colnames(MoviDdata)[4] = 'time'

MoviDdata[,4] = as.Date(as.POSIXct(MoviDdata[,4],origin="1970-01-01"))
#處理TAB換行讀黨方式
mainMovie = read.delim(file="u.item", header=F, sep ="|")

mainMovie[,3:5]=list(NULL)

head(mainMovie)
str(mainMovie)

colnames(mainMovie)[1] = 'itemId'
colnames(mainMovie)[2] = 'movieTitle'
colnames(mainMovie)[3] = 'unknown'
colnames(mainMovie)[4] = 'Action'
colnames(mainMovie)[5] = 'Adventure'
colnames(mainMovie)[6] = 'Animation'
colnames(mainMovie)[7] = 'Children'
colnames(mainMovie)[8] = 'Comedy'
colnames(mainMovie)[9] = 'Crime'
colnames(mainMovie)[10] = 'Documentary'
colnames(mainMovie)[11] = 'Drama'
colnames(mainMovie)[12] = 'Fantasy'
colnames(mainMovie)[13] = 'Film-Noir'
colnames(mainMovie)[14] = 'Horror'
colnames(mainMovie)[15] = 'Musical'
colnames(mainMovie)[16] = 'Mystery'
colnames(mainMovie)[17] = 'Romance'
colnames(mainMovie)[18] = 'Sci-Fi'
colnames(mainMovie)[19] = 'Thriller'
colnames(mainMovie)[20] = 'War'
colnames(mainMovie)[21] = 'Western'


head(MoviDdata)

#取眾數
mode = which.max(table(MoviDdata$itemId))                 
TestId = MoviDdata[MoviDdata$itemId==50,]
TestId[order(TestId$time),]
mode2 = which.max(table(TestId$userId))
TestId2 = TestId[TestId$userId==1,]




user = read.table(file='u.user',sep="|",stringsAsFactors =FALSE)
str(user)
head(user)

mostusr = which.max(table(user$V4))

userStudent = user[user$V4=='student',]

head(userStudent)
head(MoviDdata)

colnames(userStudent)[1] = 'userId'
colnames(userStudent)[2] = 'age'
colnames(userStudent)[3] = 'gender'
colnames(userStudent)[4] = 'occupation'
colnames(userStudent)[5] = 'zipCode'

nrow(userStudent)


CombineStudent = merge(userStudent,MoviDdata,by.x='userId',all.x=TRUE)

head(mainMovie)

CombineStudentMovie = merge(CombineStudent,mainMovie,by.x='itemId',all.x=TRUE)


CombineStudentMovie2 = CombineStudentMovie
CombineStudentMovie2 = CombineStudentMovie2[order(CombineStudentMovie2$time),]
CombineStudentMovie2[,5:6] = list(NULL)


head(CombineStudentMovie2)


str(CombineStudentMovie2)

userMovie = which.max(table(CombineStudentMovie2$userId))


table(CombineStudentMovie2$time)


CombineStudentMovie3 = CombineStudentMovie2[CombineStudentMovie2$rating==5,]

CombineStudentMovie3[,1:5]=list(NULL)
CombineStudentMovie3[,2]=NULL

head(CombineStudentMovie3)
str(CombineStudentMovie3)


#用group by 方式將特定時間內所有值加總
test = aggregate(.~time, data=CombineStudentMovie3, FUN=sum)
str(test)
head(test)

for(i in 1:ncol(test)){
     x = max(test[,i])
     print(x)
}

plot(test$ Crime~test$time,
     xlab = "time",
     ylab = "Drama",    
     type ="l"
)
#增加其他參數確認相關性
points(x=test$time,y=test$unknown,col=3,type='l')
points(x=test$time,y=test$Action,col=28,type='l')
points(x=test$time,y=test$Adventure,col=53,type='l')
points(x=test$time,y=test$Animation,col=54,type='l')
points(x=test$time,y=test$Children,col=79,type='l')
points(x=test$time,y=test$Comedy,col=104,type='l')
points(x=test$time,y=test$Crime,col=151,type='l')
points(x=test$time,y=test$Documentary,col=458,type='l')
points(x=test$time,y=test$Fantasy,col=458,type='l')
points(x=test$time,y=test$Film-Noir,col=638,type='l')
points(x=test$time,y=test$Horror,col=654,type='l')
points(x=test$time,y=test$Musical,col=73,type='l')
points(x=test$time,y=test$Mystery,col=597,type='l')
points(x=test$time,y=test$Romance,col=450,type='l')
points(x=test$time,y=test$Sci-Fi,col=555,type='l')
points(x=test$time,y=test$Thriller,col=135,type='l')
points(x=test$time,y=test$War,col=376,type='l')
points(x=test$time,y=test$Western,col=258,type='l')











