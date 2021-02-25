data1=read.csv("D:/Projects/Sem 2/1.4.Cluster with Insurance Company/cluster data.csv")
View(data1)
data=data1[,c(2,5)]
View(data)

k.max <- 15 

wss <- sapply(1:k.max,function(k) {kmeans(data,
                                          k)$tot.withinss})
plot (1:k.max,wss,type = "b",frame = FALSE,
      xlab = "no of cluster k ",
      ylab = "total within cluster sum of square")

k <- kmeans(data,3)
k

library(animation)
kmeans.ani(data,3)

k$withinss  #sum of individual cluster points
k$tot.withinss   #sum of total cluster within summ
k$centers   #center points of cluster
k$cluster  # grroups of data points in cluster

finaldata<-cbind(data,k$cluster)
write.csv(finaldata,"cluster_output.csv")