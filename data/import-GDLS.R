GDLS=NULL
for(file in list.files(path = './experiments/', pattern = '.*GDLS.*.log',full.names=FALSE)){
  data = read.delim(paste('./experiments/',file,sep=''),header=FALSE)
  cols = c('cputime','walltime','iterations','minsyn','maxsyn','biomass','id','nbhdsz','maxknock','knockouts')
  colnames(data)[1:7] = cols
  data=data[,cols]
  if(startsWith(file,'iaf1260-ac')) data$strain<-'iaf1260-ac'
  if(startsWith(file,'geo_m_react')) data$strain<-'metallireducens'
  if(startsWith(file,'geo_s_react')) data$strain<-'sulfurreducens'
  GDLS=rbind(GDLS,data)
}
