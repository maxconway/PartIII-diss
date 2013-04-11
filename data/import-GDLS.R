GDLS=NULL
for(file in list.files(path = './experiments/', pattern = '.*GDLS.*.log',full.names=FALSE)){
  data = read.delim(paste('./experiments/',file,sep=''),header=FALSE)
  cols = c('cputime','walltime','iterations','minsyn','maxsyn','biomass','knockouts','id','nbhdsz','M')
  colnames(data)[1:10] = cols
  data=data[,cols]
  if(startsWith(file,'iaf1260-ac')) data$strain<-'iaf1260-ac'
  if(startsWith(file,'geo_s_react')) data$strain<-'sulfurreducens'
  if(startsWith(file,'geo_m_react')) data$strain<-'metallireducens'
  GDLS=rbind(GDLS,data)
}
