library(readxl)
data=read_excel("D:/Projects/Completed/1.1.Hospital/Model Building and Interpretaion/1555054100_hospitalcosts.xlsx")
View(data)

library(caTools)
set.seed(1)
sample=sample.split(data$TOTCHG,SplitRatio = 0.80)
train_data=subset(data,sample==TRUE)
test_data=subset(data,sample==FALSE)

model=lm(TOTCHG~.,data = train_data)
summary(model)

newModel=lm(TOTCHG~AGE+LOS+APRDRG,data = train_data)
summary(newModel)

TOTCHG_pred=predict(newModel,newdata = test_data)
TOTCHG_pred1=data.frame(TOTCHG_pred)
View(TOTCHG_pred1)
final_data=cbind(test_data,TOTCHG_pred1)
View(final_data)
write.csv(final_data,"final_data.csv")
