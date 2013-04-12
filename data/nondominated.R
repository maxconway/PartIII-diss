dominates <- function(a,b){
  # does a dominate b?
  any(a>b)&!any(a<b)
}

dominators <- function(sol,frame){
  # how many rows in frame dominate sol?
  apply(frame,1,function(t){
    dominates(t,sol)
  })
}

nondominated <- function(x){
  # which rows of x are nondominated?
  # Returns:
  #  boolean vector
  apply(x,1,function(a){
    !any(dominators(a,x))
  })
}

fnondominated <- function(df){
  # which rows of x are nondominated?
  # Returns:
  #  data.frame
  df[nondominated(df),]
}