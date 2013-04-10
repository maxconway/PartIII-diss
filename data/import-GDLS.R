for(file in list.files(path = './experiments/', pattern = '.*GDLS.*.log',full.names=FALSE)){
  data = read.delim(paste('./experiments/',file,sep=''),header=FALSE)
  colnames(data)[1:6] = c('cputime','iterations','knockouts','maxsyn','minsyn','biomass')
  assign(make.names(sub('.log','',file,fixed=TRUE)),data)
  rm(data)
}
