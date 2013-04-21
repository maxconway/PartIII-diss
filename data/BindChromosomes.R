BindChromosomes <- function(x){
  id=unique(x$id)
  genepattern<-switch(as.character(unique(x$strain)),
                     sulfurreducens='GSU.*',
                     metallireducens='Gmet_.*')#check
  names=getNames(paste0(NameLookup(unique(x$strain)),'.reduced'))
  x.chromosomes=getChromosomes(id)
  colnames(x.chromosomes)<-c((names),c('maxsyn','minsyn','biomass','front','crowding','removeme'))
  x.chromosomes[,grepl(pattern=genepattern,colnames(x.chromosomes))]<-x.chromosomes[,grepl(genepattern,colnames(x.chromosomes))]==1
  x.chromosomes<-cbind(x.chromosomes,x[,c('knockouts','nmaxsyn','nminsyn','nbiomass')])
  #deduplicate
  x.chromosomes<-unique(x.chromosomes)
  #remove removeme
  x.chromosomes$removeme<-NULL
  return(x.chromosomes)
}