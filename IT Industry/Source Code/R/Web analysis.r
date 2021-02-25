library(readxl)
data=read_excel("D:/Projects/Completed/1.7.Web Data Analysis/Model/1555058318_internet_dataset.xlsx")

data$Continent=factor(data$Continent,
                      levels = c("AF","AS","EU","N.America","OC","SA"),
                      labels = c(0,1,2,3,4,5))

factor(data$Sourcegroup)
levels(data$Sourcegroup)
table(data$Sourcegroup)
data$Sourcegroup=factor(data$Sourcegroup,
                        levels = c("(direct)","google","public.tableausoftware.com","t.co","visualisingdata.com","facebook","Others","reddit.com","tableausoftware.com"),
                        labels = c(0,1,2,3,4,5,6,7,8))

data$Timeinpage=scale(data$Timeinpage)
View(data)

chisq.test(data$Uniquepageviews,data$Visits) #dependent

factor(data$Exits)

chisq.test(data$Exits,data$Continent)
chisq.test(data$Exits,data$Sourcegroup)
chisq.test(data$Exits,data$Timeinpage)
chisq.test(data$Exits,data$Uniquepageviews)
chisq.test(data$Exits,data$Visits)
chisq.test(data$Exits,data$Bounces)

#Unique page view
#Exists
#Visits

#these 3 attributes are linearly depending on bounces.
library(ggplot2)
ggplot(data,aes(x=data$Bounces,y=data$Visits))+geom_point(color="red",shape=3)

library(caTools)
set.seed(123)
sample=sample.split(data,SplitRatio = 0.80)
train_set=subset(data,sample==TRUE)
test_set=subset(data,sample==FALSE)

model=lm(Bounces~.,train_set)
summary(model)

factor(data$Continent)

#rebuilding model using only significant variable

newModel=lm(Bounces~Exits+Sourcegroup+Timeinpage+Visits,train_set)
summary(newModel)

predBounce=predict(newModel,test_set)
View(predBounce)
predBounce=round(predBounce)
View(predBounce)
factor(predBounce)

final_data=cbind(test_set,predBounce)
View(final_data)

write.csv(final_data,"D:/Projects/On Going/Web Data Analysis/final_output.csv")

