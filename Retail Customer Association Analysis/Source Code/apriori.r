library(arules)
data=read.transactions("D:/Projects/Completed/1.5.MBA/groceries.csv",sep=",")
summary(data)

inspect(data[1:2])

library(arules)
rules=apriori(data,
              parameter = list(support=0.001,
                               confidence=0.8,
                               minlen=2))
rules
inspect(head(sort(rules,by="lift")[1:3]))