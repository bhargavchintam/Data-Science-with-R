sms_raw=read.csv("D:/Projects/Sem 2/1.9.SMS Filter/Model and Datas/sms_spam.csv",stringsAsFactors = FALSE)
sms_raw$type=as.factor(sms_raw$type)

install.packages("tm")

library(tm)

#CREATING CORPUS

sms_corpus=VCorpus(VectorSource(sms_raw$text))
sms_corpus
View(sms_corpus)
inspect(sms_corpus[1:2])
as.character(sms_corpus[[2]])

lapply(sms_corpus[1:3], as.character)

#tRANSFORMING ALL THE SMS IN TO LOWER LETTER

sms_corpus_clean=tm_map(sms_corpus,content_transformer(tolower))

#removing Numbers
sms_corpus_clean=tm_map(sms_corpus_clean,removeNumbers)

#removing StopWords
stopwords()
sms_corpus_clean=tm_map(sms_corpus_clean,removeWords,stopwords())

#removing Punctuation
sms_corpus_clean=tm_map(sms_corpus_clean,removePunctuation)

#replacePunctuation=function(x){
#  gsub("[[:punct:]]+"," ",x)
#}
#sms_corpus_clean=tm_map(sms_corpus_clean,replacePunctuation)

#Stemming
install.packages("SnowballC")
library(SnowballC)
sms_corpus_clean=tm_map(sms_corpus_clean,
                        stemDocument)

#Removing Extra WhiteSpace
sms_corpus_clean=tm_map(sms_corpus_clean,
                        stripWhitespace)

#Document Term Matrix(Tokenization)
sms_dtm=DocumentTermMatrix(sms_corpus_clean)
sms_dtm

sms_dtm_train=sms_dtm[1:4174,]
sms_dtm_test=sms_dtm[4175:5574,]

sms_train_labels=sms_raw[1:4174,]$type
sms_test_labels=sms_raw[4175:5574,]$type

prop.table(table(sms_train_labels))
prop.table(table(sms_test_labels))

install.packages("wordcloud")

library(wordcloud)
wordcloud(sms_corpus_clean,min.freq = 50,
          random.order = TRUE,
          colors = brewer.pal(8,"Dark2"))

spam=subset(sms_raw,type=="spam")
ham=subset(sms_raw,type=="ham")

wordcloud(spam$text,min.freq = 50)
wordcloud(ham$text,min.freq = 50,random.order = FALSE)

sms_freq_words=findFreqTerms(sms_dtm_train,5)
sms_freq_words

sms_dtm_freq_train=sms_dtm_train[,sms_freq_words]
sms_dtm_freq_train
dim(sms_dtm_freq_train)

sms_dtm_freq_test=sms_dtm_test[,sms_freq_words]
dim(sms_dtm_freq_test)

convert_counts=function(x){
  x=ifelse(x>0,"Yes","No")
}

sms_train=apply(sms_dtm_freq_train,2,convert_counts)
sms_test=apply(sms_dtm_freq_test, 2, convert_counts)

library(e1071)
sms_classifier=naiveBayes(sms_train,sms_train_labels)
sms_classifier

sms_test_pred=predict(sms_classifier,sms_test)
View(sms_test_pred)

library(gmodels)
CrossTable(sms_test_pred,sms_test_labels,
           prop.chisq = FALSE,
           dnn = c("predicted","actual"))
library(caret)
confusionMatrix(sms_test_pred,sms_test_labels,positive = "spam")
