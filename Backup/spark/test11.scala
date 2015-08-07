import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.sql.SQLContext
import com.databricks.spark.csv._

object test11 {
  def main(argment: Array[String]): Unit = {
    val sc = new SparkContext(new SparkConf().setAppName("test").setMaster("local[4]"))
    val sqlContext = new SQLContext(sc)

    val data = sqlContext.csvFile("hdfs://quickstart.cloudera:8020/fruit/weather.csv")
      //         data.printSchema()
       data.registerTempTable("weather")

    val aggDF = sqlContext.sql("select air_temp  from weather  ")

     aggDF.map(t => t(0)).collect().foreach(println)

    //val format = new java.text.SimpleDateFormat("dd-MM-yyyy")

  }
}