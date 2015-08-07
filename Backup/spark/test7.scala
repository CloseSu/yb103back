import org.apache.spark.sql.{Row, SQLContext}
import org.apache.spark.sql.types.{StringType, StructType, StructField}
import org.apache.spark.{SparkConf, SparkContext}


object test7 {
  def main(argment: Array[String]): Unit = {
    val sc = new SparkContext(new SparkConf().setAppName("test").setMaster("local[4]"))
    val sqlContext = new SQLContext(sc)

    val people = sc.textFile("hdfs://quickstart.cloudera:8020/data/people.txt")
    val schemaString = "name age"

    val schema = StructType( schemaString.split(" ").map(fieldName => StructField(fieldName, StringType, true)))

    val rowRDD = people.map(_.split(",")).map(p => Row(p(0), p(1).trim))
    val peopleDataFrame = sqlContext.createDataFrame(rowRDD, schema)
    peopleDataFrame.registerTempTable("people")
    val results = sqlContext.sql("SELECT name FROM people")
    results.map(t => "Name: " + t(0)).collect().foreach(println)


  }
}