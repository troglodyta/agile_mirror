# widok 1
cohensDz <- function(n, tval) {
  if (n == 0)
    stop("Division by 0")
  return(tval / sqrt(n))
}

clEffectSize <- function(nVal) {
  return(pnorm(nVal))
}

T_test_Yes_Yes_No_compute <- function(data1,data2) {
  if (!is.null(data1) && !is.null(data2)) {
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
computeR <- function(data1,data2) {
  return(0.72554232)
}

df <- function(n) {
  return(n - 1)
}

mDiff <- function(mean1, mean2) {
  return(abs(mean1 - mean2))
}

sDiff <- function(sd1, sd2, r) {
  return(sqrt(sd1 ^ 2 + sd2 ^ 2 - 2 * sd1 * sd2 * r))
}

SEdiff <- function(sd1, sd2, n, r) {
  return(sqrt(((sd1 ^ 2 / n) + (sd2 ^ 2 / n)) - (2 * r * (sd1 / sqrt(
    n
  )) * (sd2 / sqrt(
    n
  )))))
}

CIMdiff <- function (Mdiff, SEdiff, n) {
  return(Mdiff - SEdiff * abs(qt(0.05 / 2,df = n - 1)))
}

lowHigh <- function (Mdiff, SEdiff, n) {
  return(Mdiff + SEdiff * abs(qt(0.05 / 2,df = n - 1)))
}

pval <- function(df, tval) {
  return(pt(-abs(tval), df) * 2)
}

cohensDz2 <- function (Mdiff, Sdiff) {
  return(Mdiff / Sdiff)
}

cohensDrm <- function (cohensDz2, r) {
  return(cohensDz2 * sqrt(2 * (1 - r)))
}

hedgesGrm <- function (n, cohensDrm) {
  return(cohensDrm * (1 - (3 / (4 * (
    n - 1
  ) - 1))))
}

cohensDav <- function (mDiff, sd1, sd2) {
  return(mDiff / sqrt(((sd1 ^ 2 + sd2 ^ 2) / 2)))
}

hedgesGav <- function (cohensDav, n) {
  return(cohensDav * (1 - (3 / (4 * (
    n - 1
  ) - 1))))
}

rec_value <- function (val, mean1, mean2, sd1, sd2, n) {
  return(abs((abs((mean1 - mean2) / (sqrt((((n - 1) * sd1 ^ 2) + ((n - 1) *
                                                                    sd2 ^ 2)
  ) / (n + n - 2)))
  )) - val))
}
recommended <-
  function (cohensDrm, cohensDav, mean1, mean2, sd1, sd2, n) {
    if (rec_value(cohensDrm,mean1, mean2, sd1, sd2, n) < rec_value(cohensDav,mean1, mean2, sd1, sd2, n)) {
      return('Grm')
    }
    else {
      return('Gav')
    }
    
  }

clEffectSize2 <- function(mDiff, sDiff) {
  return(clEffectSize(nVal = (mDiff / sDiff)))
}

tval <- function(mDiff, sDiff, n) {
  return(mDiff / (sDiff / sqrt(n)))
}

T_test_Yes_Yes_Yes_compute <- function(data1,data2) {
  if (!is.null(data1) && !is.null(data2)) {
    mean1 <- mean(data1)
    mean2 <- mean(data2)
    sd1 <- sd(data1)
    sd2 <- sd(data2)
    n <- length(data1)
    r <- computeR(data1,data2)
    df <- df(n)
    
    mDiff <- mDiff(mean1 = mean1,
                   mean2 = mean2
                   )
    
    datas <- data.frame(
      c(mean1,mean2,mDiff)
      
    )
  }
  else{
    datas <- data.frame(
    )
  }
  return(datas)
  }
