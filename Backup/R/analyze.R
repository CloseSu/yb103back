
MoviDdata = read.table(file='u.data')

str(MoviDdata)
head(MoviDdata)


colnames(MoviDdata)[1] = 'userId'
colnames(MoviDdata)[2] = 'itemId'
colnames(MoviDdata)[3] = 'rating'
colnames(MoviDdata)[4] = 'time'

MoviDdata[,4] = as.Date(as.POSIXct(MoviDdata[,4],origin="1970-01-01"))

mainMovie = read.delim(file="u.item", header=F, sep ="|")

mainMovie[,3:5]=list(NULL)

head(mainMovie)
str(mainMovie)

colnames(mainMovie)[1] = 'movieId'
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


mode = which.max(table(MoviDdata$userId))
                 
TestId = MoviDdata[MoviDdata$userId==405,]
















