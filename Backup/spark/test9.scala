import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.SparkContext
import org.apache.spark.mllib.classification.{LogisticRegressionWithLBFGS, LogisticRegressionModel}
import org.apache.spark.mllib.evaluation.MulticlassMetrics
import org.apache.spark.mllib.regression.LabeledPoint
import org.apache.spark.mllib.linalg.Vectors
import org.apache.spark.mllib.util.MLUtils

object test9 {
  def main(argment: Array[String]): Unit = {
    val sc = new SparkContext(new SparkConf().setAppName("test").setMaster("local[4]"))
    val data = MLUtils.loadLibSVMFile(sc, "hdfs://quickstart.cloudera:8020/data/sample_libsvm_data.txt")

    val splits = data.randomSplit(Array(0.6, 0.4), seed = 11L)
    val training = splits(0).cache()
    val test = splits(1)

    val model = new LogisticRegressionWithLBFGS()
      .setNumClasses(10)
      .run(training)

    val predictionAndLabels = test.map { case LabeledPoint(label, features) =>
      val prediction = model.predict(features)
      (prediction, label)
    }

    val metrics = new MulticlassMetrics(predictionAndLabels)
    val precision = metrics.precision
    println("Precision = " + precision)


    model.save(sc, "Mode2")
    val sameModel = LogisticRegressionModel.load(sc, "Mode2")





  }
}