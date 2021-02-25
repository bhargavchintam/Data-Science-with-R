data=read.csv("D:/Projects/Sem 2/1.2.Cancer Remission/Remission.csv")
set.seed(200)

train_obs <- floor (0.8*nrow (data))
train_ind<-sample(seq_len(nrow(data)),size=train_obs)
test = -train_ind
train_data<-data[train_ind,]
test_data<-data[-train_ind,]

testing_high <- data$Remiss[test]

library(e1071)
model=svm(Remiss~.,train_data,
          type="C-classification",kernel="linear")
summary(model)
pred<- predict(model, test_data)
table(test_data$Remiss,pred)

install.packages("caret")

library(caret)
cm=confusionMatrix(as.factor(test_data$Remiss),as.factor(pred),positive = "1")
cm
