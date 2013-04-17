require(gdata)
GDMO=NULL
for(file in list.files(path = './experiments/', pattern = '.*GDMO.*.log',full.names=FALSE)){
  data = read.delim(paste('./experiments/',file,sep=''),header=FALSE)
  colnames(data) = c('cputime','walltime','iterations','knockouts','maxsyn','minsyn','biomass','front','crowding','generation','pop','id','unknown')
  if(startsWith(file,'iaf1260-ac')) data$strain<-'iaf1260-ac'
  if(startsWith(file,'iJO1366_Ecoli_suc_aerobic')) data$strain<-'iJO1366-aerobic'
  if(startsWith(file,'iJO1366_Ecoli_suc_anaerobic')) data$strain<-'iJO1366-anaerobic'
  if(startsWith(file,'geo_m_react')) data$strain<-'metallireducens'
  if(startsWith(file,'geo_s_react')) data$strain<-'sulfurreducens'
  data$gentime=data$cputime-c(rep(0,data$pop[1]),head(data$cputime,-data$pop[1]))
  data$soltime=data$gentime/data$pop
  GDMO=rbind(GDMO,data)
}
data('FBAtimings')
FBAtimings$FBAtime=FBAtimings$time
FBAtime=aggregate(FBAtime~strain,FBAtimings[,c('strain','FBAtime')],mean)
GDMO=merge(GDMO,FBAtime)
save(GDMO,file='GDMO.RData')
