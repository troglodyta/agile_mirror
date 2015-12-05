cohensDz <-function(n, tval) {
  if(n == 0)
    stop("Division by 0")
  return(tval/sqrt(n))
}

clEffectSize <- function(nVal) {
  return(pnorm(nVal))
}

T_test_Yes_Yes_No_compute <- function(data1,data2) { 
  if(!is.null(data1) && !is.null(data2)) {
  tTest <- t.test(data1,data2)
  #TODO czy tVal jest dobrze wyliczane
  tval <- tTest$statistic
  np <- length(data1)
  cohensDzVal = cohensDz(np,tval)
  
  datas <- data.frame( 
    npairs =  np,
    tValue = tval,
    cohenDz = cohensDzVal,
    clEffectSize = clEffectSize(cohensDzVal)
    )
  }
  else{
    datas <- data.frame( 
      npairs =  0,
      tValue = 0,
      cohenDz = 0,
      clEffectSize = 0
    )
  }
  colnames(datas)[1] <- "n pairs"
  colnames(datas)[2] <- "t-value"
  colnames(datas)[3] <- "Cohen's dz"
  colnames(datas)[4] <- "CL effect size"
  return(datas)  
 
  
}

# widok 2
# TODO How its compute
computeR <-function(data1,data2) {
  return(0.72554232)
}

mDiff <- function(mean1, mean2) {
  return(0)
}

sDiff <- function(sd1, sd2) {
  return(0)
}


