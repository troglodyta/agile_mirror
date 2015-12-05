library("RUnit")

#To run test
#setwd("C:/Users/Daniel/Desktop/Programy/agile/src/DeployR")
#runTestFile('helper.test.R')


test.cohensDz <- function() {
  checkEquals(cohensDz(n = 10, tval = 4.74341649), 1.5)
  checkEquals(cohensDz(n = 10, tval = 0.0), 0)
  checkException(cohensDz(n = 0, tval = 4.74341649))
}

test.clEffectSize <- function() {
  checkEquals(clEffectSize(0), 0.5)
  checkEquals(clEffectSize(1.5), 0.933192799)
}

test.computeR <- function() {
  checkEquals(computeR(c(1,2,3), c(4,5,6)), 0.72554232)
}








