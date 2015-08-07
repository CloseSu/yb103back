import org.apache.spark._
import org.apache.spark.deploy._
object test2 {

  def main(argment: Array[String]): Unit = {
    val sc = new SparkContext(new SparkConf().setAppName("test").setMaster("local[4]"))
    val data =  sc.textFile("hdfs://quickstart.cloudera:8020/data/SogouQ.reduced")
                .map(_.split(" ")(0)).filter(time => time >"00:00:00" & time <"12:00:00")

              data.map(_.split('\t'))
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
  /*
  .map(_.split(" ")(0)).filter(time => time >"00:00:00" & time <"12:00:00")
  .saveAsTextFile("hdfs://quickstart.cloudera:8020/data/testData")
  */