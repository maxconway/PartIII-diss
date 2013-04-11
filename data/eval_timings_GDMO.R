# produce timing prediction accuracy plot
source('./timing-prediction.R')
GDMO = GDMO[,c('strain','cputime','generation','pop','id','FBAtime','walltime')]
GDMO = unique(GDMO)
GDMO$strain=as.factor(GDMO$strain)
GDMO = GDMO[sample(nrow(GDMO)),]
GDMO.train = head(GDMO,nrow(GDMO)*0.9)
GDMO.test = tail(GDMO,nrow(GDMO)*0.1)
GDMO.fit = lm(cputime~pop*generation*strain,GDMO.train)
GDMO.test$prediction=predict(GDMO.fit,newdata=GDMO.test)
boxplot(prediction/cputime~strain,GDMO.test)