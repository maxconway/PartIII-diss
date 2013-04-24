natural<-unique(GDMO[GDMO$knockouts==0,c('strain','biomass','maxsyn','minsyn')])
colnames(natural)<-c('strain','natbiomass','natmaxsyn','natminsyn')