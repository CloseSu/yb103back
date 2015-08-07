
import org.apache.spark.{SparkConf, SparkContext}


object test12 {
  def main(argment: Array[String]): Unit = {
    val sc = new SparkContext(new SparkConf().setAppName("test").setMaster("local[4]"))

    val data =  sc.textFile("hdfs://quickstart.cloudera:8020/data/SogouQ.reduced")

      .map(_.split("\t"))
      .filter(_(0)<"12:00:00")
      .filter(_(0)>"11:00:00")
      .map(x => (x(4),1))
      .reduceByKey(_+_)
      .map(x => (x._2,x._1))
      .sortByKey(false)
      .map(x => (x._2,x._1))
      .take(10)
      .foreach(println)







    sc.stop()




  }
}