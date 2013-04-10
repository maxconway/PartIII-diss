#load files
source('./import-GDMO.R')
source('./import-GDLS.R')
#massage data. Ideally this would use regex over environment
geo_s_react.GDMO.100.100..AspireDesktop$pop=100
geo_s_react.GDMO.20.20..AspireDesktop$pop=20
geo_s_react.GDMO.500.500..AspireDesktop$pop=500
iaf1260.ac.GDMO.100.100..AspireDesktop$pop=100
iaf1260.ac.GDMO.20.20..AspireDesktop$pop=20
iaf1260.ac.GDMO.500.500..AspireDesktop$pop=500
geo_s_react.GDMO.100.100..AspireDesktop$strain='sulfurreducens'
geo_s_react.GDMO.20.20..AspireDesktop$strain='sulfurreducens'
geo_s_react.GDMO.500.500..AspireDesktop$strain='sulfurreducens'
iaf1260.ac.GDMO.100.100..AspireDesktop$strain='iaf1260_ac'
iaf1260.ac.GDMO.20.20..AspireDesktop$strain='iaf1260_ac'
iaf1260.ac.GDMO.500.500..AspireDesktop$strain='iaf1260_ac'
GDMOs=list(geo_s_react.GDMO.100.100..AspireDesktop,
       geo_s_react.GDMO.20.20..AspireDesktop,
       geo_s_react.GDMO.500.500..AspireDesktop,
       iaf1260.ac.GDMO.100.100..AspireDesktop,
       iaf1260.ac.GDMO.20.20..AspireDesktop,
       iaf1260.ac.GDMO.500.500..AspireDesktop)
GDMO=NULL
for(g in GDMOs){
  g$V12=NULL
  g$gentime=g$cputime-c(rep(0,g$pop[1]),head(g$cputime,-g$pop[1]))
  g$soltime=g$gentime/g$pop
  GDMO=rbind(GDMO,g)
}

# Add FBA timing data
FBAtimings <- read.csv("./FBAtimings.csv")
FBAtimings$FBAtime=FBAtimings$time
FBAtime=aggregate(FBAtime~strain,FBAtimings[,c('strain','FBAtime')],mean)
GDMO=merge(GDMO,FBAtime)