# produce timing prediction accuracy plot
source('./timing-prediction.R')
GDMO = GDMO[sample(nrow(GDMO)),]
GDMO.train = head(GDMO,nrow(GDMO)*0.9)
GDMO.test = tail(GDMO,nrow(GDMO)*0.1)
GDMO.fit = lm(cputime~pop*iterations*strain,GDMO.train)
GDMO.pred$prediction=predict(GDMO.fit,newdata=GDMO.test)
boxplot(prediction/cputime~strain,GDMO.pred)