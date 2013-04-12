nondominated <- function(x){
  dominates <- function(a,b){
    any(a>b)&!any(a<b)
  }
  dominators <- function(sol,frame){
    apply(frame,1,function(t){
      dominates(t,sol)
    })
  }
  apply(x,1,function(a){
    !any(dominators(a,x))
  })
}