dominated <- function(p,front){
  # if p is a point, points in front that dominate p
  # if p is a set of points, is each point dominated?
  
  if(!nrow(p)>1){
    return(apply(front,1,function(f){
      dominates(f,p)
    }))
  }
  if(is.data.frame(p) & nrow(p)>1){
    return(as.vector(by(p,1:nrow(p),function(a){
      singledom(a,front)
    })))
  }
}

dominates <- function(a,b){
  # does a dominate b?
  any(a>b)&!any(a<b)
}

#helper function
singledom <- function(p,front){
  if(is.data.frame(p) & nrow(p)==1){  # this also covers NULL
    for(i in nrow(front)){
      a=front[i,]
      if(dominates(a,p)){
        return(TRUE)
      }
    } 
    return(FALSE)
  }
}