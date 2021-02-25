concrete=read.csv("D:/Projects/Sem 2/1.11.Strength of Concrete using ANN/concrete.csv")

normalize=function(x){
  return((x-min(x))/(max(x)-min(x)))
}

concrete_norm=as.data.frame(lapply(concrete, normalize))

set.seed(12345)
concrete_train=concrete_norm[1:773,]
concrete_test=concrete_norm[773:1030,]

install.packages("neuralnet")
library(neuralnet)

model=neuralnet(strength~.,concrete_train,hidden = c(2))
plot(model)

model_result=compute(model,concrete_test[1:8])

model_result$neurons

pred=model_result$net.result

cor(pred,concrete_test$strength)
