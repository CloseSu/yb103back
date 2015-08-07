import org.apache.spark._
import org.apache.spark.streaming._
import org.apache.spark.streaming.StreamingContext._


object test5 {

  def main(argment: Array[String]): Unit = {

    val sc = new SparkContext(new SparkConf().setAppName("NewTES2T").setMaster("local[4]"))
    val ssc = new StreamingContext(sc, Seconds(5))

    val lines = ssc.socketTextStream("localhost", 9999)
    //val lines = ssc.textFileStream("/home/cloudera/文件/article")
    val words = lines.flatMap(_.split(" "))

    val pairs = words.map(word => (word, 1))
    val wordCounts = pairs.reduceByKey(_ + _)

    wordCounts.print()

    ssc.start()
    ssc.awaitTermination()
  }
}
