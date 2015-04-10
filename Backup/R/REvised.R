#�N�x�����a���Ū���
banana = read.xlsx(header=TRUE,file='Taichung_banana.xlsx',sheetIndex=1,encoding='UTF-8')
#�ˬd�һݤ��e�b����
head(banana[4:624,2])
#�T�{�ݩ�
str(banana)
#�N�һݤ��e��J�@���ܼ�
revise = banana[4:621,2]
#�ƻs�æX�֦��Q�ӭ��ƪ��ƭ�(���w�]���O30��),�o���ܼƱ��I�|�A�Ψ�,�ȭק��i�H�s�ɳƥ�
Revised2 = data.frame(revise,revise,revise,revise,revise,revise,revise,revise,revise,revise)
#�N�ƻs�᪺�ɮצs�X,�ƥ�
write.csv(Revised2,file='Revised2.xlsx')
#�ΦV�q���U��������m
lastweek = seq(3,618,3)
#���X�U��������m���@���ܼ�
lastmonth = Revised2[lastweek,]
#���N��31�Ѫ���Ƨ令999��K�ק�
Revised2[,11]=999
#�N���X�U��������ɮצs�X,��EXCEl�s�W������,�@�ӬO�~,�@�ӬO���,�@�������P�_�Ѽƥ�
# EX 1998 1 ...����...
write.csv(lastmonth,file='text23.xlsx')

#Ū���w�ק諸�ɮ�
RDateData = read.xlsx(header=TRUE,file='text23.xlsx',sheetIndex=1,encoding='UTF-8' )
#�˹��ݩ�
str(RDateData)

#�H�U�N�O�P�_�̫�@�ѤѼƪ��j��,��쬰1��206,�ΰj��],�ѲĤ@�����P�_�~��,�ĤG�����P�_���


for(i in 1:206){
x = RDateData[i,1]
y = RDateData[i,2]
#�|�~�P�_����,�p�G�O29��,��30�Ѭ�999,��K�ק�,28�ѦP�z
if(x%%400==0 | (x%%4==0 & x%%100 !=0)){
  if(y==2){
    RDateData[i,12]=999;
  }
}else{
  if(y==2){
    RDateData[i,11]=999;
    RDateData[i,12]=999;
  }
}
}
#�p�G�O31��,�h�᭱�A�s�W�@�ӭ�
for(i in 1:206){
  y = RDateData[i,2]  
  if(y==1|y==3|y==5|y==7|y==8|y==10|y==12){
    RDateData[i,13]=RDateData[i,12]; 
  }else{
    RDateData[i,13]=999
  }
}
#�N�Ѽƭק粒�����Ȧs���s�ܼ�
newRDateData = RDateData
#��~��h��
newRDateData[1:2]=list(NULL)
#�N�s�ק�n���U����ƴ�������Ӫ����(ROW),�p�G�X�{NULL���N���D�O���`��
Revised2[lastweek,] = newRDateData
#�g�X�ɮ׳ƥ�,�O�o���}�ݤ@�UNA��999�����O�_���T
write.csv(Revised2,file='texfinal.csv')
#�ƥ��@�ӫ�AŪ�i��,Ū�ɮ׫e��EXCEL�N999���N��NA
chainTest = read.csv(header=TRUE,file='texfinal.csv')
#�̼��ˬd�@�U�ݩ�
str(chainTest)
#�h���L�N�q�����(�Ʀr����)
chainTest[,1] = NULL
#�N�Ҧ��ƭȸm�����@�Ӥj����Ʀr,�é���NA��
chain = na.omit(as.vector(t(chainTest)))
#�g�X�ɮ�,�O�o�bEXCEL�W���D���M�����G�ιA�|
write.csv(chain,file='chain.csv')


