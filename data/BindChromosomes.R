BindChromosomes <- function(x){
  genepattern<-switch(as.character(unique(x$strain)),
                      sulfurreducens='GSU.*',
                      metallireducens='Gmet_.*',
                      metallireducens_plus='Gmet_.*|[[:punct:]]?b[0-9]{4}.*'
                      )
  names=getNames(paste0(NameLookup(unique(x$strain)),'.reduced'))
  x.chromosomes<-NULL
  
  for(id in unique(x$id)){
    y.chromosomes=getChromosomes(id)
    colnames(y.chromosomes)<-c((names),c('maxsyn','minsyn','biomass','front','crowding','removeme'))
    y.chromosomes[,c('maxsyn','minsyn','biomass')] <- -y.chromosomes[,c('maxsyn','minsyn','biomass')]
    y.chromosomes[,grepl(pattern=genepattern,colnames(y.chromosomes))]<-y.chromosomes[,grepl(genepattern,colnames(y.chromosomes))]==1
    y.chromosomes$strain<-unique(x[x$id==id,'strain'])
    y.chromosomes<-merge(y.chromosomes,natural)
    y.chromosomes$nbiomass <- y.chromosomes$biomass/y.chromosomes$natbiomass
    y.chromosomes$nmaxsyn <- y.chromosomes$maxsyn/y.chromosomes$natmaxsyn
    y.chromosomes$nminsyn <- y.chromosomes$minsyn/y.chromosomes$natminsyn
    #remove removeme
    y.chromosomes$removeme<-NULL
    x.chromosomes<-rbind(x.chromosomes,y.chromosomes)
  }
  
  return(x.chromosomes)
}