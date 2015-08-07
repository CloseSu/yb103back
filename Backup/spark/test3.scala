import org.apache.spark._

object test3 {

  def main(argment: Array[String]): Unit = {
    val sc = new SparkContext(new SparkConf().setAppName("test").setMaster("local[4]"))
    val file = sc.textFile("hdfs://quickstart.cloudera:8020/data/SogouQ.reduced")
    println(
       file.map(_.split('\t'))
      .filter(_.length ==5)
      .map(_(3).split(' '))
      .filter(_(0).toInt ==1)
      .filter(_(1).toInt ==2)
      .count
            )
    sc.stop()

  }
}
