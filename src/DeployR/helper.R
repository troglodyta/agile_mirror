# widok 1
roundN <- 4

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
    cohensDzVal <- cohensDz(np,tval)
    clEffectSizeVal <- clEffectSize(cohensDzVal)
    datas <- data.frame(
      c('n pairs','t-value','Cohens dz','CL effect size'),
      c(np,tval,cohensDzVal,clEffectSizeVal)
    )
    
  }
  else{
    datas <- data.frame(c('n pairs','t-value','Cohens dz','CL effect size'),
                        c('','','',''))
  }
  colnames(datas)[1] <- "A"
  colnames(datas)[2] <- "B"
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
    val1 = rec_value(cohensDrm,mean1, mean2, sd1, sd2, n)
    val2 = rec_value(cohensDav,mean1, mean2, sd1, sd2, n)
    if (is.nan(val1) || is.nan(val2))
      return('')
    if (val1 < val2) {
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
    v_mean1 <- mean(data1)
    v_mean2 <- mean(data2)
    v_sd1 <- sd(data1)
    v_sd2 <- sd(data2)
    v_n <- length(data1)
    v_r <- computeR(data1,data2)
    v_df <- df(v_n)
    
    v_mDiff <- mDiff(mean1 = v_mean1,
                     mean2 = v_mean2)
    v_sDiff <-  sDiff(sd1 = v_sd1,
                      sd2 = v_sd2,
                      r = v_r)
    
    v_SEDiff <-  SEdiff(
      sd1 = v_sd1,
      sd2 = v_sd2,
      n = v_n,
      r = v_r
    )
    
    v_cimDiff <-  CIMdiff(Mdiff = v_mDiff,
                          SEdiff = v_SEDiff,
                          n = v_n)
    v_lowHigh <-  lowHigh(Mdiff = v_mDiff,
                          SEdiff = v_SEDiff,
                          n = v_n)
    v_tVal <-  tval(mDiff = v_mDiff,
                    sDiff = v_sDiff,
                    n = v_n)
    
    v_pval <-  pval(df = v_df,
                    tval = v_tVal)
    v_cohensDz2 <-  cohensDz2(Mdiff = v_mDiff,
                              Sdiff = v_sDiff)
    v_cohensDrm <-  cohensDrm(cohensDz2 = v_cohensDz2,
                              r = v_r)
    v_hedgesGrm <-  hedgesGrm(cohensDrm = v_cohensDrm,
                              n = v_n)
    v_cohensDav <-  cohensDav(mDiff = v_mDiff,
                              sd1 = v_sd1,
                              sd2 = v_sd2)
    v_hedgesGav <-  hedgesGav(cohensDav = v_cohensDav,
                              n = v_n)
    v_recommended <-  recommended(
      cohensDrm = v_cohensDrm,
      cohensDav = v_cohensDav,
      mean1 = v_mean1,
      mean2 = v_mean2,
      sd1 = v_sd1,
      sd2 = v_sd2,
      n = v_n
    )
    v_clEffectSize2 <-  clEffectSize2(mDiff = v_mDiff,
                                      sDiff = v_sDiff)
    
    datas <- data.frame(
      c('Mean1','SD1','n pairs','t','','',''),
      c(v_mean1,v_sd1,v_n,v_tVal,'','',''),
      c('Mean2','SD2','r','df','','',''),
      c(v_mean2,v_sd2,v_r,v_df,'','',''),
      c(
        'Mdiff','Sdiff','SEdiff','95% CI Mdiff','[Low; High]','p',''
      ),
      c(v_mDiff,v_sDiff,v_SEDiff,v_cimDiff,v_lowHigh,v_pval,''),
      c(
        'Cohens dz','Cohens drm','Hedges grm','Cohens dav','Hedges gav','Recommended','CL effect size'
      ),
      c(
        v_cohensDz2,v_cohensDrm,v_hedgesGrm,v_cohensDav,v_hedgesGav,v_recommended,v_clEffectSize2
      )
      
    )
    
    colnames(datas)[1] <- "A"
    colnames(datas)[2] <- "B"
    colnames(datas)[3] <- "C"
    colnames(datas)[4] <- "D"
    colnames(datas)[5] <- "E"
    colnames(datas)[6] <- "F"
    colnames(datas)[7] <- "G"
    colnames(datas)[8] <- "H"
    print(datas)
    return(datas)
    
    
  }
  else{
    return("")
  }
  
  
}

# widok 3

cimdiff3 <- function(mean1, mean2, sd1, sd2, n1, n2) {
  return((mean1 - mean2) - abs(qt(0.05 / 2,df = n1 + n2 - 2)) * sqrt((sd1 ^
                                                                        2 / n1) + (sd2 ^ 2 / n2)))
}

