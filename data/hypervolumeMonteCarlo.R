stop('this function should be optained via purl')
hypervolumeMonteCarlo <- function(x,num){
  myrange<-function(x){
    return(max(x)-min(x))
  }
  # deterministic portion
  included=myrange(x$nbiomass)*myrange(x$nmaxsyn)*myrange(x$nminsyn)
  excluded=max(x$nbiomass)*max(x$nmaxsyn)*max(x$nminsyn) - included
  
  #stochastic portion
  points=data.frame(nbiomass=runif(num,min(x$nbiomass),max(x$nbiomass)),
                    nmaxsyn =runif(num,min(x$nmaxsyn),max(x$nmaxsyn)),
                    nminsyn =runif(num,min(x$nminsyn),max(x$nminsyn)))
  a=dominated(points,x)
  
  return(included*sum(a)/num + excluded)
}