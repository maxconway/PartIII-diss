BindChromosomes <- function(x){
  genepattern<-switch(as.character(unique(x$strain)),
                      sulfurreducens='GSU.*',
                      metallireducens='Gmet_.*')#check
  names=getNames(paste0(NameLookup(unique(x$strain)),'.reduced'))
  
  x.chromosomes<-NULL
  
  for(id in unique(x$id)){
    y<-x[x$id==id,]
    y.chromosomes=getChromosomes(id)
    colnames(y.chromosomes)<-c((names),c('maxsyn','minsyn','biomass','front','crowding','removeme'))
    y.chromosomes[,grepl(pattern=genepattern,colnames(y.chromosomes))]<-y.chromosomes[,grepl(genepattern,colnames(y.chromosomes))]==1
    y.chromosomes<-merge(y.chromosomes,y[,c('biomass','minsyn','maxsyn','knockouts','nmaxsyn','nminsyn','nbiomass')],by=c('biomass','minsyn','maxsyn'))
    #deduplicate
    y.chromosomes<-unique(y.chromosomes)
    #remove removeme
    y.chromosomes$removeme<-NULL
    x.chromosomes<-rbind(x.chromosomes,y.chromosomes)
  }
  
  return(x.chromosomes)
}