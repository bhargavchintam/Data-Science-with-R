data=read.csv("Admission_Predict.csv",sep = ",",header = TRUE)
dim(data)
str(data)
data=data[,-c(1)]
View(data)
library(caTools)
set.seed(1)
sample=sample.split(data$Chance.of.Admit,SplitRatio = 0.80)
train_set=subset(data,sample==TRUE)
test_set=subset(data,sample==FALSE)

regressor=lm(Chance.of.Admit~.,train_set)
summary(regressor)

new_model=lm(Chance.of.Admit~GRE.Score+LOR+CGPA+Research,train_set)
summary(new_model)

chance_admi_pred=predict(new_model,test_set)
View(chance_admi_pred)

final_data=cbind(test_set,chance_admi_pred)
View(final_data)

write.csv(final_data,"D:/Projects/Completed/1.6.Admission Chance/final_data.csv")