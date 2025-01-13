library(rnn)

#X1, X2 are 5000 integers between 0 and 127
X1<-sample(0:127,5000,replace=TRUE)
X2<-sample(0:127,5000,replace=TRUE)

#Y is the next value of the sequence
Y=X1+X2

#Aim: Given X1 and X2, guess Y
#Featurization
X1<-int2bin(X1)
X2<-int2bin(X2)
Y<-int2bin(Y)

#Reshape data in a dataset
aX<-array(c(X1,X2),dim=c(dim(X1),2))
aY<-array(c(Y),dim=c(dim(Y),1))

#Train the model
MyModel<-trainr(Y=aY,X=aX,
                learningrate =0.1,
                hidden_dim = 10,
                batch_size = 100,
                numepochs =10)

#Fit
Ypred<-predictr(MyModel,aX)

#Interpret features
Ypred<-bin2int(Ypred)

#Compare Experiment to Predictions
ExpPred<-data.frame(Exp=bin2int(Y),Pred=Ypred)

library(ggplot2)
ggplot(data=ExpPred)+aes(x=Exp,y=Pred)+
  geom_point()+theme_bw()

#Without cheating...
#X1, X2 are 5000 integers between 0 and 127
nX1<-sample(0:127,5000,replace=TRUE)
nX2<-sample(0:127,5000,replace=TRUE)

#Y is the next value of the sequence
nY=nX1+nX2

#Aim: Given X1 and X2, guess Y
#Featurization
nX1<-int2bin(nX1)
nX2<-int2bin(nX2)
nY<-int2bin(nY)

#Reshape data in a dataset
naX<-array(c(nX1,nX2),dim=c(dim(nX1),2))
naY<-array(c(nY),dim=c(dim(nY),1))

#Fit
nYpred<-predictr(MyModel,naX)

#Interpret features
nYpred<-bin2int(nYpred)

#Compare Experiment to Predictions
ExpPred<-data.frame(Exp=bin2int(nY),Pred=nYpred)

library(ggplot2)

ggplot(data=ExpPred)+aes(x=Exp,y=Pred)+
  geom_point()+theme_bw()