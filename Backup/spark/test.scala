import org.apache.spark._

object testa {

  def main(argment: Array[String]): Unit = {
    val sc = new SparkContext(new SparkConf().setAppName("test").setMaster("local[4]"))
    val distData = sc.parallelize(1 to 1000)
    println(distData.count())
    sc.stop()
  }
}
