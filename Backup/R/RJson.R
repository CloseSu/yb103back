
#備用存放
json_file <- lapply(json_file, function(x) {
  x[sapply(x, is.null)] <- NA
  unlist(x)
})

library(rjson)
#JSON轉成data.frame

input = readLines("zips.json")
data = lapply(X=input,fromJSON)

asframe = as.data.frame(do.call(rbind, data))
head(asframe)
str(asframe)

head(asframe[4])

x = as.data.frame(sapply(asframe,unlist))

head(x)
str(x)






