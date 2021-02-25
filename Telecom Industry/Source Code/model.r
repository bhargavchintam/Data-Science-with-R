data=read.csv("churn_data.csv")
newData=data[,-c(1,2,3)]
View(newData)

library(caTools)
set.seed(2)
sample=sample.split(newData$churn,SplitRatio = 0.70)
trainData=subset(newData,sample==TRUE)
testData=subset(newData,sample==FALSE)

library(rpart)
model=rpart(churn~.,trainData)

library(rattle)
library(rpart.plot)
fancyRpartPlot(model)
pred=predict(model,testData,type="class")
View(pred)

library(caret)
cm=confusionMatrix(as.factor(testData$churn),as.factor(pred))
