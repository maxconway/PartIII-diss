hypervolumeMonteCarlo <- function(x,numpoints){
  points=data.frame(biomass=runif(num,0,max(s$biomass)),maxsyn=runif(num,0,max(s$maxsyn)),minsyn=runif(num,0,max(s$minsyn)))
    a=apply(points,1,function(p){
      !dominators(p,x)>0
    })
    sum(a)/num*max(s$biomass)*max(s$maxsyn)*max(s$minsyn)
}