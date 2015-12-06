library("RUnit")

#To run test
#setwd("C:/Users/Daniel/Desktop/Programy/agile/src/DeployR")
#runTestFile('helper.test.R')

# widok 1
test.cohensDz <- function() {
  checkEquals(cohensDz(n = 10, tval = 4.74341649), 1.5)
  checkEquals(cohensDz(n = 10, tval = 0.0), 0)
  checkException(cohensDz(n = 0, tval = 4.74341649))
}

test.clEffectSize <- function() {
  checkEquals(clEffectSize(0), 0.5)
  checkEquals(clEffectSize(1.5), 0.933192799)
}

# widok 2

test.computeR <- function() {
  checkEquals(computeR(c(1,2,3), c(4,5,6)), 0.72554232)
}

test.mDiff <- function() {
  checkEquals(mDiff(8.7,7.7),1)
}

test.sDiff <- function() {
  checkEquals(sDiff(sd1 = 0.823272602,
                    sd2 = 0.948683298,
                    r = 0.72554232),
              0.666666667)
}

test.SEdiff <- function() {
  checkEquals(SEdiff(
    sd1 = 0.823272602,
    sd2 = 0.948683298,
    n = 10,
    r = 0.72554232
  ),
  0.210818511)
}

test.CIMdiff <- function() {
  checkEquals(CIMdiff(
    Mdiff = 1,
    SEdiff = 0.210818511,
    n = 10
  ),
  0.5231,
  tolerance = 0.001)
  
}

test.lowHigh <- function() {
  checkEquals(lowHigh(
    Mdiff = 1,
    SEdiff = 0.210818511,
    n = 10
  ),
  1.4769,
  tolerance = 0.001)
}

test.pval <- function() {
  checkEquals(pval(df = 9,
                tval = 4.74341649),
              0.00,
              tolerance = 0.01)
}

test.cohensDz2 <- function() {
  checkEquals(cohensDz2(Mdiff = 1,
                        Sdiff = 0.666666667),
              1.5)
}

test.cohensDrm <- function() {
  checkEquals(cohensDrm(cohensDz2 = 1.5,
                        r = 0.72554232),
              1.111332336)
}

test.hedgesGrm <- function() {
  checkEquals(hedgesGrm(cohensDrm = 1.111332336,
                        n = 10),
              1.016075279)
}

test.cohensDav <- function() {
  checkEquals(cohensDav(mDiff = 1,
                        sd1 = 0.823272602,
                        sd2 = 0.948683298),
              1.125879938)
}

test.hedgesGav <- function() {
  checkEquals(hedgesGav(cohensDav = 1.125879938,
                        n = 10),
              1.029375943)
}

test.rec_value <- function() {
  checkEquals(
    rec_value(
      mean1 = 8.7,
      mean2 = 7.7,
      sd1 = 0.823272602,
      sd2 = 0.948683298,
      n = 10,
      val = 1.111332336
      
    ),
    0.014547601,
    tolerance = 0.00001
  )
  checkEquals(
    rec_value(
      mean1 = 8.7,
      mean2 = 7.7,
      sd1 = 0.823272602,
      sd2 = 0.948683298,
      n = 10,
      val = 1.125879938
    ),
    0.0,
    tolerance = 0.00001
  )
}

test.recommended <- function() {
  checkEquals(
    recommended(
      cohensDav = 1.111332336,
      cohensDrm = 1.125879938,
      mean1 = 8.7,
      mean2 = 7.7,
      sd1 = 0.823272602,
      sd2 = 0.948683298,
      n = 10
    ),
    'Grm'
  )
  checkEquals(
    recommended(
      cohensDav = 1.111332336,
      cohensDrm = 1.111332336,
      mean1 = 8.7,
      mean2 = 7.7,
      sd1 = 0.823272602,
      sd2 = 0.948683298,
      n = 10
    ),
    'Gav'
  )
  checkEquals(
    recommended(
      cohensDrm = 1.111332336,
      cohensDav = 1.125879938,
      mean1 = 8.7,
      mean2 = 7.7,
      sd1 = 0.823272602,
      sd2 = 0.948683298,
      n = 10
    ),
    'Gav'
  )
}

test.clEffectSize2 <- function() {
  checkEquals(clEffectSize2(mDiff = 1,
                            sDiff = 0.666666667),
              0.933192799)
}

test.t <- function() {
  checkEquals(t(mDiff = 1,
                sDiff = 0.666666667,
                n = 10),
              4.74341649)
}
