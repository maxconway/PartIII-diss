source('./data/getNames.R',local=TRUE)
source('./data/getChromosomes.R',local=TRUE)

BindChromosomes <- function(x){
  id=unique(x$id)
  genepattern=switch(unique(x$strain),
                     sulfurreducens='GSU.*',
                     metallireducens='Gmet_.*')#check
  names=getNames(paste0(NameLookup(unique(x$strain))'.reduced'))
  x.chromosomes=getChromosomes(id)
  colnames(x.chromosomes)<-c((names),c('maxsyn','minsyn','biomass','front','crowding','?'))
  x.chromosomes[,grepl('GSU.*',colnames(x.chromosomes))]<-x.chromosomes[,grepl(genepattern,colnames(x.chromosomes))]==1
  x.chromosomes<-cbind(x.chromosomes,x[,c('knockouts','nmaxsyn','nminsyn','nbiomass')])
  #deduplicate
  x.chromosomes<-unique(x.chromosomes)
  return(x.chromosomes)
}