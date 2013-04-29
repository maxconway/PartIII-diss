
require(gdata)
GDMO=NULL
for(file in list.files(path = './experiments/', pattern = '.*GDMO.*.log',full.names=FALSE)){
  data = read.delim(paste('./experiments/',file,sep=''),
                    header=FALSE)
  colnames(data) = c('cputime','walltime','iterations','knockouts','maxsyn','minsyn','biomass','front','crowding','generation','pop','id','unknown')
  #strains
  if(startsWith(file,'iaf1260-ac')) data$strain<-'iaf1260-ac'
  if(startsWith(file,'iJO1366_Ecoli_suc_aerobic')) data$strain<-'iJO1366-aerobic'
  if(startsWith(file,'iJO1366_Ecoli_suc_anaerobic')) data$strain<-'iJO1366-anaerobic'
  if(startsWith(file,'geo_m_react')) data$strain<-'metallireducens'
  if(startsWith(file,'geo_m_react_glucose')) data$strain<-'metallireducens_glucose'
  if(startsWith(file,'geo_m_react_plus')) data$strain<-'metallireducens_plus'
  if(startsWith(file,'geo_s_react')) data$strain<-'sulfurreducens'
  if(all(is.null(data$strain))){
    data$strain<-regmatches(file,regexpr('-GDMO.*',file),invert=F)
  }
  #timings
  data$gentime=data$cputime-c(rep(0,data$pop[1]),head(data$cputime,-data$pop[1]))
  data$soltime=data$gentime/data$pop
  #negate
  #normalization
  natural<-unique(data[data$knockouts==0,c('strain','biomass','maxsyn','minsyn')])
  colnames(natural)<-c('strain','natbiomass','natmaxsyn','natminsyn')
  data<-merge(data,natural)
  data$nbiomass <- data$biomass/data$natbiomass
  data$nmaxsyn <- data$maxsyn/data$natmaxsyn
  data$nminsyn <- data$minsyn/data$natminsyn
  #join
  GDMO=rbind(GDMO,data)
}
GDMO$strain=as.factor(GDMO$strain)
FBAtimings<-read.csv('./FBAtimings.csv')
FBAtimings$FBAtime=FBAtimings$time
FBAtime=aggregate(FBAtime~strain,FBAtimings[,c('strain','FBAtime')],mean)
GDMO=merge(GDMO,FBAtime,all.x=T)

#remove unwanted
GDMO<-GDMO[!GDMO$strain %in% c('metallireducens_glucose','metallireducens_plus'),]
GDMO<-GDMO[GDMO$strain!='iJO1366-anaerobic',] #experiment seems to have failed
GDMO<-GDMO[!(
  (GDMO$id==2005735200&GDMO$generation>740)|
    (GDMO$id==1003985200)|
    (GDMO$id==1727016800)|
    (GDMO$id==1961459700) 
),]#part written generation

save(GDMO,file='GDMO.RData')
