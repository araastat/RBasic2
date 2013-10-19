# Initialization of R for workshop

options(repository='http://cran.rstudio.org') # globally set repository

have.packages <- installed.packages()


# Installing packages available in CRAN
cran.packages <- c("plyr","data.table","sqldf","RSQLite","RODBC",
                   "Hmisc","reshape2",
                   "caret","mlbench","rms","gdata","tm","randomForest",
                   "knitr","pander","R2HTML","ascii","xtable",
                   "ggplot2","googleVis")
if(.Platform$OS.type=='windows'){
  cran.packages <- c(cran.packages,'RDCOMClient','R2wd')
} else {
  cran.packages <- c(cran.packages,'RMySQL')
}
to.install <- setdiff(cran.packages, have.packages[,1])
if(length(to.install)>0) install.packages(to.install)

# Installing developmental packages made available by authors on GitHub

if(!('devtools' %in% have.packages)) install.packages("devtools")

library(devtools)
ramnath.packages <- c('rCharts')
for(p in ramnath.packages) {
  if(!(p %in% have.packages)) install_github(p, 'ramnathv')
}

# Load packages into this R session

pkg.to.load <- c(cran.packages, ramnath.packages)
for(p in pkg.to.load) eval(substitute(library(pkg), list(pkg=p)))