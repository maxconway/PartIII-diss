GDLS=NULL
source('./natural.R')
require(gdata,quiet=TRUE)
for(file in list.files(path = './experiments/', pattern = '.*GDLS.*.log',full.names=FALSE)){
  data = read.delim(paste('./experiments/',file,sep=''),
                    header=FALSE)
  cols = c('cputime','walltime','iterations','minsyn','maxsyn','biomass','knockouts','id','nbhdsz','M')
  colnames(data)[1:10] = cols
  data=data[,cols]
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
  #normalization
  data<-merge(data,natural,by=c('strain'))
  data$nbiomass <- data$biomass/data$natbiomass
  data$nmaxsyn <- data$maxsyn/data$natmaxsyn
  data$nminsyn <- data$minsyn/data$natminsyn
  GDLS=rbind(GDLS,data)
}
#type correction
GDLS$strain=as.factor(GDLS$strain)
GDLS$nbhdsz<-as.integer(GDLS$nbhdsz)
GDLS$M<-as.integer(GDLS$M)
FBAtimings<-read.csv('./FBAtimings.csv')
FBAtimings$FBAtime=FBAtimings$time
FBAtime=aggregate(FBAtime~strain,FBAtimings[,c('strain','FBAtime')],mean)
GDLS=merge(GDLS,FBAtime,all.x=T)

GDLS<-GDLS[GDLS$nmaxsyn<10,]

save(GDLS,file='GDLS.RData')
