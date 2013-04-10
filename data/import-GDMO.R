GDMO=NULL
for(file in list.files(path = './experiments/', pattern = '.*GDMO.*.log',full.names=FALSE)){
  data = read.delim(paste('./experiments/',file,sep=''),header=FALSE)
  colnames(data) = c('cputime','iterations','knockouts','maxsyn','minsyn','biomass','front','crowding','generation','pop','V12','id')
  switch(match(strsplit(file,'-GDMO',fixed=TRUE)[1], c('geo_m_react','geo_s_react','iaf1260-ac')),
         data$strain <- 'metallireducens',
         data$strain <- 'sulfurreducens',
         data$strain <- 'iaf1260_ac'
  )
  data$gentime=data$cputime-c(rep(0,data$pop[1]),head(data$cputime,-data$pop[1]))
  data$soltime=data$gentime/data$pop
  GDMO=rbind(GDMO,data)
}
