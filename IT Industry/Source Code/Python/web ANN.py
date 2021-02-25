import pandas as pd
data=pd.read_excel("D:/Projects/On Going/Web Data Analysis/1555058318_internet_dataset.xlsx")
x=data.iloc[:,[1,3,4,5,6]].values
y=data.iloc[:,0].values

from sklearn.preprocessing import LabelEncoder,OneHotEncoder
objL=LabelEncoder()
x[:,1]=objL.fit_transform(x[:,1])

objO=OneHotEncoder(categorical_features=[1])
x=objO.fit_transform(x)

from sklearn.model_selection import train_test_split as tts
x_train,x_test,y_train,y_test=tts(x,y,test_size=0.20,random_state=0)

import keras
from keras.models import Sequential
from keras.layers import Dense

classifier=Sequential()
classifier.add(Dense(units= 6, kernel_initializer = 'uniform', activation = 'relu', input_dim = 13))
classifier.add(Dense(units= 6, kernel_initializer = 'uniform', activation = 'relu'))
classifier.add(Dense(units = 1, kernel_initializer = 'uniform', activation = 'linear'))

classifier.compile(optimizer = 'adam', loss = 'mse', metrics = ['accuracy'])

classifier.fit(x_train, y_train, batch_size = 10, epochs = 50)
a=classifier.predict(x_test)