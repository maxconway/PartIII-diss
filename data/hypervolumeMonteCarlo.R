hypervolumeMonteCarlo <- function(x,num){
  points=data.frame(biomass=runif(num,0,max(x$biomass)),maxsyn=runif(num,0,max(x$maxsyn)),minsyn=runif(num,0,max(x$minsyn)))
    a=apply(points,1,function(p){
      !dominators(p,x)>0
    })
    sum(a)/num*max(x$biomass)*max(x$maxsyn)*max(x$minsyn)
}