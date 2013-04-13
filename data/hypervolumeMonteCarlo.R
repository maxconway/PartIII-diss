hypervolumeMonteCarlo <- function(x,num){
  myrange<-function(x){
    return(max(x)-min(x))
  }
  # deterministic portion
  included=myrange(x$biomass)*myrange(x$maxsyn)*myrange(x$minsyn)
  excluded=max(x$biomass)*max(x$maxsyn)*max(x$minsyn)-included
  
  #stochastic portion
  points=data.frame(biomass=runif(num,min(x$biomass),max(x$biomass)),maxsyn=runif(num,min(x$maxsyn),max(x$maxsyn)),minsyn=runif(num,min(x$minsyn),max(x$minsyn)))
  a=dominated(points,x)
  
  return(sum(a)/num*included + excluded)
}