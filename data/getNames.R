getNames <- function(strainName){
  names=read.csv(paste('./experiments/',strainName,'.names',sep=''),header=FALSE)
  # loses some names
  names = as.character(names$V1)
}