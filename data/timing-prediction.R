#load files
source('./import-GDMO.R')
source('./import-GDLS.R')

# Add FBA timing data
FBAtimings <- read.csv("./FBAtimings.csv")
FBAtimings$FBAtime=FBAtimings$time
FBAtime=aggregate(FBAtime~strain,FBAtimings[,c('strain','FBAtime')],mean)
GDMO=merge(GDMO,FBAtime)