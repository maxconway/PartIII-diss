to<-c('iaf1260-ac','iJO1366-aerobic','iJO1366-anaerobic','metallireducens','sulfurreducens')
from<-c('iaf1260-ac','iJO1366_Ecoli_suc_aerobic','iJO1366_Ecoli_suc_anaerobic','geo_m_react','geo_s_react')
glossary<-data.frame(to,from)

NameLookup <- function(string){
  string<-as.character(string)
if(string %in% glossary$to){
  return(glossary[glossary$to==string,'from'])
}
if(string %in% glossary$from){
  return(glossary[glossary$from==string,'t0'])
}
}