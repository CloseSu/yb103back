files = list.files(path=".", pattern="*.txt")  #���o���U�ؿ�(path=".")�Ҧ�XLSX�ɮ�
bindtemp = data.frame()   #�ܼ�������data.frame
temp = data.frame()


#�ΰj��Ū���h���ɮ�
for (file in files) {      
  bindtemp = na.omit(read.delim(file=file,sep=":",encoding="UTF-8"))
  colnames(bindtemp)[1] ='ch'
  colnames(bindtemp)[2] ='count'
  bindtemp[,1] = as.character(bindtemp[,1])
  bindtemp[,2] = as.numeric(bindtemp[,2])  
  date = substr(file,0,10)
  bindtemp[,3] = as.Date(date)  
  colnames(bindtemp)[3] ='date'
  
  temp = rbind(temp,bindtemp)
 
}

write.csv(temp,file='final.csv')

bigtable = data.frame()

test = na.omit(read.delim(file='1998-09-01.txt_dictWithAllKeys.txt',sep=":",encoding="UTF-8"))
str(test)
colnames(test)[1] ='ch'
colnames(test)[2] ='count'
test[,1] = as.character(test[,1])
test[,2] = as.numeric(test[,2])  
########################


c = c(2,3)
char='����'
temp[temp$ch=='��i',]  = temp[temp$ch=='���O',] 




char='���O'
test4 = temp[temp$ch==char & temp$count>0,] 

test4[,3] = sort(test4$date)

plot(test4$count~test4$date,
   xlab = "date",
   ylab = "air_temp",    
   type ="l",
   main = '���O'
)
				

