import MySQLdb,io

cnx = MySQLdb.connect("localhost","root","Yb$03zz5","Tokyo")
cursor = cnx.cursor()

sql = """CREATE TABLE loc_abstract (
         TITLE  NVARCHAR(100) NOT NULL,
         DATE   CHAR(20),
         SCORE  CHAR(10) )"""

cursor.execute(sql)


fin=open('g1066457-d479258_abstract_Reviews2.txt')
lines=fin.readlines()

for i in range(0,len(lines),2):
    datain = lines[i].split('\t\\')
    print type(datain[0])
    add_record="INSERT INTO loc_abstract \
                (TITLE, DATE, SCORE) \
                VALUES (%s, %s, %s)"
    cursor.execute(add_record,(datain[0],datain[1],datain[2].replace('\t\n','')))

cnx.commit()
cursor.close()
cnx.close()

