import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.SparkContext
import org.apache.spark.mllib.classification.{SVMModel, SVMWithSGD}
import org.apache.spark.mllib.evaluation.BinaryClassificationMetrics
import org.apache.spark.mllib.regression.LabeledPoint
import org.apache.spark.mllib.linalg.Vectors
import org.apache.spark.mllib.util.MLUtils
import org.apache.spark.mllib.optimization.L1Updater

object test8 {
  def main(argment: Array[String]): Unit = {
    val sc = new SparkContext(new SparkConf().setAppName("test").setMaster("local[4]"))

    val data = MLUtils.loadLibSVMFile(sc, "hdfs://quickstart.cloudera:8020/data/sample_libsvm_data.txt")

    val splits = data.randomSplit(Array(0.6, 0.4), seed = 11L)
    val training = splits(0).cache()
    val test = splits(1)


   // val numIterations = 100
    //val model = SVMWithSGD.train(training, numIterations)
    val svmAlg = new SVMWithSGD()
    svmAlg.optimizer.
      setNumIterations(200).
      setRegParam(0.1).
      setUpdater(new L1Updater)
    val model = svmAlg.run(training)



    model.clearThreshold()

    val scoreAndLabels = test.map { point =>
      val score = model.predict(point.features)
      (score, point.label)
    }

    val metrics = new BinaryClassificationMetrics(scoreAndLabels)
    val auROC = metrics.areaUnderROC()

    println("Area under ROC = " + auROC)

    model.save(sc, "model")
    val sameModel = SVMModel.load(sc, "model")

  }
}