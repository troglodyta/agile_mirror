#! /usr/bin/env Rscript

shinyapps::setAccountInfo(name='agile2015',
                          token='9473BA7423C35A47B97AD199108456AD',
                          secret='1jAXKNKweZ38GKPeKvJY9d/R55AGTlu6FEzC6XJZ')
library(shinyapps)
#zmien path na swoj
shinyapps::deployApp('./src/DeployR')



