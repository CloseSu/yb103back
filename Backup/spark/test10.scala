import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.mllib.regression.LabeledPoint
import org.apache.spark.mllib.regression.LinearRegressionModel
import org.apache.spark.mllib.regression.LinearRegressionWithSGD
import org.apache.spark.mllib.linalg.Vectors

object test10 {
  def main(argment: Array[String]): Unit = {
    val sc = new SparkContext(new SparkConf().setAppName("test").setMaster("local[4]"))

    val data = sc.textFile("hdfs://quickstart.cloudera:8020/data/lpsa.data")
    val parsedData = data.map { line =>
      val parts = line.split(',')
      LabeledPoint(parts(0).toDouble, Vectors.dense(parts(1).split(' ').map(_.toDouble)))
    }.cache()


    val numIterations = 100
    val model = LinearRegressionWithSGD.train(parsedData, numIterations)


    val valuesAndPreds = parsedData.map { point =>
      val prediction = model.predict(point.features)
      (point.label, prediction)
    }

    val MSE = valuesAndPreds.map{case(v, p) => math.pow((v - p), 2)}.mean()
    println("training Mean Squared Error = " + MSE)

    model.save(sc, "model3")
    val sameModel = LinearRegressionModel.load(sc, "model3")


  }
}