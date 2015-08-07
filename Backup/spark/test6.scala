import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.sql.SQLContext


case class Person(name: String, age: Int)

object test6 {
  def main(argment: Array[String]): Unit = {
    val sc = new SparkContext(new SparkConf().setAppName("test").setMaster("local[4]"))
    val sqlContext = new SQLContext(sc)
    //val df = sqlContext.jsonFile("hdfs://quickstart.cloudera:8020/data/people.json")
    import sqlContext.implicits._
    val people = sc.textFile("hdfs://quickstart.cloudera:8020/data/people.txt").map(_.split(",")).map(p => Person(p(0), p(1).trim.toInt)).toDF()
    people.registerTempTable("people")
    val teenagers = sqlContext.sql("SELECT name FROM people WHERE age >= 13 AND age <= 19")
    teenagers.map(t => "Name: " + t(0)).collect().foreach(println)
 
    //df.show()
    //df.printSchema()
    //df.select("name").show()
    //df.select("name", "age").show()
    sc.stop()

  }
}
