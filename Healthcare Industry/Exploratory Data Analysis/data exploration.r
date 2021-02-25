library(readxl)
data=read_excel("D:/Projects/Completed/1.1.Hospital/Model Building and Interpretaion/1555054100_hospitalcosts.xlsx")
View(data)

nrow(data)
ncol(data)
dim(data)
#500 observation of 6 variable
#dependent Vriable is TOTCHG

names(data)
#There is 6 Variables

str(data)
#All the variables are of Numeric DataType

class(data)
#dataframe

head(data,10)
tail(data,10)
#1. Exploring Age Variable:Age of Patients
summary(data$AGE)
var(data$AGE)
sd(data$AGE)
#Min. age is 0, Max. is 17. Avg. age is 5.08
#There is a deviation of 6.94 from mean

library(ggplot2)
a=ggplot(data,aes(x=data$AGE))+geom_histogram(fill="blue")
b=a+scale_x_continuous(name="Age Group")+scale_y_continuous(name="Count of Each Age Class")
b+ggtitle("Age of Patients")
c=as.factor(data$AGE)
summary(c)
#With the help of histogram and factor function we
#can see there are more than 307 patients having 
#age in 0-1

#2. Exploring Female Variable

d=table(data$FEMALE)
#256 Patients are Female out of 500

barplot(d,
        main="Count of Female",
        xlab = "Female",
        ylab="Count",
        col=rainbow(2),
        legend=rownames(c))

#Using Barplot to visualize number of Females

pct=round(d/sum(d)*100)
lbs=paste(c("Not Female","Female")," ",pct,"%",sep=" ")
library(plotrix)
pie3D(d,labels = lbs,explode = 0.001,main="Percentage of Female Patients")

#With the Help of 3D Pie Chart,
#We can see that 51% Patients are Female

#3. Exploring LOS(Length of Stay) Variable

e=factor(data$LOS)
e=as.data.frame(e)
View(e)
f=table(data$LOS)
range(data$LOS)
summary(data$LOS)
#There are patients who discharges on same
#day from hospital whereas there is a
#patient also who stayed for 41 das
#On an avg. Patients stayed for 3 days.

barplot(f,xlab = "Length of Stay",
        ylab = "Count",
        main="Count of Length of Stay",col="blue")
#Max. of Patients almost 350 who stayed about 2-3 days

#4. Exploring RACE Variable
factor(data$RACE)
#There is 6 race among Patients.

g=table(data$RACE)
barplot(g,main="Race Counts",col="blue",
        xlab = "Race",ylab = "Count")
#There are 484 Patients(huge:97%) from Race 1 and some are
#from 2,3,4,5 and 6

#5. Exploring TOTCHG(Hospital Discharge Cost) Variable
#This is dependent Variable
range(data$TOTCHG)
#Minimum Hospital Cost is 532 and Max. is 48388

summary(data$TOTCHG)
#Avg. hospital cost is 2774

var(data$TOTCHG)
sd(data$TOTCHG)
#There is deviation of 3888.40 from mean
hist(data$TOTCHG,col="cyan",main="Hopsital Discharge COst Frequency",
     xlab = "Discharge Cost",ylab = "Frequency")
#We can see from histogram max. patients are
#paying between 0 to 5000 at the time of discharge.

#6.Exploring APRDRG Variable
summary(data$APRDRG)
#Minimum is 21, max is 952, avg. is 616.4
var(data$APRDRG)
sd(data$APRDRG)
#there is deviation in value from mean of 178.316