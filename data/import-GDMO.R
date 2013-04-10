for(file in list.files(path = './experiments/', pattern = '.*GDMO.*.log',full.names=FALSE)){
  data = read.delim(paste('./experiments/',file,sep=''),header=FALSE)
  colnames(data)[1:9] = c('cputime','iterations','knockouts','maxsyn','minsyn','biomass','front','crowding','generation','population')
  assign(make.names(sub('.log','',file,fixed=TRUE)),data)
  rm(data)
}
