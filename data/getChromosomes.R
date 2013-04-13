getChromosomes <- function(id){
  # returns table of knockouts, then properties
  file=unique(list.files(path="./experiments/",pattern=paste0(substr(as.character(id),1,6),'.*.chr'),full.names=TRUE))
  chromosomes=read.delim(file,header=FALSE)
  return(chromosomes)
}