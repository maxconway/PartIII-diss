getNames <- function(strainName){
  names=read.table(paste0('./experiments/',strainName,'.names'),header=FALSE,sep=';')
  # loses some names
  names = as.character(names$V1)
}