lowHigh3 <- function(mean1, mean2, sd1, sd2, n1, n2) {
  return((mean1 - mean2) + abs(qt(0.05 / 2,df = n1 + n2 - 2)) * sqrt((sd1 ^
                                                                        2 / n1) + (sd2 ^ 2 / n2)))
}

tval3 <- function (mean1, mean2, sd1, sd2, n1, n2) {
  return((mean1 - mean2) / (sqrt(((((n1 - 1) * sd1 ^ 2) + ((n2 - 1) * sd2 ^
                                                             2)
  ) / (
    n1 + n2 - 2
  )) * ((
    1 / n1 + 1 / n2
  )))))
}

df3 <- function(n1, n2) {
  return(n1 + n2 - 2)
}

cohensDs3 <- function(mean1, mean2, sd1, sd2, n1, n2) {
  return(abs((mean1 - mean2) / (sqrt((((n1 - 1) * sd1 ^ 2) + ((n2 - 1) * sd2 ^
                                                                2)
  ) / (
    n1 + n2 - 2
  )))))
}

cohensD3 <- function(mean1, mean2, sd1, sd2, n1, n2) {
  return(abs((mean1 - mean2) / (sqrt((((n1 - 1) * sd1 ^ 2) + ((n2 - 1) * sd2 ^
                                                                2)
  ) / (
    n1 + n2
  )))))
}

hedgesGs3 <- function (cohensDz3, n1, n2) {
  return(cohensDz3 * (1 - (3 / (4 * (
    n2 + n1 - 2
  ) - 1))))
}

clEffectSize3 <- function(mean1, mean2, sd1, sd2) {
  return(clEffectSize(abs(mean1 - mean2) / sqrt(sd1 ^ 2 + sd2 ^ 2)))
}


T_test_Yes_No_Yes_compute <- function(data1,data2) {
  if (!is.null(data1) && !is.null(data2)) {
    v_mean1 <- mean(data1)
    v_mean2 <- mean(data2)
    v_sd1 <- sd(data1)
    v_sd2 <- sd(data2)
    v_n1 <- length(data1)
    v_n2 <- length(data2)
    v_cimdiff3 <- cimdiff3(
      mean1 = v_mean1,
      mean2 = v_mean2,
      sd1 = v_sd1,
      sd2 = v_sd2,
      n1 = v_n1,
      n2 = v_n2
    )
    
    v_lowHigh3 <- lowHigh3(
      mean1 = v_mean1,
      mean2 = v_mean2,
      sd1 = v_sd1,
      sd2 = v_sd2,
      n1 = v_n1,
      n2 = v_n2
    )
    
    v_tval3 <- tval3(
      mean1 = v_mean1,
      mean2 = v_mean2,
      sd1 = v_sd1,
      sd2 = v_sd2,
      n1 = v_n1,
      n2 = v_n2
    )
    
    v_df3 <- df3(n1 = v_n1,
                 n2 = v_n2)
    
    v_p <- pval(df = v_df3,
                tval = v_tval3)
    
    v_cohensDs3 <- cohensDs3(
      mean1 = v_mean1,
      mean2 = v_mean2,
      sd1 = v_sd1,
      sd2 = v_sd2,
      n1 = v_n1,
      n2 = v_n2
    )
    v_cohensD3 <- cohensD3(
      mean1 = v_mean1,
      mean2 = v_mean2,
      sd1 = v_sd1,
      sd2 = v_sd2,
      n1 = v_n1,
      n2 = v_n2
    )
    
    v_hedgesGs3 <- hedgesGs3(cohensDz3 = v_cohensDs3,
                             n1 = v_n1,
                             n2 = v_n2)
    
    v_clEffectSize3 <- clEffectSize3(
      mean1 = v_mean1,
      mean2 = v_mean2,
      sd1 = v_sd1,
      sd2 = v_sd2
    )
    
    datas <- data.frame(
      c('Mean group 1','SD group 1','n group 1',''),
      c(v_mean1,v_sd1,v_n1,''),
      c('Mean group 2','SD group 2','n group 2','p'),
      c(v_mean2,v_sd2,v_n2,v_p),
      c('95% CI Mdiff','[Low; High]','t','df'),
      c(v_cimdiff3,v_lowHigh3,v_tval3,v_df3),
      c('Cohens ds','Cohens d','Hedges gs','CL effect size'),
      c(v_cohensDs3,v_cohensD3,v_hedgesGs3,v_clEffectSize3)
    )
    
  }
  else{
    datas <- data.frame()
  }
  colnames(datas)[1] <- "A"
  colnames(datas)[2] <- "B"
  colnames(datas)[3] <- "C"
  colnames(datas)[4] <- "D"
  colnames(datas)[5] <- "E"
  colnames(datas)[6] <- "F"
  colnames(datas)[7] <- "G"
  colnames(datas)[8] <- "H"
  return(datas)
  
}