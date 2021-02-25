data=read.csv("D:/Projects/Sem 2/1.2.Cancer Remission/Remission.csv")
set.seed(200)

train_obs <- floor (0.8*nrow (data))
print(train_obs)
train_ind<-sample(seq_len(nrow(data)),size=train_obs)
test = -train_ind
train_data<-data[train_ind,]
test_data<-data[-train_ind,]
testing_high <- data$Remiss[test]

regmod<-glm(Remiss~.,data = train_data,family=binomial())
summary(regmod)

prob<- predict(regmod, test_data,type="response")
prob1<- data.frame(prob)

final=cbind(testing_high,prob1)
write.csv(final,"D:/Projects/Completed/1.2.Cancer Remission/New Remission.csv")

result=ifelse(prob>0.5,1,0)

library(caret)
cm=confusionMatrix(as.factor(testing_high),
                   as.factor(result),positive = '1')
cm

library(gmodels)
CrossTable(testing_high,result,prop.chisq = FALSE)
