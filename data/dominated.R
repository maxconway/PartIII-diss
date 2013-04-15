dominates <- function(a,b){
  # does a dominate b?
  any(a>b)&!any(a<b)
}

#helper function
singledom <- function(p,front){
  stopifnot(is.data.frame(p) & nrow(p)==1)  # this also covers NULL
  for(i in 1:nrow(front)){
    a=front[i,]
    if(dominates(a,p)){
      return(TRUE)
    }
  } 
  return(FALSE)
}

dominated <- function(p,front){
  # if p is a point, points in front that dominate p
  # if p is a set of points, is each point dominated?
  if(nargs()==1){
    return(dominated(p,p))
  }
  
  if(!nrow(p)>1){
    return(apply(front,1,function(f){
      dominates(f,p)
    }))
  }
  if(is.data.frame(p) & nrow(p)>1){
    return(apply(p,1,function(a){
      singledom(a,front)
    }))
  }
}