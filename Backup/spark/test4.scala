import org.apache.spark._

object test4 {

  def main(argment: Array[String]): Unit = {
    val sc = new SparkContext(new SparkConf().setAppName("test").setMaster("local[4]"))
    val file = sc.textFile("hdfs://quickstart.cloudera:8020/data/SogouQ.reduced")

        file.map(_.split('\t'))
            .map(x => (x(1),1))
            .reduceByKey(_+_)
            .map(x =>(x._2,x._1))
            .sortByKey(false)
            .map(x =>(x._2,x._1))
            .take(10)
            .foreach(println)

    sc.stop()

  }
}
